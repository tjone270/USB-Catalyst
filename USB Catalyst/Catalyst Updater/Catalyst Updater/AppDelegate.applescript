--
--  AppDelegate.applescript
--  CatalystUpdater
--
--  Created by Thomas Jones on 20/09/2014.
--  Copyright (c) 2014 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	
	property UPDupdateWindow : missing value
	property UPDupdateProgressUp : missing value
	property UPDupdateProgressDown : missing value
	property UPDupdateLabelUp : missing value
	property UPDupdateLabelDown : missing value
	
	global currentVersion, latestVersion, pathToCatalyst, applicationCanRun, title
	on applicationDidFinishLaunching:aNotification
		setVariables()
		tell UPDupdateWindow to makeKeyAndOrderFront:me
		activate
		tell UPDupdateProgressUp to startAnimation:me
		tell UPDupdateProgressDown to startAnimation:me
		tell UPDupdateLabelUp to setStringValue:("USB Catalyst is updating to version " & latestVersion & " from version " & currentVersion & ". Please be patient...")
		tell UPDupdateLabelDown to setStringValue:("Installing update (3/3)")
		continueUpdate()
	end applicationDidFinishLaunching:
	
	on continueUpdate()
		try
			do shell script "killall USB\\ Catalyst"
			do shell script "rm -rf \"" & pathToCatalyst & "/USB Catalyst.app\""
			do shell script "cp -rf /tmp/USB\\ Catalyst.app \"" & pathToCatalyst & "\""
			do shell script "rm -rf /tmp/USB\\ Catalyst.app"
			do shell script "defaults write com.tomtecsolutions.USB-Catalyst ApplicationIsUpdate 1"
			tell UPDupdateProgressUp to setDoubleValue:4
			tell UPDupdateLabelDown to setStringValue:("Completed! Opening new version...")
			delay 1
			do shell script "open \"" & pathToCatalyst & "/USB Catalyst.app\""
			try
				do shell script "defaults delete com.tomtecsolutions.USB-Catalyst currentVersion"
				do shell script "defaults delete com.tomtecsolutions.USB-Catalyst latestVersion"
				do shell script "defaults delete com.tomtecsolutions.USB-Catalyst pathToCatalyst"
				do shell script "defaults delete com.tomtecsolutions.USB-Catalyst applicationCanRun"
			end try
            try
                do shell script "rm /tmp/CatalystUpdater.app"
            end try
			do shell script "killall CatalystUpdater"
		on error errorString
			display dialog errorString
			display alert title message "An error occurred whilst updating USB Catalyst." buttons {"Quit"} default button 1 as critical
			do shell script "killall CatalystUpdater"
		end try
	end continueUpdate
	
	on setVariables()
		set title to "Catalyst Updater"
		try
			set pathToCatalyst to do shell script "defaults read com.tomtecsolutions.USB-Catalyst pathToCatalyst"
			set currentVersion to do shell script "defaults read com.tomtecsolutions.USB-Catalyst currentVersion"
			set latestVersion to do shell script "defaults read com.tomtecsolutions.USB-Catalyst latestVersion"
			set applicationCanRun to do shell script "defaults read com.tomtecsolutions.USB-Catalyst applicationCanRun"
			if applicationCanRun is "0" then
				display alert title message title & " is not intended to run this way." buttons {"Quit"} default button 1 as critical
				try
					do shell script "rm /tmp/CatalystUpdater.app"
				end try
				try
					do shell script "killall CatalystUpdater"
				end try
			end if
		on error
			display alert title message title & " cannot run." buttons {"Quit"} default button 1 as critical
			try
				do shell script "rm /tmp/CatalystUpdater.app"
			end try
			try
				do shell script "killall CatalystUpdater"
			end try
		end try
	end setVariables
	
	on applicationShouldTerminate:sender
		return current application's NSTerminateNow
	end applicationShouldTerminate:
end script
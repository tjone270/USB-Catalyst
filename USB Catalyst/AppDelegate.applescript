--
--  AppDelegate.applescript
--  USB Catalyst
--
--  Created by Thomas Jones on 1/09/2014.
--  Copyright (c) 2014 TomTec Solutions. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
	global title
	
	-- Master Window Definition
	property mainWindow : missing value
	
	-- Update Window Definitions/Declarations
	--property updateWindow : missing value
	--property updateTopLabel : missing value
	--property updateBottomLabel : missing value
	--property updateProgress : missing value
	--property updateProgressIndeterminate : missing value
	global latestVersion, currentVersion, returnedButton
	
	-- Green Glasswell Definitions
	property glasswellGreen1 : missing value
	property glasswellGreen2 : missing value
	property glasswellGreen3 : missing value
	property glasswellGreen4 : missing value
	property glasswellGreen5 : missing value
	property glasswellGreen6 : missing value
	property glasswellGreen7 : missing value
	property glasswellGreen8 : missing value
	
	-- Navigation Button Definitions
	property nextButton : missing value
	property previousButton : missing value
	
	-- Glasswell Variables
	global glasswellList
	property glasswellInteger : 1
	
	-- Master Switching View
	property mainTabview : missing value
	
	-- Update Variables
	property tomTecSolutionsDomain : "tomtecsolutions.com"
	property tomTecSolutionsLatestVersionTXT : "http://tomtecsolutions.com/catalyst/application/latestversion"
	property tomTecSolutionsCatalystPath : "http://tomtecsolutions.com/catalyst/application/latest.zip"
	
	-- Local System Information Declarations
	global lclVersion, lclSysInfo
	
	-- Source Declarations
	global sourceType, pathToSource, pathToESD
	
	-- OS Selection Radio Buttons Definitions/Declarations
	property radio_Lion : missing value
	property radio_MountainLion : missing value
	property radio_Mavericks : missing value
	property radio_Yosemite : missing value
	global OS_Selected
	
	-- Tab 3 Labels
	property t3l1 : missing value
	property t3l2 : missing value
	property t3l3 : missing value
	
	-- Update Button
	property updateButton : missing value
	
	-- Auto Detect Button
	property autoDetectSourceButton : missing value
	
	-- Local Paths
	global pathToMe, pathToResources, pathToApplication
	
	on radioLionPushed:sender
		tell nextButton to setEnabled:1
		set OS_Selected to "Lion"
	end radioLionPushed:
	
	on radioMountainLionPushed:sender
		tell nextButton to setEnabled:1
		set OS_Selected to "Mountain Lion"
	end radioMountainLionPushed:
	
	on radioMavericksPushed:sender
		tell nextButton to setEnabled:1
		set OS_Selected to "Mavericks"
	end radioMavericksPushed:
	
	on radioYosemitePushed:sender
		tell nextButton to setEnabled:1
		set OS_Selected to "Yosemite"
	end radioYosemitePushed:
	
	on applicationWillFinishLaunching:aNotification
		activate
		setVariables()
		--checkIfUpdatePerformed()
		--checkForUpdates("Passive")
		tell glasswellGreen1 to setHidden:0
	end applicationWillFinishLaunching:
	
	(*
	on checkIfUpdatePerformed()
		try
			set isUpdate to do shell script "defaults read com.tomtecsolutions.USB-Catalyst ApplicationIsUpdate"
		on error
			set isUpdate to "0"
		end try
		
		if isUpdate contains "1" then
			try
				do shell script "killall Catalyst\\ Updater"
				do shell script "rm /tmp/CatalystUpdater.app"
				do shell script "defaults write com.tomtecsolutions.USB-Catalyst ApplicationIsUpdate 0"
				display alert title message "USB Catalyst has successfully updated to version " & (version of current application) & "!"
			end try
			
		end if
	end checkIfUpdatePerformed
	*)
	
	on autoDetectSource:sender
		tell autoDetectSourceButton to setEnabled:0
		set pathToSource to ""
		set ApplicationsFolder to (do shell script "ls /Applications")
		if ApplicationsFolder contains "Install Mac OS X Lion.app" then
			set sourceType to "Application"
			set pathToSource to "/Applications/Install Mac OS X Lion.app"
			set pathToESD to pathToSource & "/Contents/SharedSupport/InstallESD.dmg"
		else if ApplicationsFolder contains "Install OS X Mountain Lion.app" then
			set sourceType to "Application"
			set pathToSource to "/Applications/Install OS X Mountain Lion.app"
			set pathToESD to pathToSource & "/Contents/SharedSupport/InstallESD.dmg"
		else if ApplicationsFolder contains "Install OS X Mavericks.app" then
			set sourceType to "Application"
			set pathToSource to "/Applications/Install OS X Mavericks.app"
			set pathToESD to pathToSource & "/Contents/SharedSupport/InstallESD.dmg"
		else if ApplicationsFolder contains "Install OS X Yosemite.app" then
			set sourceType to "Application"
			set pathToSource to "/Applications/Install OS X Yosemite.app"
			set pathToESD to pathToSource & "/Contents/SharedSupport/InstallESD.dmg"
		end if
		
		if pathToSource is not "" then
			tell t3l2 to setStringValue:(pathToSource as string)
			tell t3l3 to setStringValue:"Found Installer in the Applications folder."
			tell nextButton to setEnabled:1
		else
			tell t3l3 to setStringValue:"Auto Detection failed. Please manually locate your installer."
			tell selectSourceManuallyButton to setHidden:0
		end if
	end autoDetectSource:
	
	on next:sender
		set glasswellInteger to glasswellInteger + 1
		tell (item glasswellInteger of glasswellList) to setHidden:0
		tell mainTabview to selectNextTabViewItem:me
		-- Insert Button Exceptions Here
		if glasswellInteger is 8 then
			tell nextButton to setEnabled:0
		end if
		if glasswellInteger is 2 then
			tell previousButton to setEnabled:1
		end if
	end next:
	
	on previous:sender
		tell (item glasswellInteger of glasswellList) to setHidden:1
		set glasswellInteger to glasswellInteger - 1
		tell (item glasswellInteger of glasswellList) to setHidden:0
		tell mainTabview to selectPreviousTabViewItem:me
		-- Insert Button Exceptions Here
		if glasswellInteger is 1 then
			tell previousButton to setEnabled:0
		end if
		if glasswellInteger is 7 then
			tell nextButton to setEnabled:1
		end if
	end previous:
	
	on getHelpMenuItem:sender
		open location "mailto:support@tomtecsolutions.com"
	end getHelpMenuItem:
	
	on getHelpButton:sender
		open location "mailto:support@tomtecsolutions.com"
	end getHelpButton:
	
	(*
	on checkForUpdatesButton:sender
		checkForUpdates("Active")
	end checkForUpdatesButton:
	
	on checkForUpdatesMenuItem:sender
		checkForUpdates("Active")
	end checkForUpdatesMenuItem:
	*)
	 
	(*
	on checkForUpdates(typeOfChecking)
		set currentVersion to the version of the current application
		set returnedButton to ""
		try
			do shell script "ping -o -t 1 tomtecsolutions.com"
			set latestVersion to do shell script "curl " & tomTecSolutionsLatestVersionTXT
			if typeOfChecking is "Active" then
				if latestVersion is currentVersion then
					display alert "You are up-to-date!" message "USB Catalyst is up-to-date." & return & return & "Current Version: " & currentVersion
				end if
			end if
		on error
			set latestVersion to currentVersion
			if typeOfChecking is "Active" then
				display alert title message "USB Catalyst was unable to check for updates. Please ensure you have an active internet connection, and try again." as critical
			end if
		end try
		if latestVersion is not currentVersion then
			if typeOfChecking is "Passive" then
				tell updateButton to setTitle:"Update Available"
			else
				display alert "Update Available" message "An update is available for USB Catalyst." & return & return & "Current Version: " & currentVersion & return & "Latest Version: " & latestVersion buttons {"Update Later", "Update Now"} default button 2
				set returnedButton to button returned of the result
			end if
		end if
		if returnedButton is "Update Now" then
            performUpdate()
        end if
	end checkForUpdates
	*)
	
	(*
    on performUpdate()
        tell mainWindow to orderOut:me
        try
            do shell script "rm -rf /tmp/USB\\ Catalyst.app"
        end try
        tell updateWindow to makeKeyAndOrderFront:me
        delay 1
        tell updateTopLabel to setStringValue:("USB Catalyst is updating to version " & latestVersion & " from version " & currentVersion & ". Please be patient...")
        tell updateProgressIndeterminate to startAnimation:me
        tell updateProgress to startAnimation:me
        tell updateProgress to setDoubleValue:2
        tell updateBottomLabel to setStringValue:"Downloading latest package (1/3)"
        delay 1
        try
            do shell script "curl " & tomTecSolutionsCatalystPath & " -o /tmp/catalyst.zip"
			on error
            display alert title message "Something went wrong with the update. USB Catalyst has not been touched."
            error
        end try
        tell updateBottomLabel to setStringValue:"Extracting package (2/3)"
        delay 1
        tell updateProgress to setDoubleValue:3
        do shell script "/System/Library/CoreServices/Archive\\ Utility.app/Contents/MacOS/Archive\\ Utility /tmp/catalyst.zip"
        activate
        do shell script "rm /tmp/catalyst.zip"
        tell application "Finder" to close Finder window 1
        delay 1
        tell updateBottomLabel to setStringValue:"Running updater (3/3)"
        --do shell script "touch ~/Library/Preferences/com.tomtecsolutions.USB-Catalyst.updatePermitted"
        do shell script "defaults write com.tomtecsolutions.USB-Catalyst pathToCatalyst \"" & pathToApplication & "\""
        --tell updateProgress to setDoubleValue:4
        delay 1
        do shell script "defaults write com.tomtecsolutions.USB-Catalyst currentVersion '" & currentVersion & "'"
        do shell script "defaults write com.tomtecsolutions.USB-Catalyst latestVersion '" & latestVersion & "'"
        try
            do shell script "rm -rf /tmp/CatalystUpdater.app"
        end try
        do shell script "cp -r \"" & pathToMe & "/Contents/Resources/CatalystUpdater.app\" /tmp"
        try
            activate
            --display alert title message "USB Catalyst will now open Terminal to complete the update, then re-open when the process is complete." & return & return & "Please DO NOT quit Terminal during this process, it will quit automatically."
            do shell script "defaults write com.tomtecsolutions.USB-Catalyst applicationCanRun 1"
            if pathToMe contains ("/Users/" & (do shell script "whoami") & "/") then
                do shell script "open /tmp/CatalystUpdater.app"
				else
                do shell script "open /tmp/CatalystUpdater.app" with administrator privileges
            end if
			on error
            do shell script "rm -rf /tmp/USB\\ Catalyst.app"
            --do shell script "rm ~/Library/Preferences/com.tomtecsolutions.USB-Catalyst.updatePermitted"
            activate
            display alert "Error Occurred" message "Administrator privileges are required to update USB Catalyst.app while it's in this location." as critical
        end try
        tell updateWindow to orderOut:me
    end performUpdate 
	*)
	
	on setVariables()
		set glasswellList to {glasswellGreen1, glasswellGreen2, glasswellGreen3, glasswellGreen4, glasswellGreen5, glasswellGreen6, glasswellGreen7, glasswellGreen8}
		set title to "USB Catalyst"
		set lclSysInfo to system info
		set lclVersion to system version of lclSysInfo
		set pathToMe to current application's NSBundle's mainBundle()'s bundlePath() as string
		(*
		if pathToMe does not contain "USB Catalyst.app" then
			display alert title message "This application seems to have been renamed. It MUST be called USB Catalyst.app in order to function properly. Please rename this software." buttons {"Quit"} default button 1 as critical
			do shell script "killall USB\\ Catalyst"
		end if
		*)
		set pathToApplication to SearchReplace(pathToMe, "USB Catalyst.app", "") as string
		set pathToResources to current application's NSBundle's mainBundle()'s resourcePath() as string
	end setVariables
	
	on SearchReplace(sourceStr, searchString, replaceString)
		-- replace <searchString> with <replaceString> in <sourceStr>
		set searchStr to (searchString as text)
		set replaceStr to (replaceString as text)
		set sourceStr to (sourceStr as text)
		set saveDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to (searchString)
		set theList to (every text item of sourceStr)
		set AppleScript's text item delimiters to (replaceString)
		set theString to theList as string
		set AppleScript's text item delimiters to saveDelims
		return theString
	end SearchReplace
	
	on applicationShouldTerminate:sender
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate:
	
	on applicationShouldTerminateAfterLastWindowClosed_(sender)
	  return true
	end applicationShouldTerminateAfterLastWindowClosed_
	
end script
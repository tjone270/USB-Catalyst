//
//  main.m
//  USB Catalyst
//
//  Created by Thomas Jones on 1/09/2014.
//  Copyright (c) 2014 TomTec Solutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[])
{
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    NSLog (@"\nUSB Catalyst has launched. \n\nThis software is my best work (I'm 15). \n\nRing me if you want, my number is below, be interesting to get a call :)\n\nP: +61 7 5641 1108\nE: thomas@tomtecsolutions.com\n\n------ Thomas Jones ------ TomTec Solutions ------\n================================================================================\n\n");
    return NSApplicationMain(argc, argv);
}

//
//  main.m
//  chakrad
//
//  Created by bedtime on 10/26/22.
//

#import <CoreFoundation/CoreFoundation.h>
#import <Cocoa/Cocoa.h>
#import "Inject.h"

int main(int argc, const char * argv[])
{
    // Injects every
    @autoreleasepool
    {
        for (NSRunningApplication *app in [[NSWorkspace sharedWorkspace] runningApplications])
        {
            inject_sync(app.processIdentifier, "/Library/GlowSupport/glow.dylib");
        }
        
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserverForName: @"NSWorkspaceDidActivateApplicationNotification" object:nil queue:nil usingBlock:^(NSNotification * note)
        {
            NSRunningApplication* app = [note userInfo][NSWorkspaceApplicationKey];
            inject_sync(app.processIdentifier, "/Library/GlowSupport/glow.dylib");
        }];
        
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserverForName: @"NSWorkspaceDidLaunchApplicationNotification" object:nil queue:nil usingBlock:^(NSNotification * note)
        {
            NSRunningApplication* app = [note userInfo][NSWorkspaceApplicationKey];
            inject_sync(app.processIdentifier, "/Library/GlowSupport/glow.dylib");;
        }];
        
        CFRunLoopRun();
    }
    
    return 0;
}

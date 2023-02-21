//
//  main.m
//  chakrad
//
//  Created by bedtime on 10/26/22.
//

#import <CoreFoundation/CoreFoundation.h>
#import <Cocoa/Cocoa.h>
#import "Inject.h"


void inj(NSRunningApplication *app)
{
    NSLog(@"@found nsrunningapp");
    #if defined(__x86_64__) // Injector is running as Intel, only inject intel processes.
    if (app.executableArchitecture == NSBundleExecutableArchitectureX86_64)
    {
        NSLog(@"@found intel proc, inj'ing.");
        inject(app.processIdentifier, "/Library/GlowSupport/glow.dylib");
    }
    #elif defined(__arm64__) // Injector is running as Arm, only inject arm processes.
    if (app.executableArchitecture == NSBundleExecutableArchitectureARM64)
    {
        NSLog(@"@found arm proc, inj'ing.");
        inject(app.processIdentifier, "/Library/GlowSupport/glow.dylib");
    }
    #endif
}

int main(int argc, const char * argv[])
{
    // Injects every
    @autoreleasepool
    {
        for (NSRunningApplication *app in [[NSWorkspace sharedWorkspace] runningApplications])
        {
            inj(app);
        }
        
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserverForName: @"NSWorkspaceDidActivateApplicationNotification" object:nil queue:nil usingBlock:^(NSNotification * note)
        {
            NSRunningApplication* app = [note userInfo][NSWorkspaceApplicationKey];
            inj(app);
        }];
        
        [[[NSWorkspace sharedWorkspace] notificationCenter] addObserverForName: @"NSWorkspaceDidLaunchApplicationNotification" object:nil queue:nil usingBlock:^(NSNotification * note)
        {
            NSRunningApplication* app = [note userInfo][NSWorkspaceApplicationKey];
            inj(app);
        }];
        
        CFRunLoopRun();
    }
    
    return 0;
}

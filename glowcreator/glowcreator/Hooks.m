//
//  Hooks.m
//  glowcreator
//
//  Created by bedtime on 2/16/23.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Swizzle.h"

extern CGError SLSSetWindowBackgroundBlurRadius(int cid, uint32_t wid, uint32_t radius);
extern int CGSMainConnectionID(void);

hook(NSThemeFrame)
    -(double)_titlebarHeight { return 47; }
    -(double)_titlebarHeight2 { return 47; }
    -(BOOL)_shouldCenterTrafficLights { return YES; }
endhook

hook(NSWindow)
    -(id)init
    {
        self = ZKOrig(id);
        [(NSWindow *)self setAlphaValue:0.9];
        SLSSetWindowBackgroundBlurRadius(CGSMainConnectionID(), [(NSWindow *)self windowNumber], 10);
        return self;
    }
endhook

/*
hook(NSWindow)
    -(NSUserInterfaceLayoutDirection)windowTitlebarLayoutDirection
    {
        return NSUserInterfaceLayoutDirectionRightToLeft;
    }
endhook
*/

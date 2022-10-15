//
//  Dock.m
//  glowengine
//
//  Created by bedtime on 10/14/22.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"

hook(NSScroller)
    +(CGFloat)scrollerWidth
    {
        return 30.0;
    }
endhook

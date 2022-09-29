//
//  Titlebar.m
//  glowengine
//
//  Created by bedtime on 9/26/22.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"

/*
    This file adds titlebar graphics.
*/

BOOL drawHovered = NO;

hook(_NSThemeWidget)
    -(void)viewDidMoveToWindow
    {
        ZKOrig(void);
        [(NSView *)self addTrackingRect:[(NSView *)self bounds] owner:(NSView *)self userData:nil assumeInside:NO];
    }

    -(void)mouseEntered:(NSEvent *)theEvent
    {
        drawHovered = YES;
    }

    - (void)mouseExited:(NSEvent *)theEvent
    {
        drawHovered = NO;
    }

    -(void)mouseMoved:(NSEvent *)theEvent
    {
        drawHovered = YES;
    }

    -(void)drawRect:(CGRect)arg1
    {
        if (drawHovered)
        {
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/%@_On.png", self.className]] drawInRect:arg1];
        } else
        {
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/%@_Off.png", self.className]] drawInRect:arg1];
        }
    }
endhook

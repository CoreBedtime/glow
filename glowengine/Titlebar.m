//
//  Titlebar.m
//  glowengine
//
//  Created by bedtime on 9/26/22.
//
//  Very messy. Needs cleanup.

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"


BOOL drawHovered = NO;

@interface NSObject (Titlebars)
    -(NSArray *)subviews;
    -(BOOL)wantsLayer;
    -(BOOL)isSpace;
    -(void)setWantsLayer:(BOOL)arg1;
    -(CALayer *)layer;
@end

hook(_NSThemeWidget)
    -(void)viewDidMoveToWindow
    {
        ZKOrig(void);
        [(NSView *)self addTrackingRect:[(NSView *)self bounds] owner:(NSView *)self userData:nil assumeInside:NO];
    }

    -(void)mouseEntered:(NSEvent *)theEvent { drawHovered = YES; }
    -(void)mouseMoved:(NSEvent *)theEvent   { drawHovered = YES; }
    -(void)mouseExited:(NSEvent *)theEvent  { drawHovered = NO;  }

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

hook(NSTitlebarView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        // A bit hacky but good solution
        if ((NSView *)self.subviews[0])
        {
            NSView *selfv = (NSView *)self.subviews[0];
            NSView *effectView = [NSView new];
            [selfv addSubview:effectView];
            effectView.translatesAutoresizingMaskIntoConstraints = NO;
            effectView.wantsLayer = YES;
            [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
            [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
            [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
            [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
            effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Titlebar.png"]];
        }
    }
endhook


hook(NSToolbarItemViewer)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        // A bit hacky but good solution
        for (NSView *view in (NSView *)self.subviews)
        {
            if (![self isSpace])
            {
                NSView *selfv = view;
                [selfv setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
                NSView *effectView = [NSView new];
                [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                effectView.translatesAutoresizingMaskIntoConstraints = NO;
                effectView.wantsLayer = YES;
                [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
                [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
                effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Segment.png"]];
            }
        }
    }
endhook

hook(NSClipView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        NSView *selfv = (NSView *)self;
        
        if (selfv.superview.superview.class == objc_getClass("NSVisualEffectView"))
        {
            NSView *effectView = [NSView new];
            [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
            effectView.translatesAutoresizingMaskIntoConstraints = NO;
            effectView.wantsLayer = YES;
            [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
            [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
            [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
            [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
            effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Sidebar.png"]];
        }
    }
endhook

hook(NSVisualEffectView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        NSView *selfv = (NSView *)self;
        
        if (selfv.superview.class == objc_getClass("NSTableRowView"))
        {
            NSView *effectView = [NSView new];
            [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
            effectView.translatesAutoresizingMaskIntoConstraints = NO;
            effectView.wantsLayer = YES;
            [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
            [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
            [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
            [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
            effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/SidebarHighlight.png"]];
        }
    }
endhook


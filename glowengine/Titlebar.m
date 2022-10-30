//
//  Titlebar.m
//  glowengine
//
//  Created by bedtime on 9/26/22.
//
//  Very messy. Needs cleanup.

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"
#import "Utility/Preference.h"

CA_EXTERN NSString * const kCAContentsScalingRepeat;
@interface CALayer (CALayerAdditions)
@property(copy) NSString *contentsScaling;
@end

BOOL drawHovered = NO;
int i = 1000;

@interface NSObject (Titlebars)
    -(NSArray *)subviews;
    -(BOOL)wantsLayer;
    -(BOOL)isSpace;
    -(void)setWantsLayer:(BOOL)arg1;
    -(CALayer *)layer;
@end

@interface NSThemeFrame : NSView
    -(void)setCustomTitlebarHeight:(double)arg1;
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
        ((NSView *)self).translatesAutoresizingMaskIntoConstraints = NO;
        [((NSView *)self).widthAnchor constraintEqualToConstant:[Preference getFloat:"TrafficLightWidth"]].active = YES;
        [((NSView *)self).heightAnchor constraintEqualToConstant:[Preference getFloat:"TrafficLightHeight"]].active = YES;
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
        if (!((NSView *) self).window.titlebarAppearsTransparent)
        {
            
            if ([Preference getBool:"DarkTitlebar"] == YES)
            {
                [((NSView *)self) setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameDarkAqua]];
            } else
            {
                [((NSView *)self) setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];
            }
            
            if ([Preference isAppInBlackListName:"UseDeepTitlebarList"])
            {
                for (NSView *blur in ((NSView *)self).subviews)
                {
                    if (blur.class == objc_getClass("NSVisualEffectView"))
                    {
                        if (blur.subviews.count < 1)
                        {
                            NSView *effectView = [NSView new];
                            [blur addSubview:effectView];
                            effectView.translatesAutoresizingMaskIntoConstraints = NO;
                            effectView.wantsLayer = YES;
                            [effectView.topAnchor constraintEqualToAnchor: blur.topAnchor].active = YES;
                            [effectView.bottomAnchor constraintEqualToAnchor: blur.bottomAnchor].active = YES;
                            [effectView.leftAnchor constraintEqualToAnchor: blur.leftAnchor].active = YES;
                            [effectView.rightAnchor constraintEqualToAnchor: blur.rightAnchor].active = YES;
                            effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Titlebar.png"]];
                            
                            if ([Preference getBool:"TileTitlebar"])
                            {
                                [effectView.layer setContentsScaling:kCAContentsScalingRepeat];
                            }
                        }
                    }
                }
            } else
            {
                if ((NSView *)self.subviews[0])
                {
                    NSView *selfv = (NSView *)self.subviews[0];
                    if (selfv.subviews.count < 1)
                    {
                        NSView *effectView = [NSView new];
                        [selfv addSubview:effectView];
                        effectView.translatesAutoresizingMaskIntoConstraints = NO;
                        effectView.wantsLayer = YES;
                        [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                        [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                        [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
                        [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
                        effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Titlebar.png"]];
                        
                        if ([Preference getBool:"TileTitlebar"])
                        {
                            [effectView.layer setContentsScaling:kCAContentsScalingRepeat];
                        }
                    }
                }
            }
        }
    }
endhook

hook(NSToolbarItemViewer)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);

        for (NSView *view in (NSView *)self.subviews)
        {
            if (![self isSpace])
            {
                if (!(view.class == objc_getClass("NSToolbarLabelStack")) && !(view.class == objc_getClass("NSWidgetView")))
                {
                    if (view.subviews.count < 3)
                    {
                        NSView *selfv = view;
                        NSView *effectView = [NSView new];
                        [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                        effectView.translatesAutoresizingMaskIntoConstraints = NO;
                        effectView.wantsLayer = YES;
                        [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                        [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                        [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor constant:[Preference getFloat:"ToolbarCapInset"]].active = YES;
                        [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor constant:-([Preference getFloat:"ToolbarCapInset"])].active = YES;
                        effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Segment.png"]];
                        
                        effectView = [NSView new];
                        [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                        effectView.translatesAutoresizingMaskIntoConstraints = NO;
                        effectView.wantsLayer = YES;
                        [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                        [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                        [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
                        [effectView.widthAnchor constraintEqualToConstant:[Preference getFloat:"ToolbarCapInset"]].active = YES;
                        effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/LeftSegment.png"]];

                        effectView = [NSView new];
                        [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                        effectView.translatesAutoresizingMaskIntoConstraints = NO;
                        effectView.wantsLayer = YES;
                        [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                        [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                        [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
                        [effectView.widthAnchor constraintEqualToConstant:[Preference getFloat:"ToolbarCapInset"]].active = YES;
                        effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/RightSegment.png"]];
                    }
                }
            }
        }
    }
endhook

hook(NSWindow)
    -(void)update
    {
        ZKOrig(void);
        if (![Preference isAppInBlackListName:"StyleMaskOperationsExclude"])
        {
            ((NSWindow *)self).styleMask = ((NSWindow *)self).styleMask & ~NSWindowStyleMaskFullSizeContentView;
        }
        if (![Preference isAppInBlackListName:"StandardTitlebarHeightExclude"])
        {
            if (!((NSWindow *)self).toolbar)
            {
                if ([(((NSWindow *)self).contentView.superview) isMemberOfClass:NSThemeFrame.class])
                {
                    [(NSThemeFrame *)(((NSWindow *)self).contentView.superview) setCustomTitlebarHeight: [Preference getFloat:"StandardTitlebarHeight"]];
                }
            }
        }
    }
endhook

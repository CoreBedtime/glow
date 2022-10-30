//
//  Titlebar.m
//  glowengine
//
//  Created by bedtime on 9/26/22.
//
//  Very messy. Needs cleanup.

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"

@interface NSObject (Titlebars)
    -(NSArray *)subviews;
    -(BOOL)wantsLayer;
    -(BOOL)isSpace;
    -(void)setWantsLayer:(BOOL)arg1;
    -(CALayer *)layer;
@end

hook(NSVisualEffectView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        NSVisualEffectView *selfv = (NSVisualEffectView *)self;
        
        if (selfv.material == 7)
        {
            if (selfv.subviews.count < 2 )
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
    }
endhook


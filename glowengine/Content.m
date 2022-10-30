//
//  Content.m
//  glowengine
//
//  Created by bedtime on 10/15/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"
#import "Utility/Preference.h"

CA_EXTERN NSString * const kCAContentsScalingRepeat;
@interface CALayer (CALayerAdditions)
@property(copy) NSString *contentsScaling;
@end

hook(NSVisualEffectView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        NSVisualEffectView *selfv = (NSVisualEffectView *)self;
        
        if (selfv.material == 18)
        {
            NSView *effectView = [NSView new];
            [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
            effectView.translatesAutoresizingMaskIntoConstraints = NO;
            effectView.wantsLayer = YES;
            [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
            [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
            [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
            [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
            effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Background.png"]];
            
            if ([Preference getBool:"TileBackground"])
            {
                [effectView.layer setContentsScaling:kCAContentsScalingRepeat];
            }
        }
    }
endhook


hook(NSVisualEffectView)
    -(void)updateTrackingAreas
    {
        ZKOrig(void);
        
        NSVisualEffectView *selfv = (NSVisualEffectView *)self;
        
        if (selfv.material == 12)
        {
            if (!(selfv.superview.class == objc_getClass("NSThemeFrame")))
            {
                if (selfv.subviews.count == 0)
                {
                    NSView *effectView = [NSView new];
                    [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                    effectView.translatesAutoresizingMaskIntoConstraints = NO;
                    effectView.wantsLayer = YES;
                    [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                    [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                    [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
                    [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
                    effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Background.png"]];
                    
                    if ([Preference getBool:"TileBackground"])
                    {
                        [effectView.layer setContentsScaling:kCAContentsScalingRepeat];
                    }

                }
            } else
            {
                NSView *selfv = ((NSView *)self).superview;
                
                if (selfv.subviews.count < 3)
                {
                    NSView *effectView = [NSView new];
                    [selfv addSubview:effectView positioned:NSWindowBelow relativeTo:NULL];
                    effectView.translatesAutoresizingMaskIntoConstraints = NO;
                    effectView.wantsLayer = YES;
                    [effectView.topAnchor constraintEqualToAnchor: selfv.topAnchor].active = YES;
                    [effectView.bottomAnchor constraintEqualToAnchor: selfv.bottomAnchor].active = YES;
                    [effectView.leftAnchor constraintEqualToAnchor: selfv.leftAnchor].active = YES;
                    [effectView.rightAnchor constraintEqualToAnchor: selfv.rightAnchor].active = YES;
                    effectView.layer.contents = [[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Background.png"]];
                    
                    if ([Preference getBool:"TileBackground"])
                    {
                        [effectView.layer setContentsScaling:kCAContentsScalingRepeat];
                    }
                }
            }
        }
    }
endhook





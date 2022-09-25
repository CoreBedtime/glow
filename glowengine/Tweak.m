//
//  Tweak.m
//  glow
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "ZKSwizzle.h"

@interface Main : NSObject {} @end
@implementation Main
    +(void)load
	{
        NSLog(@"Loaded.");
	}
@end

#pragma mark CoreUI

@interface CUIImage : NSObject <NSCopying>
@end

@interface NSObject (CoreUI)
-(id)displayName;
-(void)removeFromSuperview;
@end

hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
    {
        CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData((CFDataRef)[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/%@.png", self.displayName]]);
        struct CGImage *image = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);

        if (image) { return image; } else { return ZKOrig(struct CGImage *, arg1, arg2); }
    }
endhook

hook(_NSTitlebarDecorationView)
    -(void)updateLayer
    {
        [self removeFromSuperview];
    }
endhook

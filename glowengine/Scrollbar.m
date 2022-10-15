//
//  Dock.m
//  glowengine
//
//  Created by bedtime on 10/14/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"

#define HorizontalThumb @"ScrollBarClassic_Thumb_Regular_Horizontal.psd"
#define VerticalThumb @"ScrollBarClassic_Thumb_Regular_Vertical.psd"

@interface NSObject (Window)
    -(id)displayName;
@end

hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
    {
        if ([[self displayName] isEqual: VerticalThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalScroller.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        } else if ([[self displayName] isEqual: HorizontalThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalScroller.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        }
        {
            return ZKOrig(struct CGImage *, arg1, arg2);
        }
    }
endhook

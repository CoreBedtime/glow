//
//  Scrollbar.m
//  glowengine
//
//  Created by bedtime on 10/14/22.
//  Updated by Allan Nyholm Nielsen on 10/24/22.

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"

#define HorizontalNormalResThumb @"ScrollBarClassic_Thumb_Regular_Horizontal.psd"
#define VerticalNormalResThumb @"ScrollBarClassic_Thumb_Regular_Vertical.psd"
#define HorizontalNormalResExpandedThumb @"ScrollBarOverlay_ExpandedThumb_Regular_Horizontal.psd"
#define VerticalNormalResExpandedThumb @"ScrollBarOverlay_ExpandedThumb_Regular_Vertical.psd"
#define HorizontalNormalResOverlayThumb @"ScollbarOverlay_Thumb_Regular_Horizontal.psd"
#define VerticalNormalResOverlayThumb @"ScrollBarOverlay_Thumb_Regular_Vertical.psd"
#define HorizontalHighResThumb @"ScrollBarClassic_Thumb_Regular_Horizontal@2x.psd"
#define VerticalHighResThumb @"ScrollBarClassic_Thumb_Regular_Vertical@2x.psd"
#define HorizontalHighResExpandedThumb @"ScrollBarOverlay_ExpandedThumb_Regular_Horizontal@2x.psd"
#define VerticalHighResExpandedThumb @"ScrollBarOverlay_ExpandedThumb_Regular_Vertical@2x.psd"
#define HorizontalHighResOverlayThumb @"ScollbarOverlay_Thumb_Regular_Horizontal@2x.psd"
#define VerticalHighResOverlayThumb @"ScrollBarOverlay_Thumb_Regular_Vertical@2x.psd"

@interface NSObject (Window)
    -(id)displayName;
@end

hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
{
    if ([[self displayName] isEqual: VerticalNormalResThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    } else if ([[self displayName] isEqual: HorizontalNormalResThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    }
    {}
    {}
    if ([[self displayName] isEqual: VerticalNormalResExpandedThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalExpandScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    } else if ([[self displayName] isEqual: HorizontalNormalResExpandedThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalExpandScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    }
    {
        {}
        if ([[self displayName] isEqual: VerticalNormalResOverlayThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalOverlayScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        } else if ([[self displayName] isEqual: HorizontalNormalResOverlayThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalOverlayScrollbar1x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        }
        {
            return ZKOrig(struct CGImage *, arg1, arg2);
        }
    }
    
}

@end

hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
{
    if ([[self displayName] isEqual: VerticalHighResThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    } else if ([[self displayName] isEqual: HorizontalHighResThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    }
    {}
    {}
    if ([[self displayName] isEqual: VerticalHighResExpandedThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalExpandScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    } else if ([[self displayName] isEqual: HorizontalHighResExpandedThumb])
    {
        NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
        [image lockFocus];
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalExpandScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
        [image unlockFocus];
        CGImageSourceRef source;
        source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
        return CGImageSourceCreateImageAtIndex(source, 0, NULL);
    }
    {
        {}
        if ([[self displayName] isEqual: VerticalHighResOverlayThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/VerticalOverlayScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        } else if ([[self displayName] isEqual: HorizontalHighResOverlayThumb])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/HorizontalOverlayScrollbar2x.png"]] drawInRect:CGRectMake(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        }
        {
            return ZKOrig(struct CGImage *, arg1, arg2);
        }
    }
}
endhook

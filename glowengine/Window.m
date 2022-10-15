//
//  Tweak.m
//  glow
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"

#define WindowMask @"WindowFrame_WindowShapeEdges_Regular.psd"
#define WindowMaskSmall @"WindowFrame_WindowShapeEdges_Small.psd"

@interface NSObject (Window)
    -(id)displayName;
@end

@interface NSView (Private)
    -(void)_lp_setCornerRadius:(double)arg1 continuous:(BOOL)arg2;
@end


/*
    This here makes all windows square.
*/
hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
    {
        if ([[self displayName] isEqual: WindowMask] || [[self displayName] isEqual: WindowMaskSmall])
        {
            NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(23, 23)];
            [image lockFocus];
            [NSColor.blackColor drawSwatchInRect:NSMakeRect(0, 0, 23, 23)];
            [image unlockFocus];
            CGImageSourceRef source;
            source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
            return CGImageSourceCreateImageAtIndex(source, 0, NULL);
        } else
        {
            return ZKOrig(struct CGImage *, arg1, arg2);
        }
    }
endhook

/*
    This here fixes titlebars, due to the window mask being weird.
*/
hook(_NSTitlebarDecorationView)
    -(void)updateLayer
    {
        [(NSView *)self removeFromSuperview];
    }
endhook

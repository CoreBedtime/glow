//
//  Tweak.m
//  glow
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"
#import "Utility/Preference.h"

#define WindowMask @"WindowFrame_WindowShapeEdges_Regular.psd"
#define WindowMask2 @"WindowFrame_WindowShapeEdges_Regular@2x.psd"

@interface CUIThemeFacet : NSObject;
    -(id)displayName;
@end

@interface NSView (Private)
    -(void)setCornerRadius:(double)arg1;
@end


/*
    This here makes all windows square.
*/
hook(CUIThemeFacet)
    -(struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2
    {
        if ([[(CUIThemeFacet *)self displayName] isEqual: WindowMask] || [[(CUIThemeFacet *)self displayName] isEqual: WindowMask2])
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

hook(NSWindow)
    -(BOOL)_cornerMaskShouldDefineShadow
    {
        return NO;
    }

    -(void)update
    {
        ZKOrig(void);
        
        [(NSView *)((NSWindow *)self).contentView.superview setCornerRadius: [Preference getFloat:"WindowRadius"]];
        [((NSWindow *)self) invalidateShadow];
    }
endhook

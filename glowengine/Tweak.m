//
//  Tweak.m
//  glow
//
//  Created by bedtime on 7/1/22.
//

#import <CoreGraphics/CoreGraphics.h>
#import "Utility/ZKSwizzle.h"
#import <objc/runtime.h>
#import <Cocoa/Cocoa.h>
#import "Pref/Pref.h"
#import "CoreUI.h"

#if !defined(ARRAY_SIZE)
    #define ARRAY_SIZE(x) (sizeof((x)) / sizeof((x)[0]))
#endif

typedef int CGSConnectionID;
CG_EXTERN CGSConnectionID CGSMainConnectionID(void);
extern CGError SLSSetWindowBackgroundBlurRadius(int cid, uint32_t wid, uint32_t radius);

/*
    Hook coreUI.
*/


NSDictionary *glowPref;

hook(_CUIThemeEffectRendition)
    -(id)effectPreset
    {
        CUIShapeEffectPreset *me = ZKOrig(id);
        CUIShapeEffectPreset *future = [CUIShapeEffectPreset new];
        
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-: ."];
        NSString *result = [[[[(_CUIRawDataRendition *)self name] lowercaseString] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        NSLog(@"GLOW :: EFFECT :: %@", result);
        
        if (glowPref[@"ThemeColorOverride"][result])
        {
            int r = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][result]].redComponent * 255);
            int g = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][result]].greenComponent * 255);
            int b = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][result]].blueComponent * 255);
            
            
            //for (int i = 0; i < [me _parameterCount]; i++)
            {
                [future addColorFillWithRed:r green:g blue:b opacity:255 blendMode:kCGBlendModeNormal tintable:0];
                [future addShapeOpacityWithOpacity:1];
                [future addOutputOpacityWithOpacity:1];
            }
            
            return future;
        } else
        {
            return me;
        }
    }
endhook




hook(_CUIRawDataRendition)
    -(id)data
    {
        NSDictionary *unarchived = ((NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData: ZKOrig(NSData *)]);
        CALayer *layer;
        CALayer *sublayer;
        
        
        if ([unarchived isKindOfClass:[NSDictionary class]])
        {
            if ([[unarchived objectForKey:@"rootLayer"] isKindOfClass:[CALayer class]])
            {
                NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-: ."];
                NSString *result = [[[[(_CUIRawDataRendition *)self name] lowercaseString] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
                
                NSLog(@"GLOW :: MICA :: %@", result);
                
                NSImage* someImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/Default/%@.png", result]];
                CGImageSourceRef source;

                source = CGImageSourceCreateWithData((CFDataRef)[someImage TIFFRepresentation], NULL);
                struct CGImage *maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
                
                layer = [unarchived objectForKey:@"rootLayer"];
                sublayer = [CALayer new];
                sublayer.contents = (__bridge id _Nullable)(maskRef);
                sublayer.contentsGravity = kCAGravityResize;
                
                if ([glowPref[@"MicaTile"][result] boolValue] == YES)
                {
                    [sublayer setContentsScaling:kCAContentsScalingRepeat];
                }
            }
        }
        
        return [NSKeyedArchiver archivedDataWithRootObject:@{@"rootLayer" : sublayer}];
    }
endhook

hook(_CUIInternalLinkRendition)
    -(struct CGImage *)unslicedImage
    {
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"_-: ."];
        NSString *result = [[[[(_CUIInternalLinkRendition *)self name] lowercaseString] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        
        NSImage* someImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/Default/%@.png", result]];
        CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[someImage TIFFRepresentation], NULL);
        struct CGImage *maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
        
        NSLog(@"GLOW :: PNG :: %@", result);
        
        if (maskRef)
            return maskRef;
        
        return ZKOrig(struct CGImage *);
    }
endhook

hook(CUICommonAssetStorage)
    -(BOOL)getColor:(struct _colordef *)color forName:(const char *)name
    {
        BOOL orig = ZKOrig(BOOL, color, name);
        
        if (glowPref[@"ThemeColorOverride"][@(name)])
        {
            int r = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].redComponent * 255);
            int g = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].greenComponent * 255);
            int b = (int)([NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].blueComponent * 255);
            
            color->value.r = (char)r;
            color->value.g = (char)g;
            color->value.b = (char)b;
            color->value.a = (char)255;
            
            
        }
        
        
        NSLog(@"GLOW :: COLOR :: %s", name);
        
        
        return orig;
    }
endhook




/*
    Hook Cocoa
*/

hook(NSWindow)

    -(BOOL)opaque
    {
        return NO;
    }

    -(id)shadowParameters
    {
        NSMutableDictionary *params = ZKOrig(NSMutableDictionary *);
        
        if ([params respondsToSelector:@selector(setObject:forKey:)]) // We may not have mutable dict, so...
        {
            //Rim
            if ([glowPref[@"WindowHideRim"] boolValue] ?: YES)
            {
                [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowRimRadiusInactive"];
                [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowRimRadiusActive"];
                [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowInnerRimRadiusInactive"];
                [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowInnerRimRadiusActive"];
            }
            
            //Shadow
            [params setObject:[NSNumber numberWithFloat: [glowPref[@"WindowShadowRadiusActive"] floatValue] ?: 10] forKey:@"com.apple.WindowShadowRadiusActive"];
            [params setObject:[NSNumber numberWithFloat: [glowPref[@"WindowShadowRadiusInactive"] floatValue] ?: 10] forKey:@"com.apple.WindowShadowRadiusInactive"];
            [params setObject:[NSNumber numberWithFloat: [glowPref[@"WindowShadowYOffset"] floatValue] ?: 5] forKey:@"com.apple.WindowShadowVerticalOffsetInactive"];
            [params setObject:[NSNumber numberWithFloat: [glowPref[@"WindowShadowYOffset"] floatValue] ?: 5] forKey:@"com.apple.WindowShadowVerticalOffsetActive"];
        }
        
        
        if ([glowPref[@"DoWindowBlur"] boolValue] ?: NO)
        {
            SLSSetWindowBackgroundBlurRadius(CGSMainConnectionID(), [(NSWindow *)self windowNumber], 15);
        }
        
        return params;
    }

    -(NSImage *)_cornerMask
    {
        NSImage *img = [[NSImage alloc] initWithContentsOfFile:@"/Library/Glow/Default/systemcornermask.png"];
        img.resizingMode = NSImageResizingModeStretch;
        img.capInsets = NSEdgeInsetsMake
        (
            [glowPref[@"SystemCornerMaskSliceInset"] intValue] ?: 1,
            [glowPref[@"SystemCornerMaskSliceInset"] intValue] ?: 1,
            [glowPref[@"SystemCornerMaskSliceInset"] intValue] ?: 1,
            [glowPref[@"SystemCornerMaskSliceInset"] intValue] ?: 1
        );
        return img;
    }

    -(CGSize)minSize
    {
        return CGSizeMake(0, 0);
    }

    -(CGSize)contentMinSize
    {
        return CGSizeMake(0, 0);
    }

    -(CGSize)maxSize
    {
        return CGSizeMake(3000, 3000);
    }

    -(CGSize)contentMaxSize
    {
        return CGSizeMake(3000, 3000);
    }

    -(NSWindowStyleMask)styleMask
    {
        BOOL key = [glowPref[@"TitlebarAboveSidebarList"] ?: @[@"Finder", @"Console"] containsObject:[[NSRunningApplication currentApplication] localizedName]];
        
        if (key)
        {
            return ZKOrig(NSWindowStyleMask) & ~NSWindowStyleMaskFullSizeContentView;
        } else
        {
            return ZKOrig(NSWindowStyleMask);
        }
    }
endhook

hook(_NSThemeWidget)
    -(void)viewDidMoveToWindow
    {
        ((NSView *)self).translatesAutoresizingMaskIntoConstraints = NO;
        [((NSView *)self).widthAnchor constraintEqualToConstant:[glowPref[@"ButtonSize"] floatValue] ?: 24].active = YES;
        [((NSView *)self).heightAnchor constraintEqualToConstant:[glowPref[@"ButtonSize"] floatValue] ?: 24].active = YES;
    }

    -(void)drawRect:(CGRect)dirtyRect
    {
        NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"_-: ."];
        NSString *result = [[[[self className] lowercaseString] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
        
        dirtyRect.size.width = [glowPref[@"ButtonSize"] floatValue] ?: 24;
        dirtyRect.size.height = [glowPref[@"ButtonSize"] floatValue] ?: 24;
        
        NSImage *img = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/Default/%@.png", result]];
        [img drawInRect:dirtyRect];
    }
endhook

hook(NSThemeFrame)
    -(double)_titlebarHeight
    {
        if (((NSView *)self).window.isSheet)
            return ZKOrig(double);
        if (((NSView *)self).window.isModalPanel)
            return ZKOrig(double);
        if (((NSView *)self).window.isFloatingPanel)
            return ZKOrig(double);
        
        return [glowPref[@"NormalTitlebarHeight"] floatValue] ?: ZKOrig(double);
    }

    -(double)_titlebarHeight2
    {
        if (((NSView *)self).window.isSheet)
            return ZKOrig(double);
        if (((NSView *)self).window.isModalPanel)
            return ZKOrig(double);
        if (((NSView *)self).window.isFloatingPanel)
            return ZKOrig(double);
        
        return [glowPref[@"NormalTitlebarHeight"] floatValue] ?: ZKOrig(double);
    }

    -(double)_windowTitlebarButtonSpacingWidth
    {
        return [glowPref[@"TrafficLightSpacing"] floatValue] ?: ZKOrig(double);
    }

    -(BOOL)_shouldCenterTrafficLights
    {
        return YES;
    }
endhook

hook(NSAppearance)
    +(NSAppearance *)appearanceNamed:(NSString *)appearance
    {
        if ([glowPref[@"PatchNSAppearance"] boolValue] ?: NO)
        {
            if ([appearance containsString:@"Dark"])
            {
                return ZKOrig(NSAppearance *, NSAppearanceNameDarkAqua);
            } else
            {
                return ZKOrig(NSAppearance *, NSAppearanceNameAqua);
            }
        } else
        {
            return ZKOrig(NSAppearance *, appearance);
        }
    }
endhook


@implementation NSColor (Hex)
    +(NSColor*)cfx:(NSString*)inColorString
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        //[scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
        
        unsigned hex;
        if (![scanner scanHexInt:&hex]) return nil;
        int r = (hex >> 16) & 0xFF;
        int g = (hex >> 8) & 0xFF;
        int b = (hex) & 0xFF;

        return [NSColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];

    }
@end

@implementation NSView (Ext)
-(CGPoint)centerPoint
{
    return CGPointMake(NSMidX(self.frame), NSMidY(self.frame));
}
@end

__attribute__((constructor))
static void initializer(void)
{
    glowPref = [Pref glowPrefs];
}

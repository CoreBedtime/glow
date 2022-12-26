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

struct _rgbquad
{
    char b:8;
    char g:8;
    char r:8;
    char a:8;
};

struct _colordef
{
    unsigned int version; // excluded from filter?
    unsigned int reserved;
    struct _rgbquad value;
};

@interface CUIThemeRendition : NSObject
{
@public
    struct _renditionkeytoken *_key;
    //struct cuithemerenditionrenditionflags _renditionFlags;
    NSString *_name;
    NSData *_srcData;
    NSDictionary *_properties;
}
    -(id)name;
    -(id)type;
    -(id)data;
    -(void)setData:(id)data;
    @property(readonly, nonatomic) NSData *srcData;
@end

@interface NSColor (Hex)
    +(NSColor*)cfx:(NSString*)inColorString;
@end


@interface CUINamedLookup : NSObject
@end

@interface CUINamedImage : CUINamedLookup
@end

@interface _CUIRawDataRendition : CUIThemeRendition
@end

@interface _CUIInternalLinkRendition : CUIThemeRendition
@end

@interface _CUIThemePixelRendition : CUIThemeRendition
{
    unsigned int _nimages;
    struct CGImage *_image[16];
    struct CGImage *_unslicedImage;
}

@end

@interface CUIRenditionKey : NSObject
    @property(nonatomic) long long themeGlyphWeight;
    @property(nonatomic) long long themeGlyphSize;
    @property(nonatomic) long long themeDeploymentTarget;
    @property(nonatomic) long long themeDisplayGamut;
    @property(nonatomic) long long themeLocalization;
    @property(nonatomic) long long themeAppearance;
    @property(nonatomic) long long themeIdentifier;
    @property(nonatomic) long long themeGraphicsClass;
    @property(nonatomic) long long themeMemoryClass;
    @property(nonatomic) long long themeSizeClassVertical;
    @property(nonatomic) long long themeSizeClassHorizontal;
    @property(nonatomic) long long themeSubtype;
    @property(nonatomic) long long themeIdiom;
    @property(nonatomic) long long themeScale;
    @property(nonatomic) long long themeLayer;
    @property(nonatomic) long long themePresentationState;
    @property(nonatomic) long long themePreviousState;
    @property(nonatomic) long long themeState;
    @property(nonatomic) long long themeDimension2;
    @property(nonatomic) long long themeDimension1;
    @property(nonatomic) long long themePreviousValue;
    @property(nonatomic) long long themeValue;
    @property(nonatomic) long long themeDirection;
    @property(nonatomic) long long themeSize;
    @property(nonatomic) long long themePart;
    @property(nonatomic) long long themeElement;
@end

@interface CUIImage : NSObject
    +(id)imageWithCGImage:(struct CGImage *)arg1;
    -(id)copyWithZone:(struct _NSZone *)arg1;
    @property(readonly, nonatomic) struct CGSize size;
    -(struct CGImage *)cgImage;
    @property(readwrite, nonatomic) struct CGImage *image;
    -(void)dealloc;
    -(id)initWithCGImage:(struct CGImage *)arg1;
@end


@interface CUIThemeFacet : NSObject
    -(CUIRenditionKey *)renditionKey;
    -(id)displayName;
    -(CUIImage *)image;
    -(id)_rendition;
@end

@interface CUIShapeEffectPreset : NSObject
    @property NSString *effectName;
    -(id)debugDescription;
    -(void)addColorValueRed:(unsigned int)arg1 green:(unsigned int)arg2 blue:(unsigned int)arg3 forParameter:(unsigned int)arg4 withNewEffectType:(unsigned int)arg5;
@end
@interface CUIThemeDataEffectPreset : CUIShapeEffectPreset
@end


typedef union {
    double floatValue;
    unsigned long long intValue;
    struct _rgbcolor {
        unsigned char r;
        unsigned char g;
        unsigned char b;
    } colorValue;
    short angleValue;
    unsigned int enumValue;
} effectVal;

typedef struct {
    unsigned int effectType;
    unsigned int effectParameter;
    effectVal effectValue;
} effectData;


struct _renditionkeytoken {
    unsigned short identifier;
    unsigned short value;
};


/*
    Hook coreUI.
*/

/*

hook(CUIShapeEffectPreset)
    -(void)_insertEffectTuple:(effectData)arg1 atEffectIndex:(unsigned long long)arg2
    {
        //NSLog(class_list)
        NSDictionary *glowPref = [Pref glowPrefs];
        
        effectData *effectPtr = &arg1;
        effectPtr->effectValue.colorValue.r = 255;
        effectPtr->effectValue.colorValue.g = 255;
        effectPtr->effectValue.colorValue.b = 255;
        
        NSLog(@"FEEV: %@", [(CUIShapeEffectPreset *)self debugDescription]);
        
        ZKOrig(void, arg1, arg2);
    }
endhook


hook(CUIStructuredThemeStore)
    -(CUIThemeRendition *)renditionWithKey:(const struct _renditionkeytoken *)arg1 usingKeySignature:(id)arg2
    {
        CUIThemeRendition *rendition = ZKOrig(CUIThemeRendition *, arg1, arg2);
        
        if ([rendition valueForKey:@"_nimages"])
        {
            NSLog(@"GLOWB: %@", [rendition valueForKey:@"_nimages"]);
        }
        return rendition;
    }
endhook

 */

hook(_CUIRawDataRendition)
    -(id)data
    {
        NSDictionary *unarchived = ((NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData: ZKOrig(NSData *)]);
        CALayer *layer;
        
        
        if ([unarchived isKindOfClass:[NSDictionary class]])
        {
            if ([[unarchived objectForKey:@"rootLayer"] isKindOfClass:[CALayer class]])
            {
                NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"-: ."];
                NSString *result = [[[[(_CUIRawDataRendition *)self name] lowercaseString] componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
                
                NSImage* someImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/Default/%@.png", result]];
                CGImageSourceRef source;

                source = CGImageSourceCreateWithData((CFDataRef)[someImage TIFFRepresentation], NULL);
                struct CGImage *maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
                
                CALayer *sublayer;
                
                layer = [CALayer new];
                sublayer = [CALayer new];
                sublayer.contents = (__bridge id _Nullable)(maskRef);
                sublayer.contentsGravity = kCAGravityResize;
                [layer addSublayer: sublayer];
            }
        }
        
        return [NSKeyedArchiver archivedDataWithRootObject:@{@"rootLayer" : layer}];
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
        
        //NSLog(@"GLOW: %@", result);
        
        if (maskRef)
            return maskRef;
        
        return ZKOrig(struct CGImage *);
    }
endhook

hook(CUICommonAssetStorage)
    -(BOOL)getColor:(struct _colordef *)color forName:(const char *)name
    {
        BOOL orig = ZKOrig(BOOL, color, name);
        NSDictionary *glowPref = [Pref glowPrefs];
        
        if (glowPref[@"ThemeColorOverride"][@(name)])
        {
            int r = (int)[NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].redComponent * 255;
            int g = (int)[NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].greenComponent * 255;
            int b = (int)[NSColor cfx: glowPref[@"ThemeColorOverride"][@(name)]].blueComponent * 255;
            
            color->value.r = (char)r;
            color->value.g = (char)g;
            color->value.b = (char)b;
            color->value.a = (char)255;
        }
        
        return orig;
    }
endhook




/*
    Hook Cocoa
*/

static void *glowGraphic = &glowGraphic;
static void *hasGlowGraphic = &hasGlowGraphic;

hook(NSWindow)

    -(void)update
    {
        ZKOrig(void);
        
        if (![objc_getAssociatedObject(self, hasGlowGraphic) boolValue])
        {
            NSWindow *graphic = [[NSWindow alloc] init];
                                                             
            [((NSWindow *)self) addChildWindow:graphic ordered:NSWindowAbove];
            
            [graphic setStyleMask: NSWindowStyleMaskBorderless];
            [graphic setBackgroundColor: NSColor.clearColor];
            [graphic setOpaque:NO];
            [graphic setHasShadow:NO];
            [graphic setIgnoresMouseEvents:YES];
            [graphic setContentView: [NSImageView new]];
            ((NSImageView *)(graphic.contentView)).image = [[NSImage alloc] initWithContentsOfFile:@"/Library/Glow/Default/tab.png"];
            
            objc_setAssociatedObject(self, glowGraphic, graphic, OBJC_ASSOCIATION_RETAIN);
            objc_setAssociatedObject(self, hasGlowGraphic, [NSNumber numberWithBool: YES], OBJC_ASSOCIATION_RETAIN);
            objc_setAssociatedObject(graphic, hasGlowGraphic, [NSNumber numberWithBool: YES], OBJC_ASSOCIATION_RETAIN);
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateGraphic) name:NSWindowDidResizeNotification object:nil];
        } else
        {
            [self updateGraphic];
        }
    }
    
    -(void)updateGraphic
    {
        [(NSWindow *)objc_getAssociatedObject(self, glowGraphic) setFrame:CGRectMake(((NSWindow *)self).frame.origin.x - 0,
                                                                                     ((NSWindow *)self).frame.origin.y + ((NSWindow *)self).frame.size.height,
                                                                                     50,
                                                                                     50)
                                                                                     display:YES];
    }

    -(id)shadowParameters
    {
        NSMutableDictionary *params = ZKOrig(NSMutableDictionary *);
        NSDictionary *glowPref = [Pref glowPrefs];
        
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
        
        return params;
    }

    -(NSImage *)_cornerMask
    {
        NSDictionary *glowPref = [Pref glowPrefs];
        
        CGFloat radius = [glowPref[@"WindowCornerRadius"] floatValue] ?: 0;
        CGFloat dimension = 2 * radius + 1;
        NSSize size = NSMakeSize(dimension, dimension);
        NSImage *image = [NSImage imageWithSize:size flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
            NSBezierPath *bezierPath = [NSBezierPath bezierPathWithRoundedRect:dstRect xRadius:radius yRadius:radius];
            [[NSColor blackColor] set];
            [bezierPath fill];
            return YES;
        }];
        image.capInsets = NSEdgeInsetsMake(radius, radius, radius, radius);
        image.resizingMode = NSImageResizingModeStretch;
        return image;
    }

    -(NSWindowStyleMask)styleMask
    {
        BOOL key = [[Pref glowPrefs][@"TitlebarAboveSidebarList"] ?: @[@"Finder", @"Console"] containsObject:[[NSRunningApplication currentApplication] localizedName]];
        
        if (key)
        {
            return ZKOrig(NSWindowStyleMask) & ~NSWindowStyleMaskFullSizeContentView;
        } else
        {
            return ZKOrig(NSWindowStyleMask);
        }
    }

    -(BOOL)opaque
    {
        return NO;
    }
@end

hook(_NSThemeWidget)
    -(void)viewDidMoveToWindow
    {
        ((NSView *)self).translatesAutoresizingMaskIntoConstraints = NO;
        [((NSView *)self).widthAnchor constraintEqualToConstant:24].active = YES;
        [((NSView *)self).heightAnchor constraintEqualToConstant:24].active = YES;
    }
    -(void)drawRect:(CGRect)dirtyRect
    {
        [[[NSImage alloc] initWithContentsOfFile: [NSString stringWithFormat:@"/Library/Glow/Default/%@.png", ((NSButton *)self).className]] drawInRect:dirtyRect];
    }
endhook

hook(NSAppearance)
    +(NSAppearance *)appearanceNamed:(NSString *)appearance
    {
        NSDictionary *glowPref = [Pref glowPrefs];
        
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




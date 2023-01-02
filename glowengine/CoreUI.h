//
//  CoreUI.h
//  glowengine
//
//  Created by bedtime on 1/1/23.
//

#ifndef CoreUI_h
#define CoreUI_h


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


#endif /* CoreUI_h */

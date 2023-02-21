//
//  CoreUI.h
//  glowengine
//
//  Created by bedtime on 1/1/23.
//

#ifndef CoreUI_h
#define CoreUI_h


#import <QuartzCore/QuartzCore.h>

@interface CUICatalog : NSObject
{
    unsigned long long _storageRef;
    NSMapTable *_storageMapTable;
    NSBundle *_bundle;
    NSString *_assetStoreName;
    unsigned int _purgeWhenFinished:1;
}

+ (id)_resolvedRenditionKeyFromThemeRef:(unsigned long long)arg1 withBaseKey:(id)arg2 scaleFactor:(double)arg3 deviceIdiom:(long long)arg4 deviceSubtype:(unsigned long long)arg5 sizeClassHorizontal:(long long)arg6 sizeClassVertical:(long long)arg7 memoryClass:(unsigned long long)arg8 graphicsClass:(unsigned long long)arg9 graphicsFallBackOrder:(id)arg10;
+ (id)bestMatchUsingImages:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6;
+ (id)defaultUICatalogForBundle:(id)arg1;
+ (id)systemUICatalog;
+ (id)defaultUICatalog;
+ (id)systemUICatalogWithArtVariant:(id)arg1;
- (void)clearCachedImageResources;
- (id)debugDescription;
- (id)imageByStylingImage:(struct CGImage *)arg1 stylePresetName:(id)arg2 styleConfiguration:(id)arg3 foregroundColor:(struct CGColor *)arg4 scale:(double)arg5;
- (int)blendModeForStylePresetWithName:(id)arg1 styleConfiguration:(id)arg2;
- (struct CGColor *)equivalentForegroundColorForStylePresetWithName:(id)arg1 styleConfiguration:(id)arg2;
- (BOOL)hasStylePresetWithName:(id)arg1;
- (BOOL)hasStylePresetWithName:(id)arg1 styleConfiguration:(id)arg2;
- (BOOL)fillStyledRect:(struct CGRect)arg1 inContext:(struct CGContext *)arg2 stylePresetName:(id)arg3 styleConfiguration:(id)arg4;
- (BOOL)fillStyledPath:(struct CGPath *)arg1 inContext:(struct CGContext *)arg2 stylePresetName:(id)arg3 styleConfiguration:(id)arg4;
- (BOOL)strokeStyledPath:(struct CGPath *)arg1 inContext:(struct CGContext *)arg2 stylePresetName:(id)arg3 styleConfiguration:(id)arg4;
- (BOOL)drawGlyphs:(const unsigned short *)arg1 atPositions:(const struct CGPoint *)arg2 inContext:(struct CGContext *)arg3 withFont:(struct __CTFont *)arg4 count:(unsigned long long)arg5 stylePresetName:(id)arg6 styleConfiguration:(id)arg7 foregroundColor:(struct CGColor *)arg8;
- (BOOL)requiredDrawOfUnstyledGlyphs:(const unsigned short *)arg1 atPositions:(const struct CGPoint *)arg2 inContext:(struct CGContext *)arg3 withFont:(struct __CTFont *)arg4 count:(unsigned long long)arg5;
- (id)newShapeEffectStackForStylePresetName:(id)arg1 styleConfiguration:(id)arg2 foregroundColor:(struct CGColor *)arg3;
- (id)newTextEffectStackForStylePresetName:(id)arg1 styleConfiguration:(id)arg2 foregroundColor:(struct CGColor *)arg3;
- (id)newShapeEffectPresetForStylePresetName:(id)arg1 styleConfiguration:(id)arg2;
- (id)renditionKeyForShapeEffectPresetForStylePresetName:(id)arg1 styleConfiguration:(id)arg2;
- (id)renditionKeyForShapeEffectPresetWithStylePresetName:(id)arg1 state:(long long)arg2 presentationState:(long long)arg3 value:(long long)arg4 resolution:(unsigned long long)arg5;
- (id)renditionKeyForShapeEffectPresetWithStyleID:(unsigned long long)arg1 state:(long long)arg2 presentationState:(long long)arg3 value:(long long)arg4 resolution:(unsigned long long)arg5;
- (BOOL)canGetShapeEffectRenditionWithKey:(id)arg1;
- (id)newShapeEffectPresetWithRenditionKey:(id)arg1;
- (long long)artVariantIDOrZero;
- (id)_resolvedRenditionKeyForName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6 memoryClass:(unsigned long long)arg7 graphicsClass:(unsigned long long)arg8 graphicsFallBackOrder:(id)arg9 withBaseKeySelector:(SEL)arg10;
- (id)_defaultAssetRenditionKey:(id)arg1;
- (id)_baseAtlasKeyForName:(id)arg1;
- (id)_baseKeyForName:(id)arg1;
- (id)_themeStore;
- (unsigned long long)_themeRef;
- (unsigned long long)_storageRefForRendition:(id)arg1 representsODRContent:(char *)arg2;
- (id)namedLookupWithName:(id)arg1 scaleFactor:(double)arg2;
- (id)namedLookupWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6;
- (id)defaultNamedAssetWithScaleFactor:(double)arg1 deviceIdiom:(long long)arg2 deviceSubtype:(unsigned long long)arg3 sizeClassHorizontal:(long long)arg4 sizeClassVertical:(long long)arg5;
- (id)defaultLayerStackWithScaleFactor:(double)arg1 deviceIdiom:(long long)arg2 deviceSubtype:(unsigned long long)arg3 sizeClassHorizontal:(long long)arg4 sizeClassVertical:(long long)arg5;
- (id)layerStackWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6;
- (id)layerStackWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3;
- (id)layerStackWithName:(id)arg1;
- (struct CGPDFDocument *)pdfDocumentWithName:(id)arg1;
- (id)imagesWithName:(id)arg1;
- (id)allImageNames;
- (id)parentNamedImageAtlastForImageNamed:(id)arg1 scaleFactor:(double)arg2;
- (id)namedImageAtlasWithName:(id)arg1 scaleFactor:(double)arg2;
- (id)namedImageAtlasWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 memoryClass:(unsigned long long)arg5 graphicsClass:(unsigned long long)arg6 graphicsFallBackOrder:(id)arg7;
- (id)dataWithName:(id)arg1;
- (id)dataWithName:(id)arg1 deviceIdiom:(long long)arg2 deviceSubtype:(unsigned long long)arg3 memoryClass:(unsigned long long)arg4 graphicsClass:(unsigned long long)arg5 graphicsFallBackOrder:(id)arg6;
- (id)dataWithName:(id)arg1 deviceIdiom:(long long)arg2 deviceSubtype:(unsigned long long)arg3 memoryClass:(unsigned long long)arg4 graphicsClass:(unsigned long long)arg5;
- (BOOL)imageExistsWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6;
- (BOOL)imageExistsWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4;
- (BOOL)imageExistsWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3;
- (BOOL)imageExistsWithName:(id)arg1 scaleFactor:(double)arg2;
- (id)imageWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4 sizeClassHorizontal:(long long)arg5 sizeClassVertical:(long long)arg6;
- (id)imageWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3 deviceSubtype:(unsigned long long)arg4;
- (id)imageWithName:(id)arg1 scaleFactor:(double)arg2 deviceIdiom:(long long)arg3;
- (id)imageWithName:(id)arg1 scaleFactor:(double)arg2;
- (void)dealloc;
- (id)initWithBytes:(const void *)arg1 length:(unsigned long long)arg2 error:(id *)arg3;
- (id)initWithURL:(id)arg1 error:(id *)arg2;
- (id)initWithName:(id)arg1 fromBundle:(id)arg2 error:(id *)arg3;
- (id)initWithName:(id)arg1 fromBundle:(id)arg2;
- (id)layoutInformationForDrawingInRect:(struct CGRect)arg1 context:(struct CGContext *)arg2 options:(id)arg3;
- (struct __CFString *)customizedBackgroundTypeForWidget:(struct __CFString *)arg1;
- (BOOL)hasCustomizedAppearanceForWidget:(id)arg1;

@end

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

@interface NSView (Ext)
    -(CGPoint)centerPoint;
@end

CA_EXTERN NSString * const kCAContentsScalingRepeat;

@interface CALayer (CALayerAdditions)
@property(copy) NSString *contentsScaling;
@end

@interface CUINamedLookup : NSObject
@end

@interface CUINamedImage : CUINamedLookup
@end

@interface _CUIRawDataRendition : CUIThemeRendition
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

@interface _CUIInternalLinkRendition : CUIThemeRendition

- (BOOL)edgesOnly;
- (BOOL)isTiled;
- (id)maskForSliceIndex:(long long)arg1;
- (id)imageForSliceIndex:(long long)arg1;
- (void)_fillOutImageSlices;
- (id)properties;
- (id)data;
- (struct CGImage *)unslicedImage;
- (struct CGImage *)_sourceImage;
- (id)_sourceRendition;
- (BOOL)isScaled;
- (id)metrics;
-(id)name;
- (id)sliceInformation;
- (struct CGSize)unslicedSize;
- (struct CGRect)_destinationFrame;
- (id)linkingToRendition;
- (BOOL)isInternalLink;
- (int)pixelFormat;
- (BOOL)isOpaque;
- (int)bitmapEncoding;
- (void)_setStructuredThemeStore:(id)arg1;
- (id)initWithCSIData:(id)arg1 forKey:(const struct _renditionkeytoken *)arg2 artworkStatus:(long long)arg3;
- (void)dealloc;

@end


CA_EXTERN NSString * const kCAContentsScalingRepeat;

@interface CUIRenditionMetrics : NSObject
{
    struct CGSize _imageSize;
    struct CGSize _edgeBottomLeftMargin;
    struct CGSize _edgeTopRightMargin;
    struct CGSize _contentBottomLeftMargin;
    struct CGSize _contentTopRightMargin;
    double _baseline;
    struct CGSize _auxiliary1BottomLeftMargin;
    struct CGSize _auxiliary1TopRightMargin;
    struct CGSize _auxiliary2BottomLeftMargin;
    struct CGSize _auxiliary2TopRightMargin;
    double _scale;
}

- (BOOL)hasAlignmentEdgeMargins;
- (BOOL)hasOpaqueContentBounds;
- (struct CGRect)insetContentRectWithMetrics:(struct CGRect)arg1;
- (struct CGRect)insetRectWithMetrics:(struct CGRect)arg1;
- (struct CGRect)contentRect;
- (struct CGRect)edgeRect;
- (BOOL)scalesHorizontally;
- (BOOL)scalesVertically;
- (double)scale;
- (struct CGSize)auxiliary2TopRightMargin;
- (struct CGSize)auxiliary2BottomLeftMargin;
- (struct CGSize)auxiliary1TopRightMargin;
- (struct CGSize)auxiliary1BottomLeftMargin;
- (double)baseline;
- (struct CGSize)contentTopRightMargin;
- (struct CGSize)contentBottomLeftMargin;
- (struct CGSize)edgeTopRightMargin;
- (struct CGSize)edgeBottomLeftMargin;
- (struct CGSize)imageSize;
- (id)initWithImageSize:(struct CGSize)arg1 edgeBottomLeft:(struct CGSize)arg2 edgeTopRight:(struct CGSize)arg3 contentBottomLeft:(struct CGSize)arg4 contentTopRight:(struct CGSize)arg5 baseline:(double)arg6 auxiliary1BottomLeft:(struct CGSize)arg7 auxiliary1TopRight:(struct CGSize)arg8 auxiliary2BottomLeft:(struct CGSize)arg9 auxiliary2TopRight:(struct CGSize)arg10 scalesVertically:(BOOL)arg11 scalesHorizontally:(BOOL)arg12 scale:(double)arg13;
- (id)initwithImageSize:(struct CGSize)arg1 scale:(double)arg2;

@end

@interface CUIThemeFacet : NSObject
{
    struct _renditionkeytoken *_renditionKeyList;
    unsigned long long _themeIndex;
    long long _renditionType;
    struct CGSize _thumbnailSize;
    struct CGPoint _hotSpot;
    int _isTintable;
    struct {
        unsigned int hasCheckedButtonGlyph:1;
        unsigned int isButtonGlyph:1;
        unsigned int reserved:14;
    } _fFlags;
}

+ (BOOL)assetExistsForRenditionKey:(id)arg1 fromTheme:(unsigned long long)arg2;
+ (id)cursorFacetWithName:(id)arg1 fromTheme:(unsigned long long)arg2;
+ (id)_facetWithKeyList:(const struct _renditionkeytoken *)arg1 andRenditionKeyClass:(Class)arg2 orRenditionKey:(id)arg3 fromTheme:(unsigned long long)arg4;
+ (id)facetWithRenditionKey:(id)arg1 fromTheme:(unsigned long long)arg2;
+ (id)facetWithElement:(long long)arg1 part:(long long)arg2 dimension1:(long long)arg3 dimension2:(long long)arg4 fromTheme:(unsigned long long)arg5;
+ (id)facetWithElement:(long long)arg1 part:(long long)arg2 fromTheme:(unsigned long long)arg3;
+ (id)debug_bundleIdentifierForThemeRef:(unsigned long long)arg1;
+ (void)themeUnregisterThemeRef:(unsigned long long)arg1;
+ (unsigned long long)themeWithBytes:(const void *)arg1 length:(unsigned long long)arg2 error:(id *)arg3;
+ (unsigned long long)themeWithContentsOfURL:(id)arg1 error:(id *)arg2;
+ (unsigned long long)themeForBundleIdentifier:(id)arg1 error:(id *)arg2;
+ (unsigned long long)themeNamed:(id)arg1 forBundleIdentifier:(id)arg2 error:(id *)arg3;
+ (void)initialize;
+ (id)_themeStoreForThemeIndex:(unsigned long long)arg1;
+ (void)_invalidateArtworkCaches;
- (id)maskWithSize:(struct CGSize)arg1 keyAdjustment:(id)arg2;
- (id)highlightWithSize:(struct CGSize)arg1 keyAdjustment:(id)arg2;
- (id)imageWithSize:(struct CGSize)arg1 keyAdjustment:(id)arg2;
- (id)imageForSlice:(long long)arg1 withKeyAdjustment:(id)arg2;
- (id)maskForSlice:(long long)arg1 withKeyAdjustment:(id)arg2;
@property(readonly, copy) NSString *description;
- (long long)_sliceIndexForSlice:(long long)arg1 ofRendition:(id)arg2;
- (void)_applyFixedAttributesToKey:(id)arg1;
- (struct CGSize)topLeftCapSize;
- (struct CGSize)thumbnailSize;
- (id)thumbnail;
- (id)displayName;
- (id)properties;
- (BOOL)isTintable;
- (long long)renditionType;
- (id)renditionKey;
- (id)themeRendition;
- (unsigned long long)themeIndex;
- (void)_setThemeIndex:(unsigned long long)arg1;
- (id)gradientWithKeyAdjustment:(id)arg1 angle:(double *)arg2 style:(unsigned long long *)arg3;
- (struct CGSize)sizeForSegmentOfType:(int)arg1;
- (struct CGSize)imageSize;
- (id)blendModeAsCAFilterString;
- (id)blendModeAsCAFilterStringWithKeyAjustment:(id)arg1;
- (int)blendMode;
- (int)blendModeWithKeyAdjustment:(id)arg1;
- (double)alpha;
- (double)alphaWithKeyAdjustment:(id)arg1;
- (id)image;
- (id)imageForSliceIndex:(long long)arg1;
- (id)imageWithKeyAdjustment:(id)arg1;
- (id)imageForState:(long long)arg1 value:(long long)arg2 size:(unsigned long long)arg3;
- (id)imageForState:(long long)arg1 value:(long long)arg2;
- (BOOL)isValidButtonImageSource;
- (BOOL)isValidButtonImageSourceForSize:(unsigned long long)arg1;
- (BOOL)hasValueSlices;
- (id)imageForState:(long long)arg1 withValue:(long long)arg2;
- (id)imageForState:(long long)arg1;
- (id)renditionSliceInformationForRect:(struct CGRect)arg1 keyAdjustment:(id)arg2;
- (id)renditionMetricsWithKeyAdjustment:(id)arg1;
- (void)_drawSlice:(long long)arg1 inFrame:(struct CGRect)arg2 withKeyAdjustment:(id)arg3 context:(struct CGContext *)arg4;
- (void)_drawSpecificRenditionKey:(id)arg1 rendition:(id)arg2 inFrame:(struct CGRect)arg3 context:(struct CGContext *)arg4 alpha:(double)arg5 operation:(int)arg6 isFocused:(int)arg7 isFlipped:(BOOL)arg8 effects:(id)arg9;
- (void)_drawSpecificRenditionKey:(id)arg1 inFrame:(struct CGRect)arg2 context:(struct CGContext *)arg3 alpha:(double)arg4 operation:(int)arg5 isFocused:(int)arg6 isFlipped:(BOOL)arg7 effects:(id)arg8;
- (void)_drawSpecificRenditionKey:(id)arg1 inFrame:(struct CGRect)arg2 context:(struct CGContext *)arg3 isFocused:(int)arg4 isFlipped:(BOOL)arg5 effects:(id)arg6;
- (void)_drawAsMaskSpecificRenditionKey:(id)arg1 inFrame:(struct CGRect)arg2 context:(struct CGContext *)arg3 alpha:(double)arg4 operation:(int)arg5 isFocused:(int)arg6;
- (id)renditionForSpecificKeyWrapper:(id)arg1;
- (void)_drawMaskFromSpecificRenditionKey:(id)arg1 inFrame:(struct CGRect)arg2 alpha:(double)arg3 operation:(int)arg4 isFocused:(int)arg5 context:(struct CGContext *)arg6;
- (void)drawPulseInFrame:(struct CGRect)arg1 pulseValue:(double)arg2 isFocused:(int)arg3 keyAdjustment:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawMaskInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 isFocused:(int)arg4 keyAdjustment:(id)arg5 context:(struct CGContext *)arg6;
- (void)drawMaskInFrame:(struct CGRect)arg1 alpha:(double)arg2 isFocused:(int)arg3 keyAdjustment:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawHighlightInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 keyAdjustment:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawHighlightInFrame:(struct CGRect)arg1 alpha:(double)arg2 keyAdjustment:(id)arg3 context:(struct CGContext *)arg4;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 isFocused:(int)arg4 keyAdjustment:(id)arg5 context:(struct CGContext *)arg6;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 isFocused:(int)arg3 keyAdjustment:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawGradientInFrame:(struct CGRect)arg1 angle:(double)arg2 alpha:(double)arg3 operation:(int)arg4 isFocused:(int)arg5 keyAdjustment:(id)arg6 context:(struct CGContext *)arg7 effects:(id)arg8;
- (void)drawHighlightInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 owner:(id)arg4 userInfo:(id)arg5 context:(struct CGContext *)arg6;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 owner:(id)arg4 userInfo:(id)arg5 context:(struct CGContext *)arg6;
- (void)drawPulseInFrame:(struct CGRect)arg1 pulseValue:(double)arg2 owner:(id)arg3 userInfo:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawMaskInFrame:(struct CGRect)arg1 alpha:(double)arg2 owner:(id)arg3 userInfo:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawHighlightInFrame:(struct CGRect)arg1 alpha:(double)arg2 owner:(id)arg3 userInfo:(id)arg4 context:(struct CGContext *)arg5;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 owner:(id)arg3 userInfo:(id)arg4 context:(struct CGContext *)arg5;
- (BOOL)hitTestAtPoint:(struct CGPoint)arg1 inFrame:(struct CGRect)arg2 owner:(id)arg3 userInfo:(id)arg4;
- (BOOL)_canGetRenditionForKey:(id)arg1 withDrawingLayer:(long long)arg2;
- (void)drawMaskInFrame:(struct CGRect)arg1 owner:(id)arg2 userInfo:(id)arg3 context:(struct CGContext *)arg4;
- (void)drawHighlightInFrame:(struct CGRect)arg1 owner:(id)arg2 userInfo:(id)arg3 context:(struct CGContext *)arg4;
- (void)drawInFrame:(struct CGRect)arg1 owner:(id)arg2 userInfo:(id)arg3 context:(struct CGContext *)arg4;
- (struct CGImage *)copySegmentLayerContents:(int)arg1 andCenter:(struct CGRect *)arg2 leftSeparatorWidth:(double)arg3 rightSeparatorWidth:(double)arg4 renditionKey:(id)arg5 effects:(id)arg6;
- (void)drawSegmentInFrame:(struct CGRect)arg1 isFocused:(int)arg2 segmentType:(int)arg3 context:(struct CGContext *)arg4 effects:(id)arg5;
- (void)drawAnimationFrameMappedFrom0_1RangedValue:(double)arg1 destinationFrame:(struct CGRect)arg2 isFocused:(int)arg3 context:(struct CGContext *)arg4;
- (void)drawAbsoluteAnimationFrame:(double)arg1 destinationFrame:(struct CGRect)arg2 isFocused:(int)arg3 context:(struct CGContext *)arg4;
- (void)drawAsOnePartWithSlice:(int)arg1 inFrame:(struct CGRect)arg2 isFocused:(int)arg3 context:(struct CGContext *)arg4 effects:(id)arg5;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 operation:(int)arg3 isFocused:(int)arg4 context:(struct CGContext *)arg5 effects:(id)arg6;
- (void)drawInFrame:(struct CGRect)arg1 isFocused:(int)arg2 context:(struct CGContext *)arg3 effects:(id)arg4;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 isFocused:(int)arg3 context:(struct CGContext *)arg4;
- (void)drawInFrame:(struct CGRect)arg1 alpha:(double)arg2 isFocused:(int)arg3 context:(struct CGContext *)arg4 effects:(id)arg5;
- (void)drawInFrame:(struct CGRect)arg1 isFocused:(int)arg2 context:(struct CGContext *)arg3;
- (void)updateLayer:(id)arg1 effects:(id)arg2;
- (void)updateLayer:(id)arg1;
- (id)makeLayer;
- (id)_makeLayerFromCAPackageData;
- (struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1;
- (struct CGImage *)copyLayerImageContentsAndCenter:(struct CGRect *)arg1 renditionKey:(id)arg2;
- (void)setControlSize:(long long)arg1;
- (long long)controlSize;
- (void)dealloc;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (void)encodeWithCoder:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)init;
- (id)initWithRenditionKey:(id)arg1 fromTheme:(unsigned long long)arg2;
- (void)_initWithRenditionKey:(id)arg1;
- (id)_imageForRenditionFromKey:(id)arg1 withSize:(struct CGSize)arg2 isMask:(BOOL)arg3;
- (BOOL)_isButtonGlyph;
- (void)_setIsButtonGlyph:(BOOL)arg1;
- (void)_setHasCheckedButtonGlyph:(BOOL)arg1;
- (struct CGSize)_thumbnailSizeForRendition:(id)arg1;
- (id)_rendition;
- (id)_renditionForSpecificKey:(id)arg1;
- (id)_approximateRenditionForRenditionKey:(id)arg1;
- (void)_updateSpecificRenditionKey:(id)arg1 isFocused:(char *)arg2 owner:(id)arg3 userInfo:(id)arg4;
- (struct CGPoint)_hotSpot;
- (id)_themeStore;
- (id)_initWithSystemRenditionKeyList:(struct _renditionkeytoken *)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

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

struct _csiheader {
    unsigned int _field1;
    unsigned int _field2;
    unsigned int _field3;
    unsigned int _field4;
    unsigned int _field5;
    unsigned int _field6;
    unsigned int _field7;
    unsigned int :4;
    unsigned int :28;
    struct _csimetadata {
        unsigned int _field1;
        unsigned short _field2;
        unsigned short _field3;
        char _field4[128];
    } _field8;
    unsigned int _field9;
    struct _csibitmaplist {
        unsigned int _field1;
        unsigned int _field2[0];
    } _field10;
};

struct _csicolor
{
    unsigned int _field1;
    unsigned int _field2;
    unsigned int :8;
    unsigned int :3;
    unsigned int :21;
    unsigned int _field3;
    double _field4[0];
};

@interface CUIShapeEffectPreset : NSObject
{
    effectData _parameterList[125];
    unsigned int _effectIndex[26];
    double _scaleFactor;
    float _minimumShadowSpread;
}
    @property NSString *effectName;
    -(id)debugDescription;
    -(void)addColorValueRed:(unsigned int)arg1 green:(unsigned int)arg2 blue:(unsigned int)arg3 forParameter:(unsigned int)arg4 withNewEffectType:(unsigned int)arg5;
    -(void)addColorFillWithRed:(unsigned int)arg1 green:(unsigned int)arg2 blue:(unsigned int)arg3 opacity:(double)arg4 blendMode:(unsigned int)arg5 tintable:(BOOL)arg6;
    -(void)appendColorValueRed:(unsigned int)arg1 green:(unsigned int)arg2 blue:(unsigned int)arg3 forParameter:(unsigned int)arg4 withEffectType:(unsigned int)arg5;
    -(void)_insertEffectTuple:(effectData)arg1 atEffectIndex:(int)arg2;
    - (void)getEffectTuples:(effectData **)arg1 count:(unsigned long long *)arg2 atEffectIndex:(unsigned long long)arg3;
    - (void)addGradientFillWithTopColorRed:(unsigned int)arg1 green:(unsigned int)arg2 blue:(unsigned int)arg3 bottomColorRed:(unsigned int)arg4 green:(unsigned int)arg5 blue:(unsigned int)arg6 opacity:(double)arg7 blendMode:(unsigned int)arg8;
    -(unsigned int)effectTypeAtIndex:(unsigned long long)arg1;
    - (unsigned long long)effectCount;
    - (unsigned long long)_parameterCount;
    - (void)addOutputOpacityWithOpacity:(double)arg1;
    - (void)addShapeOpacityWithOpacity:(double)arg1;
    - (void)addValue:(effectVal)arg1 forParameter:(unsigned int)arg2 withEffectType:(unsigned int)arg3 atEffectIndex:(unsigned long long)arg4;
    - (effectVal)valueForParameter:(unsigned int)arg1 inEffectAtIndex:(unsigned long long)arg2;
@end

@interface _CUIThemeEffectRendition : CUIThemeRendition
{
    const struct _cuieffectdata *effectData;
    CUIShapeEffectPreset *_effectPreset;
    float _minimumShadowSpread;
}
@end

struct _cuieffectdata {
    unsigned int _field1;
    unsigned int _field2;
    unsigned int _field3;
    unsigned int _field4;
    struct _cuieffectlist {
        unsigned int _field1;
        unsigned int _field2[0];
    } _field5;
};

struct _renditionkeytoken {
    unsigned short identifier;
    unsigned short value;
};


#endif /* CoreUI_h */

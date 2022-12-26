//
//  Tweak.m
//  glow
//
//  Created by bedtime on 7/1/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"
#import "Utility/Preference.h"

@interface CUIThemeRendition : NSObject
    -(id)name;
    -(id)data;
    @property (nonatomic, readonly) NSData *srcData;
@end

@interface _CUIRawDataRendition : CUIThemeRendition
@end

/*
    Hook coreUI.
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
                
                NSLog(result);
                
                NSImage* someImage = [[NSImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/Glow/%@.png", result]];
                CGImageSourceRef source;

                source = CGImageSourceCreateWithData((CFDataRef)[someImage TIFFRepresentation], NULL);
                struct CGImage *maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
                
                layer = [CALayer new];
                layer.contents = (__bridge id _Nullable)(maskRef);
                layer.contentsGravity = kCAGravityResize;
            }
        }
        
        return [NSKeyedArchiver archivedDataWithRootObject:@{@"rootLayer" : layer}];
    }
endhook

hook(NSWindow)
    -(id)shadowParameters
    {
        NSMutableDictionary *params = ZKOrig(NSMutableDictionary *);
        
        if ([params respondsToSelector:@selector(setObject:forKey:)]) // We may not have mutable dict, so...
        {
            //Rim
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowRimRadiusInactive"];
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowRimRadiusActive"];
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowInnerRimRadiusInactive"];
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowInnerRimRadiusActive"];
            
            //Shadow
            [params setObject:[NSNumber numberWithInt:5] forKey:@"com.apple.WindowShadowRadiusActive"];
            [params setObject:[NSNumber numberWithInt:5] forKey:@"com.apple.WindowShadowRadiusInactive"];
            
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowVerticalOffsetInactive"];
            [params setObject:[NSNumber numberWithInt:0] forKey:@"com.apple.WindowShadowVerticalOffsetActive"];
        }
        
        return params;
    }
@end

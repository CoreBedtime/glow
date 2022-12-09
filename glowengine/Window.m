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
                //layer = [unarchived objectForKey:@"rootLayer"];
                layer = [CALayer new];
                //layer.backgroundColor = [NSColor redColor].CGColor;
                layer.contents = [[NSImage alloc] initWithContentsOfFile:@"/Library/Glow/Titlebar.png"];
            }
        }
        
        return [NSKeyedArchiver archivedDataWithRootObject:@{@"rootLayer" : layer}];
    }
endhook

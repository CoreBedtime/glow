//
//  Fonts.m
//  glowengine
//
//  Created by bedtime on 10/16/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/Preference.h"
#import "Utility/ZKSwizzle.h"
#import "Utility/Hooks.h"

#define kNSCTFontUIUsageAttribute @"NSCTFontUIUsageAttribute"

// Essentially a null pointer, useless.
typedef CTFontRef (*CTProc)();
CTProc CTFontCreateWithFontDescriptorOriginal;

/*
@interface Fonts : NSObject; @end
@implementation Fonts
    +(void)load
    {
        if (![Preference isAppInBlackListName:"FontsExclude"])
        {
            process_function_hook((void*)&CTFontCreateWithFontDescriptorOverride, (void*)&CTFontCreateWithFontDescriptor);
        }
    }

    CTFontRef CTFontCreateWithFontDescriptorOverride(CTFontDescriptorRef  _Nonnull descriptor, CGFloat size, const CGAffineTransform * _Nullable matrix)
    {
        // Descriptor is lost due to some misfortune with the way the C hook works.
        CFDictionaryRef dictionary = CTFontDescriptorCopyAttributes(descriptor);
        
        
        return CTFontCreateWithNameAndOptions(CFStringCreateWithCString(NULL, [[Preference getString:"Font"] cString], kCFStringEncodingUTF8), size, matrix, 0);
    }

@end
*/

//
//  Fonts.m
//  glowengine
//
//  Created by bedtime on 10/16/22.
//

#import <Cocoa/Cocoa.h>
#import "Pref/Pref.h"
#include <dlfcn.h>

#define kNSCTFontUIUsageAttribute @"NSCTFontUIUsageAttribute"

NSDictionary *fontPref;

typedef CTFontRef (*CTProc)();
CTProc CTFontCreateWithFontDescriptorOriginal;

CTFontRef CTFontCreateWithFontDescriptorOverride(CTFontDescriptorRef  _Nonnull descriptor, CGFloat size, const CGAffineTransform * _Nullable matrix)
{
    CFDictionaryRef dictionary = CTFontDescriptorCopyAttributes(descriptor);
    
    NSString *fontName = CFDictionaryGetValue(dictionary, (__bridge CFStringRef)NSFontNameAttribute);
    
    BOOL pass = [fontPref[@"FontBlacklist"] ?: @[] containsObject:fontName];
    if (!pass)
    {
        NSMutableDictionary *mutableDictionary = [(__bridge NSDictionary *)dictionary mutableCopy];
        [mutableDictionary removeObjectForKey:kNSCTFontUIUsageAttribute];
        [mutableDictionary setValue:fontPref[@"Font"] ?: @"Arial" forKey:NSFontNameAttribute];
        
        descriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)mutableDictionary);
    }
    
    return CTFontCreateWithFontDescriptorOriginal(descriptor, size, matrix);
}


__attribute__((constructor))
static void fontsInitializer(void)
{
    fontPref = [Pref glowPrefs];
    static void (*_MSHookFunction)(void *symbol, void *hook, void **old) = NULL;
    _MSHookFunction = dlsym(dlopen("/Library/GlowSupport/libellekit.dylib", RTLD_LAZY), "MSHookFunction");
    _MSHookFunction(&CTFontCreateWithFontDescriptor, &CTFontCreateWithFontDescriptorOverride, (void**)&CTFontCreateWithFontDescriptorOriginal);
}

//
//  Preference.m
//  glowengine
//
//  Created by bedtime on 10/28/22.
//

#import "Preference.h"

@implementation Preference
    +(CGFloat)getFloat:(const char *)name
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return [@(ini_get(config, "Settings", name)) floatValue] ?: 0.0f;
    }

    +(int)getInteger:(const char *)name
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return [@(ini_get(config, "Settings", name)) intValue] ?: 0;
    }

    +(BOOL)getBool:(const char *)name
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return [@(ini_get(config, "Settings", name)) boolValue] ?: false;
    }

    +(NSString *)getString:(const char *)name
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return @(ini_get(config, "Settings", name)) ?: @"Null.";
    }

    +(NSArray *)getArray:(const char *)name
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return [@(ini_get(config, "Settings", name)) componentsSeparatedByString:@", "];
    }
    /*
    +(NSColor *)getColorOveride:(const char *)orig new:(const char *)new
    {
        ini_t *config = ini_load("/Library/Glow/Theme.ini");
        return [@(ini_get(config, "FontColor", name)) componentsSeparatedByString:@" -> "];
    }
     */
    +(BOOL)isAppInBlackListName:(const char *)name
    {
        NSArray *list = [Preference getArray:name];
        NSString *app = [NSRunningApplication currentApplication].localizedName;
        if ([list containsObject:app]) { return YES; } else { return NO; }
    }
@end

//
//  Pref.m
//  glowengine
//
//  Created by bedtime on 12/11/22.
//

#import "Pref.h"

@implementation Pref
    +(NSDictionary *)glowPrefs
    {
        return [[NSDictionary alloc] initWithContentsOfFile: @"/Library/Glow/Default/theme.plist"];
    }
@end

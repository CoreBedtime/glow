//
//  Preference.h
//  glowengine
//
//  Created by bedtime on 10/28/22.
//

#import <Cocoa/Cocoa.h>
#include "INI.h"

NS_ASSUME_NONNULL_BEGIN

@interface Preference : NSObject
    +(BOOL)isAppInBlackListName:(const char *)name;
    +(NSString *)getString:(const char *)name;
    +(NSArray *)getArray:(const char *)name;
    +(CGFloat)getFloat:(const char *)name;
    +(BOOL)getBool:(const char *)name;
    +(int)getInteger:(const char *)name;
@end

NS_ASSUME_NONNULL_END

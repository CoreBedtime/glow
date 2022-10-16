//
//  Color.m
//  glowengine
//
//  Created by bedtime on 10/16/22.
//

#import <Cocoa/Cocoa.h>
#import "Utility/ZKSwizzle.h"

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


hook(CUICommonAssetStorage)
    -(BOOL)getColor:(struct _colordef *)color forName:(const char *)name
    {
        NSLog(@"%s: %s", __PRETTY_FUNCTION__, name);
        
        if (!strcmp(name, "controlAlternatingRowColor") || !strcmp(name, "controlBackgroundColor"))
        {
            color->value.r = (char)0;
            color->value.g = (char)0;
            color->value.b = (char)0;
            color->value.a = (char)50;
        }
        else
        {
            return ZKOrig(BOOL, color, name);
        }
        return YES;
    }
endhook

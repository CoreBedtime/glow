//
//  hooks.h
//  Crucible
//
//  Created by Alexander Zielenski on 4/7/16.
//  Copyright © 2016 Alexander Zielenski. All rights reserved.
//

#ifndef hooks_h
#define hooks_h

#import <Foundation/Foundation.h>

void process_function_hook(IMP implementation, void *func);

#endif /* hooks_h */

//
//  hooks.m
//  Crucible
//
//  Created by Alexander Zielenski on 4/7/16.
//  Copyright © 2016 Alexander Zielenski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hooks.h"
#import <objc/runtime.h>



void process_function_hook(IMP implementation, void *func)
{
    if (func != NULL && implementation != NULL)
    {
        mmap(0, 0, 0, 0, 0, 0);
        mprotect(0, 0, 0);
        
        vm_address_t replace = (vm_address_t)func;
        vm_address_t target = (vm_address_t)implementation;
        
        // Copy original code
        char buf[PAGE_SIZE * 2];
        memcpy(buf, (void *)(replace & (~PAGE_MASK)), PAGE_SIZE * 2);
        
        // Patch the trampoline in
        extern void _tramp_begin();
        extern void _tramp_end();
        
        char *xmb = &buf[replace & PAGE_MASK];
        memcpy(xmb, _tramp_begin, ((vm_address_t)_tramp_end) - ((vm_address_t)_tramp_begin));
        
        vm_address_t *tramp_target = (vm_address_t *)&xmb[((vm_address_t)_tramp_end) - ((vm_address_t)_tramp_begin)];
        tramp_target--;
        *tramp_target = target;
        
        munmap((void *)(replace & (~PAGE_MASK)), PAGE_SIZE*2);
        mmap((void *)(replace & (~PAGE_MASK)), PAGE_SIZE*2, PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, 0, 0);
        memcpy((void *)(replace & (~PAGE_MASK)), buf, PAGE_SIZE*2);
        mprotect((void *)(replace & (~PAGE_MASK)), PAGE_SIZE*2, PROT_READ|PROT_EXEC);
    }
    
}

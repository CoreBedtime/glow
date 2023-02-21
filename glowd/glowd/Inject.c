//
//  UniversalInj.c
//  UniversalInj
//
//  Created by Jeremy on 12/1/20.
//

#include "Inject.h"
#include <unistd.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/error.h>
#include <dlfcn.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <pthread.h>
#include <mach/mach_vm.h>
#include <dispatch/dispatch.h>
#include <os/lock.h>
#include <sys/sysctl.h>



#if defined(__x86_64__)
#include <mach/thread_status.h>
#elif defined(__arm64__)
#include <mach/arm/thread_status.h>
#include <mach/arm/_structs.h>
#include <ptrauth.h>
#endif

#define ADDR_TO_PTR(a) ((void*) (unsigned long) (a))

kern_return_t (*_thread_convert_thread_state)(thread_act_t thread, int direction, thread_state_flavor_t flavor, thread_state_t in_state, mach_msg_type_number_t in_stateCnt, thread_state_t out_state, mach_msg_type_number_t *out_stateCnt);

#define STACK_SIZE 0x8000//65536
#define CODE_SIZE 512

char shellCode[] =
#if defined(__x86_64__)

"\x55"                            // push       rbp
"\x48\x89\xe5"                    // mov rbp,   rsp
"\x48\x83\xec\x10"                // sub rsp,   0x10
"\x48\xb8"                        // movabs     rax, _pthread_set_self
"PTHRDSS_"
"\xff\xd0"                        // call       rax
"\x48\x8d\x7d\xf8"                // lea        rdi,[rbp-0x8]
"\x31\xc0"                        // xor        eax,eax
"\x89\xc1"                        // mov        ecx,eax
"\x48\x8d\x15\x30\x00\x00\x00"    // lea        rdx,[rip+0x40]
"\x48\x89\xce"                    // mov        rsi,rcx
"\x48\xb8"                        // movabs     rax, pthread_create_from_mach_thread
"PTHRDCRT"
"\xff\xd0"                        // call       rax
"\x48\xb8"                        // movabs     rax, mach_thread_self
"THRDSELF"
"\xff\xd0"                        // call       rax
"\x48\x89\xc7"                    // mov        rdi, rax
"\x48\xb8"                        // movabs     rax, thread_terminate
"THRDTERM"
"\xff\xd0"                        // call       rax
"\x48\x83\xc4\x10"                // add        rsp, 0x10
"\x5d"                            // pop        rbp
"\xc3"                            // ret

"\x55"                            // push       rbp
"\x48\x89\xE5"                    // mov        rbp, rsp
"\x48\x83\xEC\x10"                // sub        rsp, 0x10
"\xBE\x01\x00\x00\x00"            // mov        esi, 0x1
"\x48\x89\x7D\xF8"                // mov        qword [rbp+var_8], rdi
"\x48\x8D\x3D\x1D\x00\x00\x00"    // lea        rdi, qword ptr [rip + 0x2c]
"\x48\xB8"                        // movabs     rax, dlopen
"DLOPEN__"
"\xFF\xD0"                        // call       rax
"\x31\xF6"                        // xor        esi, esi
"\x89\xF7"                        // mov        edi, esi
"\x48\x89\x45\xF0"                // mov        qword [rbp+var_10], rax
"\x48\x89\xF8"                    // mov        rax, rdi
"\x48\x83\xC4\x10"                // add        rsp, 0x10
"\x5D"                            // pop        rbp
"\xC3"                            // ret

#else

//"\x00\x00\x3e\xd4"
"\x7f\x23\x03\xd5"                // pacibsp
"\xFF\xC3\x00\xD1"                // sub        sp, sp, #0x30
"\xFD\x7B\x02\xA9"                // stp        x29, x30, [sp, #0x20]
"\xFD\x83\x00\x91"                // add        x29, sp, #0x20
"\x09\x03\x00\x10"                // adr        x9, #0x60           ; pointer to pthread_set_self
"\x29\x01\x40\xF9"                // ldr        x9, [x9]            ; dereference for value
"\x20\x01\x3F\xD6"                // blr        x9                  ; call pthread_set_self
"\xA0\xC3\x1F\xB8"                // stur       w0, [x29, #-0x4]
"\xE1\x0B\x00\xF9"                // str        x1, [sp, #0x10]
"\xE0\x23\x00\x91"                // add        x0, sp, #0x8        ; stack pointer for arg0
"\x08\x00\x80\xD2"                // mov        x8, #0
"\xE8\x07\x00\xF9"                // str        x8, [sp, #0x8]
"\xE1\x03\x08\xAA"                // mov        x1, x8              ; NULL for arg1
//"\xe2\x02\x00\x10"                // adr        x2, #0x5C           ; function pointer for arg2
"\x62\x03\x00\x10"                // adr        x2, #0x6c           ; function pointer for arg2
"\xE2\x23\xC1\xDA"                // paciza     x2
"\xE3\x03\x08\xAA"                // mov        x3, x8              ; NULL for arg3
"\xc9\x01\x00\x10"                // adr        x9, #0x38           ; pointer to pthrdcrt
"\x29\x01\x40\xF9"                // ldr        x9, [x9]            ; dereference for value
"\x20\x01\x3F\xD6"                // blr        x9                  ; call pthrdcrt
"\xa9\x01\x00\x10"                // adr        x9, #0x34           ; pointer to thread_self
"\x29\x01\x40\xF9"                // ldr        x9, [x9]            ; dereference for value
"\x20\x01\x3F\xD6"                // blr        x9                  ; call thread_self
"\x01\x00\x80\xd2"                // mov        x1, #0
"\x03\x00\x80\xd2"                // mov        x3, #0
"\xe2\x03\x00\x2a"                // mov        w2, w0
"\x00\x00\x80\x52"                // mov        w0, #0
"\x30\x2d\x80\xd2"                // mov        x16, 0x169          ; __bsdthread_terminate
"\x01\x10\x00\xd4"                // svc        128
//"\xe0\x0f\x00\xb9"                // str        w0, [sp, #0xc]
//"\xe0\x0f\x40\xb9"                // ldr        w0, [sp, #0xc]
//"\x0a\x00\x00\x94"                // bl         #0x28
//"\x89\x01\x00\x10"                // adr        x9, #0x30           ; pointer to thread_terminate
//"\x29\x01\x40\xF9"                // ldr        x9, [x9]            ; dereference for value
//"\x20\x01\x1F\xD6"                // br         x9                  ; call thread_terminate
//"\xFD\x7B\x42\xA9"                // ldp        x29, x30, [sp, #0x20]
//"\xFF\xC3\x00\x91"                // add        sp, sp, #0x30
//"\xC0\x03\x5F\xD6"                // ret
//"\xff\x0f\x5f\xd6"                //retab
"PTHRDSS_"
"PTHRDCRT"
"THRDSELF"
"\x91\x00\x00\x10"                // adr        x17, #0x10           ; pointer to thread_terminate
"\x30\x02\x40\xf9"                // ldr        x16, [x17]            ; dereference for value
"\x30\x02\xc1\xda"                // pacia      x16, x17
"\x11\x0a\x1f\xd7"                // braa       x16, x17                  ; call thread_terminate
"THRDTERM"

"\x7F\x23\x03\xD5"                // pacibsp
"\xFF\xC3\x00\xD1"                // sub        sp, sp, #0x30
"\xFD\x7B\x02\xA9"                // stp        x29, x30, [sp, #0x20]
"\xFD\x83\x00\x91"                // add        x29, sp, #0x20
"\xA0\xC3\x1F\xB8"                // stur       w0, [x29, #-0x4]
"\xE1\x0B\x00\xF9"                // str        x1, [sp, #0x10]
"\x21\x00\x80\xD2"                // mov        x1, #1              ; RTLD_LAZY
"\x60\x01\x00\x10"                // adr        x0, #0x2c           ; char *libPath
"\x09\x01\x00\x10"                // adr        x9, #0x20
"\x29\x01\x40\xF9"                // ldr        x9, [x9]
"\x20\x01\x3F\xD6"                // blr        x9                  ; call dlopen
"\x09\x00\x80\x52"                // mov        w9, #0
"\xE0\x03\x09\xAA"                // mov        x0, x9
"\xFD\x7B\x42\xA9"                // ldp        x29, x30, [sp, #0x20]
"\xFF\xC3\x00\x91"                // add        sp, sp, #0x30
"\xFF\x0F\x5F\xD6"                // retab
"DLOPEN__"

#endif

"LIBLIBLIB\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00";

/* Globals */
char *libPathField = 0;
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
dispatch_queue_t queue = 0;

static kern_return_t inject_task(task_t remoteTask, const char *lib) {
    kern_return_t kr = KERN_SUCCESS;
    
    mach_vm_address_t remoteStack64 = (vm_address_t)NULL;
    mach_vm_address_t remoteCode64 = (vm_address_t)NULL;
    
    kr = mach_vm_allocate(remoteTask, &remoteStack64, STACK_SIZE, VM_FLAGS_ANYWHERE);
    if (kr != KERN_SUCCESS) {
        return kr;
    }
    
    //Allocate thread memory
    remoteCode64 = (vm_address_t)NULL;
    kr = mach_vm_allocate(remoteTask, &remoteCode64, sizeof(shellCode), VM_FLAGS_ANYWHERE);
    if (kr != KERN_SUCCESS) {
        return kr;
    }
    
    pthread_mutex_lock(&lock);
    strcpy(libPathField, lib);
    kr = mach_vm_write(remoteTask,
                       remoteCode64,
                       (vm_address_t)shellCode,
                       sizeof(shellCode));
    
    pthread_mutex_unlock(&lock);
    if (kr != KERN_SUCCESS) {
        return kr;
    }

    kr = vm_protect(remoteTask, remoteCode64, sizeof(shellCode), FALSE, VM_PROT_READ | VM_PROT_EXECUTE);
    kr = vm_protect(remoteTask, remoteStack64, STACK_SIZE, TRUE, VM_PROT_READ | VM_PROT_WRITE);
    if (kr != KERN_SUCCESS) {
        return kr;
    }
    
#if defined(__x86_64__)
    x86_thread_state64_t threadState;
    x86_thread_state64_t machineThreadState;
    thread_state_flavor_t flavor = x86_THREAD_STATE64;
    mach_msg_type_number_t stateCnt = x86_THREAD_STATE64_COUNT;
    mach_msg_type_number_t machineStateCnt = x86_THREAD_STATE64_COUNT;
#elif defined(__arm64__)
    struct arm_unified_thread_state threadState;
    struct arm_unified_thread_state machineThreadState;
    thread_state_flavor_t flavor = ARM_UNIFIED_THREAD_STATE;
    mach_msg_type_number_t stateCnt = ARM_UNIFIED_THREAD_STATE_COUNT;
    mach_msg_type_number_t machineStateCnt = ARM_UNIFIED_THREAD_STATE_COUNT;
#endif
    
    thread_act_t         remoteThread = 0;
    memset(&threadState, '\0', sizeof(threadState));
    memset(&machineThreadState, '\0', sizeof(machineThreadState));
    
#if defined(__x86_64__)
    threadState.__rdi = (uint64_t)(remoteStack64);
    threadState.__rip = (uint64_t)(vm_address_t) remoteCode64;
    threadState.__rsp = (uint64_t)((remoteStack64 + (STACK_SIZE/2)) - 8);
#elif defined(__arm64__)
    threadState.ash.flavor = ARM_THREAD_STATE64;
    threadState.ash.count = ARM_THREAD_STATE64_COUNT;
    
    threadState.ts_64.__x[0] = (uint64_t)(remoteStack64);
    __darwin_arm_thread_state64_set_pc_fptr(threadState.ts_64,
                                            ptrauth_sign_unauthenticated(ADDR_TO_PTR(remoteCode64), ptrauth_key_asia, 0));

    __darwin_arm_thread_state64_set_sp(threadState.ts_64, (unsigned long)
                                       ((remoteStack64 + (STACK_SIZE - 0x100))));
#endif

    kr = thread_create(remoteTask, &remoteThread);
    if(kr != KERN_SUCCESS) {
        fprintf(stderr, "Could not create thread: error %s\n", mach_error_string(kr));
        return kr;
    }
    
    if(_thread_convert_thread_state) {
        kr = _thread_convert_thread_state(remoteThread, 2, flavor, (thread_state_t)&threadState, stateCnt, (thread_state_t)&machineThreadState, &machineStateCnt);
        if(kr != KERN_SUCCESS) {
            fprintf(stderr, "Could not convert thread state: error %d %s\n", kr, mach_error_string(kr));
            return kr;
        }
    } else {
        machineThreadState = threadState;
    }
    
    kr = thread_set_state(remoteThread, flavor, (thread_state_t)&machineThreadState, machineStateCnt);
    if(kr != KERN_SUCCESS) {
        fprintf(stderr, "Could not set thread state: error %s\n", mach_error_string(kr));
        return kr;
    }
    
    kr = thread_resume(remoteThread);
    if(kr != KERN_SUCCESS) {
        fprintf(stderr, "Could not start thread: error %s\n", mach_error_string(kr));
        return kr;
    }

    mach_port_deallocate(mach_task_self(), remoteThread);
    return kr;
}

void inject(pid_t pid, const char *lib)
{

    
    task_t task;
    kern_return_t kr = task_for_pid(mach_task_self(), pid, &task);
    if(kr != KERN_SUCCESS)
        return;
        
    kr = inject_task(task, lib);
    if(kr != KERN_SUCCESS)
    {
        fprintf(stderr, "Could not inject %d\n", pid);
    }
    mach_port_deallocate(mach_task_self(), task);
}

static void symbolicate_shellcode() {
    uint64_t addrOfPthreadCreate = (uint64_t)dlsym(dlopen("/usr/lib/system/libsystem_pthread.dylib", RTLD_LAZY), "pthread_create_from_mach_thread");
    uint64_t addrOfPthreadSetSelf = (uint64_t)dlsym(dlopen("/usr/lib/system/libsystem_pthread.dylib", RTLD_LAZY), "_pthread_set_self"); //(uint64_t) _pthread_set_self;
    uint64_t addrOfThreadSelf = (uint64_t)mach_thread_self;
    uint64_t addrOfThreadTerminate = (uint64_t)thread_terminate;
    uint64_t addrOfDlopen = (uint64_t)dlopen;
    printf("pthreadsetself 0x%llx\n", addrOfPthreadSetSelf);
#if defined(__arm64e__)
    addrOfPthreadCreate = (uint64_t)ptrauth_strip(ADDR_TO_PTR(addrOfPthreadCreate), ptrauth_key_function_pointer);
    addrOfPthreadSetSelf = (uint64_t)ptrauth_strip(ADDR_TO_PTR(addrOfPthreadSetSelf), ptrauth_key_function_pointer);
    addrOfThreadSelf = (uint64_t)ptrauth_strip(ADDR_TO_PTR(addrOfThreadSelf), ptrauth_key_function_pointer);
    addrOfThreadTerminate = (uint64_t)ptrauth_strip(ADDR_TO_PTR(addrOfThreadTerminate), ptrauth_key_function_pointer);
    addrOfDlopen = (uint64_t)ptrauth_strip(ADDR_TO_PTR(addrOfDlopen), ptrauth_key_function_pointer);
#endif
    
    printf("pthreadsetself 0x%llx\n", addrOfPthreadSetSelf);
    
    char *possiblePatchLocation = (shellCode);
    for (int i = 0 ; i < sizeof(shellCode); i++) {
        possiblePatchLocation++;
        
        if (memcmp (possiblePatchLocation, "PTHRDCRT", 8) == 0) {
            memcpy(possiblePatchLocation, &addrOfPthreadCreate, sizeof(uint64_t));
        }
        
        if (memcmp (possiblePatchLocation, "PTHRDSS_", 8) == 0) {
            memcpy(possiblePatchLocation, &addrOfPthreadSetSelf, sizeof(uint64_t));
        }
        
        if (memcmp (possiblePatchLocation, "THRDSELF", 8) == 0) {
            memcpy(possiblePatchLocation, &addrOfThreadSelf, sizeof(uint64_t));
        }
        
        if (memcmp (possiblePatchLocation, "THRDTERM", 8) == 0) {
            memcpy(possiblePatchLocation, &addrOfThreadTerminate, sizeof(uint64_t));
        }
        
        if (memcmp(possiblePatchLocation, "DLOPEN__", 6) == 0) {
            memcpy(possiblePatchLocation, &addrOfDlopen, sizeof(uint64_t));
        }
        
        if (memcmp(possiblePatchLocation, "LIBLIBLIB", 9) == 0) {
            libPathField = possiblePatchLocation;
        }
    }
}

__attribute__((constructor))
static void ctor() {
    void *module = dlopen ("/usr/lib/system/libsystem_kernel.dylib", RTLD_GLOBAL | RTLD_LAZY);
    _thread_convert_thread_state = dlsym (module, "thread_convert_thread_state");
    dlclose (module);

    symbolicate_shellcode();
    queue = dispatch_queue_create("injectorQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_retain(queue);
}

//
//  Inject.h
//  chakrad
//
//  Created by bedtime on 10/26/22.
//

#include <stdio.h>
#include <sys/types.h>    //NOTE: Added

void inject(pid_t pid, const char *lib);
void inject_sync(pid_t pid, const char *lib);

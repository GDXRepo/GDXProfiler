/*
 
 GitHub: NRGRepo/NRGProfiler
 
 The Apache License
 
 Copyright (c) 2015 Georgiy Malyukov
 
 */

#import "NRGProfiler.h"
#import <mach/mach_time.h>

// wrap NSLog
#ifndef NRGDLog
    #ifdef DEBUG
        #define NRGDLog NSLog
    #else
        #define NRGDLog(...)
    #endif
#endif


@interface NRGProfiler () {
    
}

#pragma mark - Private

- (void)setupStartTime;

@end


@implementation NRGProfiler

static mach_timebase_info_data_t timebaseInfo;

@synthesize startTime;


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, nil);
    
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        [self setupStartTime];
    }
    return self;
}


#pragma mark - Common

+ (instancetype)startWithMessage:(NSString *)msg {
    NRGProfiler *profiler = [[[self class] alloc] initPrivate];

    NRGDLog(@"[NRGProfiler]: Profiling Started. %@", (msg) ? msg : @"");

    return profiler;
}

- (double)pointWithMessage:(NSString *)msg {
    NSAssert(startTime != 0, @"You must call 'start' to init measurement before saving any points.");
    
    double elapsedSeconds = self.elapsedSeconds;
    
    NRGDLog(@"[NRGProfiler]: Point (%.3f s). %@", elapsedSeconds, (msg) ? msg : @"");

    return elapsedSeconds;
}

- (double)stopWithMessage:(NSString *)msg {
    NSAssert(startTime != 0, @"You must call 'start' to init measurement before stopping it.");
    
    double elapsedSeconds = self.elapsedSeconds;
    startTime = 0; // make start time invalid
    
    NRGDLog(@"[NRGProfiler]: Profiling Stopped (%.3f s). %@", elapsedSeconds, (msg) ? msg : @"");
    
    return elapsedSeconds;
}

- (void)restartWithMessage:(NSString *)msg {
    [self setupStartTime];
    
    NRGDLog(@"[NRGProfiler]: Profiling Restarted. %@", (msg) ? msg : @"");
}

+ (instancetype)start {
    return [[self class] startWithMessage:nil];
}

- (double)point {
    return [self pointWithMessage:nil];
}

- (double)stop {
    return [self stopWithMessage:nil];
}

- (void)restart {
    return [self restartWithMessage:nil];
}


#pragma mark - Private

- (void)setupStartTime {
    startTime = mach_absolute_time();
}


#pragma mark - Properties

- (double)elapsedSeconds {
    const uint64_t elapsedMTU = mach_absolute_time() - startTime;
    
    // transform from MTU (Mach Time Units) to nano seconds
    if (timebaseInfo.denom == 0) {
        mach_timebase_info(&timebaseInfo);
    }    
    const double elapsedNanoSec = ((double)elapsedMTU
                                   * (double)timebaseInfo.numer
                                   / (double)timebaseInfo.denom);
    
    return elapsedNanoSec / 1000000000; // 10^9
}

@end

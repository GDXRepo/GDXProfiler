//
//  Core.m
//  DDLTest
//
//  Created by Georgiy Malyukov on 14.05.15.
//
//

#import "Core.h"
#import "GDXProfiler.h"

// error domain
NSString *const kCoreErrorDomain = @"CoreErrorDomain";

// notifications
NSString *const kNotificationCoreDidStartProfiling = @"kNotificationCoreDidStartProfiling";
NSString *const kNotificationCoreDidPoint = @"kNotificationCoreDidPoint";
NSString *const kNotificationCoreDidStopProfiling = @"kNotificationCoreDidStopProfiling";
NSString *const kNotificationCoreDidRestartProfiling = @"kNotificationCoreDidRestartProfiling";
NSString *const kNotificationCoreDidGenerateWarning = @"kNotificationCoreDidGenerateWarning";
NSString *const kNotificationCoreDidFail = @"kNotificationCoreDidFail";

// notification keys
NSString *const kNotificationKeyCoreMessage = @"Message";

// error codes
typedef NS_ENUM(NSInteger, CoreError) {
    CoreErrorNoActiveProfiler = 1000
};


@interface Core () {
    GDXProfiler *profiler;
    NSNumber    *lastPoint;
}

#pragma mark - Private

- (void)notify:(NSString *)notification userInfo:(NSDictionary *)userInfo;

@end


@implementation Core


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, nil);
    
    return nil;
}

- (instancetype)initPrivate {
    return [super init];
}

+ (instancetype)instance {
    static Core *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] initPrivate];
    });
    return instance;
}


#pragma mark - Common

- (void)profilerStart {
    if (profiler) {
        // warn about single profiler mode
        NSString *msg = @"This is a single profiler demo, so you should stop previous profiler before starting a new one. This will be done automatically for now.";
        [self notify:kNotificationCoreDidGenerateWarning userInfo:@{kNotificationKeyCoreMessage: msg}];
        
        [self profilerStop];
    }
    profiler = [GDXProfiler start];
    
    [self notify:kNotificationCoreDidStartProfiling userInfo:nil];
}

- (void)profilerPoint {
    if (!profiler) {
        NSString *msg = @"No active profiler found. Start profiling before saving a point.";
        [self notify:kNotificationCoreDidFail userInfo:@{kNotificationKeyCoreMessage: msg}];
        
        return;
    }
    lastPoint = @([profiler point]); // save point for further measurement
    
    [self notify:kNotificationCoreDidPoint userInfo:nil];
}

- (void)profilerStop {
    if (!profiler) {
        NSString *msg = @"No active profiler found. Start profiling before stopping.";
        [self notify:kNotificationCoreDidFail userInfo:@{kNotificationKeyCoreMessage: msg}];
        
        return;
    }
    double pointStop = [profiler stop]; // save stop point
    
    NSString *msg = nil;
    if (lastPoint) {
        msg = [NSString stringWithFormat:@"Time between last point saving and profiler stopping is %.3f s",
               (pointStop - lastPoint.doubleValue)];
        lastPoint = nil; // don't forget to remove last saved point
    }
    else {
        msg = @"No points were saved during profiler's work.";
    }
    // notify
    [self notify:kNotificationCoreDidStopProfiling userInfo:@{kNotificationKeyCoreMessage: msg}];
}

- (void)profilerRestart {
    if (!profiler) {
        NSString *msg = @"No active profiler found. Start profiling before restarting.";
        [self notify:kNotificationCoreDidFail userInfo:@{kNotificationKeyCoreMessage: msg}];
        
        return;
    }
    [profiler restart];
    lastPoint = nil; // don't forget to remove last saved point
    
    [self notify:kNotificationCoreDidRestartProfiling userInfo:nil];
}


#pragma mark - Private

- (void)notify:(NSString *)notification userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:notification
                                                        object:self
                                                      userInfo:userInfo];
}

@end

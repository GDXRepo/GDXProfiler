/*
 
 GitHub: NRGRepo/NRGProfiler
 
 The Apache License
 
 Copyright (c) 2015 Georgiy Malyukov
 
 */

#import <Foundation/Foundation.h>


@interface NRGProfiler : NSObject {
    
}

@property (readonly, nonatomic) uint64_t startTime;
@property (readonly, nonatomic) double   elapsedSeconds;


+ (instancetype)startWithMessage:(NSString *)msg;
- (double)pointWithMessage:(NSString *)msg;
- (double)stopWithMessage:(NSString *)msg;
- (void)restartWithMessage:(NSString *)msg;

+ (instancetype)start;
- (double)point;
- (double)stop;
- (void)restart;

@end

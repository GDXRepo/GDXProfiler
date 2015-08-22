//
//  Core.h
//  DDLTest
//
//  Created by Georgiy Malyukov on 14.05.15.
//
//

#import <Foundation/Foundation.h>

// error domain
extern NSString *const kCoreErrorDomain;

// notifications
extern NSString *const kNotificationCoreDidStartProfiling;
extern NSString *const kNotificationCoreDidPoint;
extern NSString *const kNotificationCoreDidStopProfiling;
extern NSString *const kNotificationCoreDidRestartProfiling;
extern NSString *const kNotificationCoreDidGenerateWarning;
extern NSString *const kNotificationCoreDidFail;

// notification keys
extern NSString *const kNotificationKeyCoreMessage;


@interface Core : NSObject {
    
}

#pragma mark - Root

+ (instancetype)instance;


#pragma mark - Common

- (void)profilerStart;
- (void)profilerPoint;
- (void)profilerStop;
- (void)profilerRestart;

@end

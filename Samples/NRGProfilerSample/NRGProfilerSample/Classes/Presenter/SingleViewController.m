//
//  SingleViewController.m
//  NRGProfilerSample
//
//  Created by Георгий Малюков on 22.08.15.
//  Copyright (c) 2015 Georgiy Malyukov. All rights reserved.
//

#import "SingleViewController.h"
#import "Core.h"


@interface SingleViewController () {
    
}

#pragma mark - Observing

- (void)subscribe:(NSString *)notification selector:(SEL)selector;
- (void)unsubscribe:(NSString *)notification;

- (void)observeCoreDidStopProfiling:(NSNotification *)notification;
- (void)observeCoreDidGenerateWarning:(NSNotification *)notification;
- (void)observeCoreDidFail:(NSNotification *)notification;


#pragma mark - Actions

- (IBAction)startButtonClick:(id)sender;
- (IBAction)pointButtonClick:(id)sender;
- (IBAction)restartButtonClick:(id)sender;

@end


@implementation SingleViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // observing
    [self subscribe:kNotificationCoreDidStopProfiling selector:@selector(observeCoreDidStopProfiling:)];
    [self subscribe:kNotificationCoreDidGenerateWarning selector:@selector(observeCoreDidGenerateWarning:)];
    [self subscribe:kNotificationCoreDidFail selector:@selector(observeCoreDidFail:)];
}

- (void)dealloc {
    [self unsubscribe:kNotificationCoreDidStopProfiling];
    [self unsubscribe:kNotificationCoreDidGenerateWarning];
    [self unsubscribe:kNotificationCoreDidFail];
}


#pragma mark - Observing

- (void)subscribe:(NSString *)notification selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:notification
                                               object:nil];
}

- (void)unsubscribe:(NSString *)notification {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:notification
                                                  object:nil];
}

- (void)observeCoreDidStopProfiling:(NSNotification *)notification {
    NSLog(@"%@", notification.userInfo[kNotificationKeyCoreMessage]);
}

- (void)observeCoreDidGenerateWarning:(NSNotification *)notification {
    [[[UIAlertView alloc] initWithTitle:@"Warning"
                                message:notification.userInfo[kNotificationKeyCoreMessage]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}

- (void)observeCoreDidFail:(NSNotification *)notification {
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:notification.userInfo[kNotificationKeyCoreMessage]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}


#pragma mark - Actions

- (IBAction)startButtonClick:(id)sender {
    [[Core instance] profilerStart];
}

- (IBAction)pointButtonClick:(id)sender {
    [[Core instance] profilerPoint];
}

- (IBAction)restartButtonClick:(id)sender {
    [[Core instance] profilerRestart];
}

@end

//
//  APIdleManager.m
//
//  Created by Malleo, Mitch on 12/8/14.
//

#import "APIdleManager.h"

@interface APIdleManager()

@property (nonatomic, strong) NSTimer *idleTimer;
@property (nonatomic, strong) NSDate *lastInteraction;
@property (nonatomic, assign) BOOL didTimeout;

@end

static APIdleManager *_sharedInstance = nil;

@implementation APIdleManager

+ (APIdleManager *) sharedInstance
{
    static dispatch_once_t p = 0;
    
    static id _sharedObject = nil;
    
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    return _sharedObject;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        [self createTimer];
        self.willCreateNewTimerOnTimeout = YES;
    }
    
    return self;
}

- (void) createTimer
{
    self.lastInteraction = [NSDate date];
    
    if (self.idleTimer)
    {
        [self.idleTimer invalidate];
    }
    
    self.didTimeout = NO;
    self.idleTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                      target:self
                                                    selector:@selector(checkDidTimeout)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void) checkAndReset
{
    if (![self checkDidTimeout])
    {
        [self createTimer];
    }
}

- (BOOL) checkDidTimeout
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval interactionTime = [currentDate timeIntervalSinceDate: self.lastInteraction];
    
    if (interactionTime > kMaxIdleTimeSeconds - 1 && !self.didTimeout)
    {
        [self timedOut];
        return YES;
    }
    
    return NO;
}

- (void) timedOut
{
    if(self.onTimeout)
    {
        [self.idleTimer invalidate];
        self.idleTimer = nil;
        self.didTimeout = YES;
        self.onTimeout();
        
        if(self.willCreateNewTimerOnTimeout)
        {
            [self createTimer];
        }
    }
}

- (void) didReceiveInput
{
    self.lastInteraction = [NSDate date];
}


@end

//
//  APIdleManager.h
//
//  Created by Malleo, Mitch on 12/18/14.
//

#import <Foundation/Foundation.h>

#define kMaxIdleTimeSeconds 5.0

typedef void(^APCompleteBlock)(void);

@interface APIdleManager : NSObject

@property (copy, nonatomic) APCompleteBlock onTimeout;
@property BOOL willCreateNewTimerOnTimeout;

+ (instancetype)sharedInstance;

- (void)didReceiveInput;
- (void)checkAndReset;

//Should only be used for manually creating a new timer
- (void) createTimer;

@end

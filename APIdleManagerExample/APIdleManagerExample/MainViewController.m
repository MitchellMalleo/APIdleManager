//
//  MainViewController.m
//  APIdleManager
//
//  Created by Malleo, Mitch on 12/18/14.
//  Copyright (c) 2014 Mitch Malleo. All rights reserved.
//

#import "MainViewController.h"
#import "APIdleManager.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeoutLabel;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [APIdleManager sharedInstance].onTimeout = ^(void){
        [self.timeoutLabel  setText:@"YES"];
    };
}

-(UIResponder *)nextResponder
{
    [[APIdleManager sharedInstance] didReceiveInput];
    
    return [super nextResponder];
}

@end
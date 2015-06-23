# APIdleManager

## Description

A idle timeout class in iOS. Allows custom idle timeout functionality that handles background and active instances of applications without having to subclass UIApplication.

## Requirements

- ARC
- iOS 5.0+

## Installation

1. APIdleManager can be installed via [Cocoapods](http://cocoapods.org/) by adding `pod 'ApIdleManager'` to your podfile, or you can manually add `APIdleManager.h` and `APIdleManager.m` into your project.
2. Implement the `onTimeout` block to instaniate the idle manager, start your idle timer, and implement and functionality that is necessary for when the application times out. Without any block implementation, the class will not function properly.

    ```
    [APIdleManager sharedInstance].onTimeout = ^(void){ //Timeout implementation goes here };
    ```
3. Make sure that `kMaxIdleTimeSeconds` is set to how many seconds until you want the application to run its timeout functionality. It is located in the APIdleManager's header file.

    ```
    //	APIdleManager.h
	 
	#define kMaxIdleTimeSeconds 60.0
    ```


## Usage

Use `[[APIdleManager sharedInstance] didReceiveInput];` to refresh your timer. To intercept any touches within a view controller, override the `-(UIResponder *)nextResponder` method:

	- (UIResponder *)nextResponder
	{
   		[[APIdleManager sharedInstance] didReceiveInput];
   		//Any other previous functionality you had
   
   		return [super nextResponder];
	}
		

If your application goes into the background and the user re-opens the application, use `[[RTLIdleManager sharedInstance] checkAndReset]` to check if the alloted idle time has passed. The best default method for this is in the App Delegate:

    
    - (void)applicationDidBecomeActive:(UIApplication *)application
    {
    	[[RTLIdleManager sharedInstance] checkAndReset];
    }
    

 

The Idle Manager will always create a new timer if it has timed out due to `willCreateNewTimerOnTimeout` being defaulted to `YES`. If you wish to not have a constant idle timer or plan on manually allocating a new timer using `-(void)createTimer` set this boolean to `NO`

Examples can be found in the sample application. Enjoy. (:

## License

APIdleManager is available under the MIT license. See the LICENSE file for more info.
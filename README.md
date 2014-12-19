# APIdleManager

A idle timeout class in iOS. Allows custom idle timeout functionality that handles background and active instances of applications without having to subclass UIApplication.

### Example Setup

1. Clone the repo and drag APIdleManager.h/.m into your project.
2. Make sure to call `[APIdleManager sharedInstance].onTimeout = ^(void){ //Timeout implementation goes here };` to not only instaniate the idle manager and start your idle timer, but to implement any functionality that is necessary for when the application times out. Without any block implementation, the class will not function properly.
3. Make sure that `kMaxIdleTimeSeconds` is set to how many seconds until you want the application to run its timeout functionality. Its located in the APIdleManager.h and its defaulted to 60.0 seconds.
4. Now that your idle manager is allocated and ready to go, so now we're going to dig into how to manage the timer and making sure your app will still timeout in the background.

### Idle Timer Managing

- To intercept any touches within a view controller and refresh the timer, override the `-(UIResponder *)nextResponder` method (if you haven't already) and replace it with:

		-(UIResponder *)nextResponder
		{
    		[[APIdleManager sharedInstance] didReceiveInput];
    		//Any other previous functionality you had
    
    		return [super nextResponder];
		}
		
_NOTE: `-(UIResponder *)nextResponder` should be overriden in each view controller that needs to refesh the idle timer_

- `[[APIdleManager sharedInstance] didReceiveInput];` is also appropriate for any other time you would like to refresh your idle timer.

- If your application goes into the background and the user re-opens the application, make sure that you call `[[RTLIdleManager sharedInstance] checkAndReset]` on open to check if the alloted idle time has passed. The best place to call this method is in the `- (void)applicationDidBecomeActive:(UIApplication *)application` in the App Delegate.

- The Idle Manager will always create a new timer if it has timed out due to `willCreateNewTimerOnTimeout` being defaulted to `YES`. If you wish to not have a constant idle timer or plan on manually allocating a new timer using `-(void)createTimer` set this boolean to `NO`

Examples can be found in the sample application. Enjoy. (:

## License

APIdleManager is available under the MIT license. See the LICENSE file for more info.


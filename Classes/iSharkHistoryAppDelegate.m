//
//  iSharkHistoryAppDelegate.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 30.07.10.
//  Copyright own 2010. All rights reserved.
//

#import "iSharkHistoryAppDelegate.h"


@implementation iSharkHistoryAppDelegate

@synthesize window;
@synthesize locationViewController;
@synthesize navigationViewController;
@synthesize tabBarController;
#pragma mark -
#pragma mark Application lifecycle


- (void)applicationDidFinishLaunching:(UIApplication *)application
{	
	if([self initialSetupRequired]){
		NSLog(@"INITIAL");
		[[[[DataInfrastructureSetUpService alloc]init]autorelease]importData];
	} else {
		NSLog(@"UPDATE");
		[[[[SynchronizationService alloc]init]autorelease] synchronizeIncidents];
    }
	
    
	self.window						= [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.tabBarController           = [[UITabBarController alloc]init];
    
    self.locationViewController		= [[LocationViewController alloc] initWithIncidentService: [[IncidentService alloc]init]];
	self.navigationViewController	= [[UINavigationController alloc] initWithRootViewController:self.locationViewController];
    
    
     
    UIViewController *vc1 = self.navigationViewController;
	UIViewController *vc2 = [[SharkAdvicesViewController alloc] init];
    UIViewController *vc3 = [[IncidentUpdateViewController alloc] init];
    
	// Make an array containing the two view controllers
	NSArray *viewControllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
	
	// Attach them to the tab bar controller
	[tabBarController setViewControllers:viewControllers];
	
	[vc1 release];
	[vc2 release];
    [vc3 release];
    
    [self.window addSubview: self.tabBarController.view];
    [self.window makeKeyAndVisible];
}


- (BOOL) initialSetupRequired{
	return ![
			 [NSFileManager defaultManager] 
				fileExistsAtPath:
					[self.applicationDocumentsDirectory stringByAppendingPathComponent:@"iSharkHistory.sqlite"]
			];
}



#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[window release];
    [super dealloc];
}


@end


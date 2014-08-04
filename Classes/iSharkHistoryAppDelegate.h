//
//  iSharkHistoryAppDelegate.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 30.07.10.
//  Copyright own 2010. All rights reserved.
//



#import "IncidentService.h"
#import "LocationViewController.h"
#import "CachedIncidentService.h"
#import "SynchronizationService.h"
#import "DataInfrastructureSetUpService.h"
#import "IncidentUpdateViewController.h"
#import "SharkAdvicesViewController.h"

@interface iSharkHistoryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	LocationViewController *locationViewController;
	UINavigationController *navigationViewController;
    UITabBarController* tabBarController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationViewController;
@property (nonatomic, retain) LocationViewController *locationViewController;
@property (nonatomic, retain) UITabBarController *tabBarController;

- (NSString *)applicationDocumentsDirectory;

@end


//
//  DetailViewController.h
//  iActiviti
//
//  Created by Selcuk Turhan on 21.06.10.
//  Copyright 2010 own. All rights reserved.
//


#import "Incident.h"
#import "SharkWebViewController.h"

#import "Utilities.h"

static NSString* wikipediaURL = @"http://en.wikipedia.org/wiki/";

@interface DetailViewController : UITableViewController {
	Incident*				incident;
	NSMutableDictionary*	sharkSpeciesToInfoUrl;
}

@property (nonatomic, retain) Incident*				incident;
@property (nonatomic, retain) NSMutableDictionary*	sharkSpeciesToInfoUrl;

- (id) initWithIncidentAndStyle: (Incident *)		incident;

@end

// 
//  Incident.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 19.02.11.
//  Copyright 2011 own. All rights reserved.
//

#import "Incident.h"


@implementation Incident 

@dynamic location;
@dynamic country;
@dynamic sex;
@dynamic species;
@dynamic latitude;
@dynamic activity;
@dynamic injury;
@dynamic longitude;
@dynamic area;
@dynamic age;
@dynamic addInfo;
@dynamic attackDate;
@dynamic incidentId;

@synthesize title;
@synthesize subtitle;

- (CLLocationCoordinate2D)coordinate
{
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    return coordinate;
}

- (NSString*) title
{
	return [Utilities getFormattedDate: self.attackDate] ;
}

- (NSString*)subtitle
{
    return self.activity;
}

-(void)dealloc{
	self.title = nil;
	self.subtitle = nil;
	[super dealloc];
}


@end

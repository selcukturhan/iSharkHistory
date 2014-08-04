//
//  MapAnnotation.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 17.08.10.
//  Copyright 2010 own. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

@synthesize injury;
@synthesize age;
@synthesize gender;
@synthesize longitude;
@synthesize area;
@synthesize source;
@synthesize latitude;
@synthesize location;
@synthesize date;
@synthesize activity;
@synthesize country;
@synthesize name;

- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoordinate
{
	if (self = [super init]) {
		coordinate = aCoordinate;
	}
	return self;
}

-(void) dealloc
{
	self.title = nil;
	self.subtitle = nil;
	[super dealloc];
}
@end


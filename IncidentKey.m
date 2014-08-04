//
//  IncidentKey.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 10.09.10.
//  Copyright 2010 own. All rights reserved.
//

#import "IncidentKey.h"


@implementation IncidentKey
@synthesize longitude;
@synthesize latitude;


- (id) initWithLatitude: (NSNumber*) aLatitude andWithLongitude:(NSNumber*) aLongitude{
	if(self = [super init]){
		self.latitude = aLatitude;
		self.longitude = aLongitude;
	}
	return self;
}


- (BOOL)isEqual:(id)anObject{
	
	if(!anObject || ![anObject isKindOfClass:[self class]])
		return NO;
	
	if(self == anObject)
		return YES;

	IncidentKey* tmpIncidentKey = (IncidentKey*)anObject;
	
	return [self.latitude isEqualToNumber: tmpIncidentKey.latitude] && [self.longitude isEqualToNumber: tmpIncidentKey.longitude];
}

- (id)copyWithZone:(NSZone *)zone{
	IncidentKey* newIncidentKey = [[IncidentKey allocWithZone:zone]init];
	newIncidentKey.longitude = [self.longitude copyWithZone:zone];
	newIncidentKey.latitude = [self.latitude copyWithZone:zone];
	return newIncidentKey;
}


@end

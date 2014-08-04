//
//  IncidentKey.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 10.09.10.
//  Copyright 2010 own. All rights reserved.
//




@interface IncidentKey : NSObject<NSCopying> {
	NSNumber * longitude;
	NSNumber * latitude;
}
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * latitude;

- (id) initWithLatitude: (NSNumber*) aLatitude andWithLongitude:(NSNumber*) aLongitude;
@end

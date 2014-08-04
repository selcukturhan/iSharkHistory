//
//  Incident.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 19.02.11.
//  Copyright 2011 own. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "Utilities.h"


@interface Incident :  NSManagedObject <MKAnnotation>  
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * species;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * injury;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * addInfo;
@property (nonatomic, retain) NSDate * attackDate;
@property (nonatomic, retain) NSString * incidentId;


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@end




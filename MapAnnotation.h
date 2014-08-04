//
//  MapAnnotation.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 17.08.10.
//  Copyright 2010 own. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
	
	NSString * injury;
	NSString * age;
	NSString * gender;
	NSNumber * longitude;
	NSString * area;
	NSString * source;
	NSNumber * latitude;
	NSString * location;
	NSDate	 * date;
	NSString * activity;
	NSString * country;
	NSString * name;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;


@property (nonatomic, retain) NSString * injury;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * name;

@end

//
//  LocationViewController.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 17.08.10.
//  Copyright 2010 own. All rights reserved.
//


#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "DetailViewController.h"
#import "ReportIncidentController.h"
#import "IncidentServiceDelegate.h"
#import "FilterDelegate.h"

@class Incident;
@class AttackDatePickerController;

@interface LocationViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, FilterDelegate>{
	CLLocationManager*				locationManager;
	MKMapView*						mapView;
	CLLocation*						currentLocation;
	id <IncidentServiceDelegate>	incidentServiceDelegate;
	UIActivityIndicatorView*		aiv;
	NSArray*						incidents;
	
	//Overlay for activity in progress
	UIView *overlay;
	NSDate*							filterDate;
	NSString*						dateOperator;
	
}


@property (nonatomic, retain) CLLocationManager*			locationManager;
@property (nonatomic, retain) CLLocation*					currentLocation;
@property (nonatomic, retain) MKMapView*					mapView;
@property (nonatomic, retain) id <IncidentServiceDelegate>	incidentServiceDelegate;
@property (nonatomic, retain) UIActivityIndicatorView*		aiv;
@property (nonatomic, retain) UIView*						overlay;
@property (nonatomic, retain) NSArray*						incidents;
@property (nonatomic, retain) NSDate*						filterDate;
@property (nonatomic, retain) NSString*						dateOperator;


- (id) initWithIncidentService: (id <IncidentServiceDelegate>) aIncidentServiceDelegate;

@end

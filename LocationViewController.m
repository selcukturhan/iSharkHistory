    //
//  LocationViewController.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 17.08.10.
//  Copyright 2010 own. All rights reserved.
//

#import "LocationViewController.h"

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]


@implementation LocationViewController

@synthesize locationManager;
@synthesize currentLocation;
@synthesize mapView;
@synthesize incidentServiceDelegate;
@synthesize aiv;
@synthesize incidents;
@synthesize overlay;
@synthesize filterDate;
@synthesize dateOperator;



- (id) initWithIncidentService: (id <IncidentServiceDelegate>) aIncidentServiceDelegate {
	if (self = [super init]) {
        self.incidentServiceDelegate = aIncidentServiceDelegate;
		self.filterDate = [NSDate date];
		self.dateOperator = @"<";
        
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Attacks"];
        UIImage *i = [UIImage imageNamed:@"radar.png"];
        [tbi setImage:i];
    }
	return self;
}



- (void) loadView {
    [super loadView];
	self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	self.title = @"Attacks";
	//self.navigationItem.rightBarButtonItem	= BARBUTTON(@"Report Incident", @selector(reportIncident:));
	self.navigationItem.leftBarButtonItem	= BARBUTTON(@"Timefilter",		@selector(openAttackDatePicker:));
	
	//overlay
	self.overlay	= [[UIView alloc]initWithFrame:self.view.bounds];
	self.aiv		= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
	[self.aiv		setCenter: CGPointMake(160.0f, 190.0f)]; 
	[self.overlay	setBackgroundColor: [UIColor colorWithWhite:0.7f alpha:0.5f] ];
	[self.overlay	addSubview: self.aiv];
	[self.mapView	addSubview: self.overlay];
	[self.aiv		startAnimating];
	
	[self.view addSubview:mapView];
	//setting locMgr delegate
	self.locationManager.delegate = self;
	
	self.locationManager = [[CLLocationManager alloc] init];
	if (!CLLocationManager.locationServicesEnabled) {
		NSLog(@"User has opted out of location services");
		return;
	}
	else {
		// User generally allows location calls
		self.locationManager.desiredAccuracy	= kCLLocationAccuracyBest;
		mapView.showsUserLocation				= YES;
		mapView.zoomEnabled						= YES;
		mapView.delegate						= self;
		[self mapView: self.mapView regionDidChangeAnimated: NO];
	}
}



#pragma mark mapView-Callbacks

//action-handler for updating mapView when mapView is tapped. Forwards to updateMapView: 
- (void)mapView:(MKMapView *)map regionDidChangeAnimated:(BOOL)animated {
	[self updateMapView:
		[self.incidentServiceDelegate 
			incidentsForMapRegion:mapView.region 
			maximumCount:1000 
			filterDate:filterDate 
			dateOperator: 
			self.dateOperator]
	];
}


- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
	//handle currentLocation annotation
	if ([annotation isKindOfClass:[MKUserLocation class]]){
		static NSString *currentLocationViewID = @"currentLocation";
		MKPinAnnotationView* currentLocationAnnotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:currentLocationViewID];
		if(currentLocationAnnotationView == nil) {
			currentLocationAnnotationView					= [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier: currentLocationViewID]autorelease];
			currentLocationAnnotationView.pinColor			= MKPinAnnotationColorPurple;
			currentLocationAnnotationView.canShowCallout	= YES;
			currentLocationAnnotationView.annotation		= annotation;
		}
		return currentLocationAnnotationView;
	}
	
	
	//handle incident annotations
    static NSString *AnnotationViewID = @"incident";
	MKPinAnnotationView* incidentAnnotationView	= (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
	if(incidentAnnotationView == nil) {
		incidentAnnotationView								= [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:AnnotationViewID]autorelease];
		incidentAnnotationView.animatesDrop					= NO;
		incidentAnnotationView.canShowCallout				= YES;
		UIButton* button									= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		incidentAnnotationView.rightCalloutAccessoryView	= button;
		incidentAnnotationView.annotation					= annotation;
		
		UIImageView *sfIconView								= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shark-warning-gimp-250.png"]];
		incidentAnnotationView.leftCalloutAccessoryView		= sfIconView;
		[sfIconView release];
	}
	return incidentAnnotationView;
}



- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	//instantiate controllerclass
	DetailViewController* detailViewController = [[[DetailViewController alloc]initWithIncident:view.annotation andStyle:UITableViewStyleGrouped]autorelease];
	//push controllerclass on stack
	[((UINavigationController*)self.parentViewController) pushViewController: detailViewController animated: YES]; 
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
	NSLog(@"IN didAddAnnotationViews");
	[self.aiv stopAnimating];
	[self.overlay removeFromSuperview];
}


//Tells the delegate that the specified map view successfully loaded the needed map data.
//todo: check if necessary
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
	NSLog(@"IN");
}

//method wich is responsible for updating the mapView
-(void)updateMapView:(NSArray *) newIncidents {
	self.incidents = newIncidents;
	[mapView removeAnnotations:mapView.annotations];
	
	if ([newIncidents count] > 0) {
		[self.mapView addSubview: self.overlay];
		[self.aiv startAnimating];
	}
	NSLog(@"Count: %i", [newIncidents count]);
    [mapView addAnnotations:incidents];
}



#pragma mark action-handler
- (void) reportIncident: (id) sender {
	//instantiate controllerclass
    //push controllerclass on stack
	[((UINavigationController*)self.parentViewController) pushViewController: [[[ReportIncidentController alloc]init]autorelease] animated: YES];
}


-(void)openAttackDatePicker:(id) sender {
	//instantiate controllerclass
	//push controllerclass on stack
	[((UINavigationController*) self.parentViewController) pushViewController:  [[[AttackDatePickerController alloc]initWithFilterDelegate: self]autorelease] animated: YES];
}




//Callback-Method is called from datefilterview when user wants to start filteroperation
- (void) startFilter:(NSDate*) inputFilterDate dateOperator:(NSString*)inputDateOperator {
	self.filterDate		= inputFilterDate;
	self.dateOperator	= inputDateOperator;
	[self updateMapView:
		[self.incidentServiceDelegate	incidentsForMapRegion:	mapView.region 
										maximumCount:			1000 
										filterDate:				self.filterDate
										dateOperator:			self.dateOperator]
	];
}







#pragma mark callback for locationUpdates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation 
															fromLocation:(CLLocation *)oldLocation
{
	//disable further location for the moment
	self.locationManager.delegate = nil;
	[self.locationManager stopUpdatingLocation];
	
	// Set the current location
	self.currentLocation = newLocation;
	// Set the map to that location and allow user interaction
	self.mapView.region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.0005f, 0.0005f));
	self.mapView.zoomEnabled = YES;
	
}


- (void)dealloc {
	[locationManager release];
	[mapView release];
	[currentLocation release];
	[incidentServiceDelegate release];
	[incidents release];
    
	[super dealloc];
}


@end

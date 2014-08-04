//
//  IncidentServiceDelegate.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 09.09.10.
//  Copyright 2010 own. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol IncidentServiceDelegate <NSObject>
@optional
- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount;
- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount filterDate:(NSDate*)filterDate;

@end

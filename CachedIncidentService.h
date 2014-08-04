//
//  CachedIncidentService.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 09.09.10.
//  Copyright 2010 own. All rights reserved.
//


#import "IncidentServiceDelegate.h"
#import "Incident.h"
#import "IncidentKey.h"
#import "PersistenceProvider.h"

@interface CachedIncidentService : NSObject<IncidentServiceDelegate> {
	PersistenceProvider* persistenceProvider;
	NSMutableDictionary* incidents;
}

@property(nonatomic, retain) NSMutableDictionary* incidents;
@property (nonatomic, retain) PersistenceProvider* persistenceProvider;


- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount;
- (void) prepareIncidentData;


@end

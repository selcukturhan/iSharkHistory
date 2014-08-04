//
//  CachedIncidentService.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 09.09.10.
//  Copyright 2010 own. All rights reserved.
//

#import "CachedIncidentService.h"


@implementation CachedIncidentService
@synthesize incidents;
@synthesize persistenceProvider;


- (id) init{
	if(self = [super init]){
		self.persistenceProvider = [PersistenceProvider sharedInstance];
		[self prepareIncidentData];
	}
	return self;
}

- (BOOL) is:(NSNumber*) aFirstNumber greaterEqualsThan: (NSNumber*) aSecondNumber{
	return  ([self is:aFirstNumber greaterThan: aSecondNumber])
		|| ([self is:aFirstNumber equalsTo: aSecondNumber]); 
}

- (BOOL) is:(NSNumber*) aFirstNumber lessEqualsThan: (NSNumber*) aSecondNumber{
	return  ([self is:aFirstNumber lessThan: aSecondNumber])
	|| ([self is:aFirstNumber equalsTo: aSecondNumber]); 
}


- (BOOL) is:(NSNumber*) aFirstNumber greaterThan: (NSNumber*) aSecondNumber{
	return  [aFirstNumber compare: aSecondNumber] == NSOrderedDescending;

}

- (BOOL) is:(NSNumber*) aFirstNumber equalsTo: (NSNumber*) aSecondNumber{
	return [aFirstNumber compare: aSecondNumber] == NSOrderedSame; 
}

- (BOOL) is:(NSNumber*) aFirstNumber lessThan: (NSNumber*) aSecondNumber{
	return  [aFirstNumber compare: aSecondNumber] == NSOrderedAscending;
	
}






- (void) prepareIncidentData
{
	
	NSFetchRequest* fetchRequest = [[NSFetchRequest alloc]init];
	[fetchRequest setEntity:[NSEntityDescription entityForName: @"Incident" inManagedObjectContext:self.persistenceProvider.managedObjectContext]];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:nil];
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	[fetchRequest setSortDescriptors:descriptors];
	
	// Recover query
	NSString *query = @"";
	if (query && query.length) fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", query];
	
	// Init the fetched results controller
	NSError* error;
	
	NSArray *fetchedItems = [self.persistenceProvider.managedObjectContext executeFetchRequest:fetchRequest error:&error];

	if (fetchedItems == nil)
    {
        // an error occurred
        NSLog(@"fetch request resulted in an error %@, %@", error, [error userInfo]);
    }
	
	self.incidents = [[NSMutableDictionary alloc] init];
	
	for (Incident* incident in fetchedItems){
		[self.incidents setObject: incident 
                        forKey:[
                                [[IncidentKey alloc] 
                                    initWithLatitude: incident.latitude 
                                    andWithLongitude:incident.longitude]
                                autorelease]];
	}
	
	[fetchRequest release];
    [sortDescriptor release];
	[query release];
    
}


- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount
{
    
    NSNumber *latitudeStart = [NSNumber numberWithDouble:region.center.latitude - region.span.latitudeDelta/2.0];
    NSNumber *latitudeStop = [NSNumber numberWithDouble:region.center.latitude + region.span.latitudeDelta/2.0];
	
    NSNumber *longitudeStart = [NSNumber numberWithDouble:region.center.longitude - region.span.longitudeDelta/2.0];
    NSNumber *longitudeStop = [NSNumber numberWithDouble:region.center.longitude + region.span.longitudeDelta/2.0];
    
	NSLog(@"latitude>%@ AND latitude<%@ AND longitude>%@ AND longitude<%@", latitudeStart, latitudeStop, longitudeStart, longitudeStop);
	
	NSSet * mySet = [self.incidents keysOfEntriesPassingTest:^(id key, id obj, BOOL *stop) {
						if(	[self is:[key latitude] greaterEqualsThan: latitudeStart]
						   && [self is:[key latitude] lessEqualsThan: latitudeStop]
						   && [self is:[key longitude] greaterEqualsThan: longitudeStart]
						   && [self is:[key longitude] lessEqualsThan: longitudeStop])
								return YES;
							else
								return NO;
							 
							}//if
					 ];
	
	
	return [self.incidents objectsForKeys: [mySet allObjects] notFoundMarker: @"ende"];
}


- (void)dealloc {
	[incidents release];
	[super dealloc];
}


@end

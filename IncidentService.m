
#import "IncidentService.h"



@implementation IncidentService

@synthesize persistenceProvider;


- (id) init{
	if(self = [super init]){
		self.persistenceProvider = [PersistenceProvider sharedInstance];
	}
	return self;
}



- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount
{
    NSMutableArray *incidents = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Incident" inManagedObjectContext:self.persistenceProvider.managedObjectContext]];
    
    NSNumber *latitudeStart = [NSNumber numberWithDouble:region.center.latitude - region.span.latitudeDelta/2.0];
    NSNumber *latitudeStop = [NSNumber numberWithDouble:region.center.latitude + region.span.latitudeDelta/2.0];
	
    NSNumber *longitudeStart = [NSNumber numberWithDouble:region.center.longitude - region.span.longitudeDelta/2.0];
    NSNumber *longitudeStop = [NSNumber numberWithDouble:region.center.longitude + region.span.longitudeDelta/2.0];
    
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
									@"latitude>%@ AND latitude<%@ AND longitude>%@ AND longitude<%@", 
										latitudeStart, latitudeStop, longitudeStart, longitudeStop];
	
     NSLog(@"latitude>%@ AND latitude<%@ AND longitude>%@ AND longitude<%@", latitudeStart, latitudeStop, longitudeStart, longitudeStop);
	[fetchRequest setPredicate:predicate];
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    [sortDescriptors addObject:[[[NSSortDescriptor alloc] initWithKey:@"latitude" ascending:YES] autorelease]];
    [sortDescriptors addObject:[[[NSSortDescriptor alloc] initWithKey:@"longitude" ascending:YES] autorelease]];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
	NSError *error = nil;
    NSArray *fetchedItems = [self.persistenceProvider.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedItems == nil)
    {
        // an error occurred
        NSLog(@"fetch request resulted in an error %@, %@", error, [error userInfo]);
    }
    else
    {
		[incidents addObjectsFromArray:fetchedItems];
		NSLog(@"Number of fetched items %i", [fetchedItems count]);

        
    }
    [fetchRequest release];
    return incidents;
}


- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount filterDate:(NSDate*)filterDate dateOperator:(NSString*)dateOperator
{
    NSMutableArray *incidents		= [NSMutableArray array];
    NSFetchRequest *fetchRequest	= [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Incident" inManagedObjectContext:self.persistenceProvider.managedObjectContext]];
    
    NSNumber *latitudeStart			= [NSNumber numberWithDouble:region.center.latitude - region.span.latitudeDelta/2.0];
    NSNumber *latitudeStop			= [NSNumber numberWithDouble:region.center.latitude + region.span.latitudeDelta/2.0];
	
    NSNumber *longitudeStart		= [NSNumber numberWithDouble:region.center.longitude - region.span.longitudeDelta/2.0];
    NSNumber *longitudeStop			= [NSNumber numberWithDouble:region.center.longitude + region.span.longitudeDelta/2.0];
    
	NSPredicate *predicate			= [NSPredicate predicateWithFormat:
									   [@"latitude>%@ AND latitude<%@ AND longitude>%@ AND longitude<%@ AND attackDate" stringByAppendingString: [dateOperator stringByAppendingString: @"%@"]], 
									   latitudeStart, latitudeStop, longitudeStart, longitudeStop, filterDate];
	
	NSLog(@"latitude>%@ AND latitude<%@ AND longitude>%@ AND longitude<%@ AND attackDate ", latitudeStart, latitudeStop, longitudeStart, longitudeStop, filterDate);
	[fetchRequest setPredicate:predicate];
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    [sortDescriptors addObject:[[[NSSortDescriptor alloc] initWithKey:@"latitude" ascending:YES] autorelease]];
    [sortDescriptors addObject:[[[NSSortDescriptor alloc] initWithKey:@"longitude" ascending:YES] autorelease]];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
	NSError *error = nil;
    NSArray *fetchedItems = [self.persistenceProvider.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedItems == nil)
    {
        // an error occurred
        NSLog(@"fetch request resulted in an error %@, %@", error, [error userInfo]);
    }
    else
    {
		[incidents addObjectsFromArray:fetchedItems];
		NSLog(@"Number of fetched items %i", [fetchedItems count]);
		
        
    }
    [fetchRequest release];
    return incidents;
}


- (void)dealloc {
    [super dealloc];
}


@end



#import <MapKit/MapKit.h>
#import "Incident.h"
#import "PersistenceProvider.h"
#import "IncidentServiceDelegate.h"

@interface IncidentService : NSObject<NSFetchedResultsControllerDelegate, IncidentServiceDelegate>
{
@private
    PersistenceProvider* persistenceProvider;
}

@property (nonatomic, retain) PersistenceProvider* persistenceProvider;

- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount;
- (NSArray *)incidentsForMapRegion:(MKCoordinateRegion)region maximumCount:(NSInteger)maxCount filterDate:(NSDate*)filterDate;
@end

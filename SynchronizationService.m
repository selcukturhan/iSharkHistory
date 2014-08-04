//
//  ActivityService.m
//  iActiviti
//
//  Created by Selcuk Turhan on 30.06.10.
//  Copyright 2010 own. All rights reserved.
//

#import "SynchronizationService.h"


@implementation SynchronizationService
@synthesize delegate;
@synthesize persistenceProvider;

- (id) init{
	if(self = [super init]){
		self.persistenceProvider = [PersistenceProvider sharedInstance];
    }
	return self;
}



- (void) didReceiveData:(NSData *) theData{
	
    //no update is required
    if(theData == nil || [theData length] == 0){
        NSLog(@"Current status. No Update required");
        return;
    }
    
    NSData* data = theData;
    NSString* tmp = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]autorelease];
	NSDictionary* dictionary = [tmp JSONValue];
	
	for (id key in dictionary) {
		NSLog(@"key: %@, value: %@", key, [dictionary objectForKey:key]);
	}
	
    
    // Build an array from the dictionary for easy access to each entry
    NSArray *receivedIncidents = [dictionary objectForKey:@"incidentList"];
    int incidentCount    = [(NSString*)[dictionary objectForKey:@"incidentCount"]intValue];
    
    
    if(incidentCount > 1){
        for (NSDictionary* incident in receivedIncidents) {
            [self processReceivedIncident: incident];
        }
    } else{
         [self processReceivedIncident: receivedIncidents];
    }
}


-(void) processReceivedIncident:(NSDictionary*) receivedIncident{
    
    Incident* incident = (Incident*) [NSEntityDescription 
                                      insertNewObjectForEntityForName: @"Incident" 
                                      inManagedObjectContext:self.persistenceProvider.managedObjectContext];
    
    incident.activity   = (NSString*)[receivedIncident objectForKey:@"activity"];
    incident.age        = (NSNumber*)[receivedIncident objectForKey:@"age"];
    incident.country    = (NSString*)[receivedIncident objectForKey:@"country"];
    incident.attackDate = [self getStringAsDate:(NSString*)
                           [receivedIncident objectForKey:@"attackDate"]];
    incident.sex        = (NSString*)[receivedIncident objectForKey:@"sex"];
    incident.injury     = (NSString*)[receivedIncident objectForKey:@"injury"];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    incident.latitude   = [numberFormatter numberFromString:[receivedIncident objectForKey:@"latitude"]];
    incident.longitude  = [numberFormatter numberFromString:[receivedIncident objectForKey:@"longitude"]];
    [numberFormatter release];
    incident.location   =(NSString*)[receivedIncident objectForKey:@"location"];
    incident.species    =(NSString*)[receivedIncident objectForKey:@"species"];
    //TODO
    incident.incidentId = @"incidentId";
    incident.addInfo = @"addInfo";
    incident.area = @"area";
    incident.species= @"species";
    
    NSError* error;
    if(![self.persistenceProvider.managedObjectContext save: &error]){
        NSLog(@"An Error during save has occured!");
        NSLog(@"%@", [error localizedDescription]);
        DumpError(@"incident persist", error);
    }
}


- (NSDate*)getLastUpdate{
   
    NSFetchRequest *fetchRequest	= [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Incident" inManagedObjectContext: self.persistenceProvider.managedObjectContext]];
    
    // Specify that the request should return dictionaries.
    [fetchRequest setResultType:NSDictionaryResultType];
    
  	// Create an expression for the key path.
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"attackDate"];
    
    // Create an expression to represent the maximum value at the key path 'creationDate' 
    NSExpression *maxExpression = [NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    // Create an expression description using the maxExpression and returning a date. 
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc]init];
    // The name is the key that will be used in the dictionary for the return value. 
    [expressionDescription setName:@"maxAttackDate"];
    [expressionDescription setExpression:maxExpression]; 
    [expressionDescription setExpressionResultType:NSDateAttributeType];
    
    // Set the request's properties to fetch just the property represented by the expressions. 
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:expressionDescription]];
    // Execute the fetch. 
    NSError *error;
    NSArray *objects = [self.persistenceProvider.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (objects == nil) {
        // Handle the error.
    } else {
        if ([objects count] > 0) {
            NSLog(@"MAX date: %@", [[objects objectAtIndex:0] valueForKey:@"maxAttackDate"]);
        }
    }
    [expressionDescription release]; 
    [fetchRequest release];
    return [[objects objectAtIndex:0] valueForKey:@"maxAttackDate"];
}





-(void) synchronizeIncidents{
	[AsynchronousNetworkService sharedInstance].delegate = self;
    NSDate* lastUpdate = [self getLastUpdate];
    NSString* date = [self getDateAsString: lastUpdate];
    [AsynchronousNetworkService download: [URL_SYNCHRONIZATION_SERVICE stringByAppendingString: [self getDateAsString: lastUpdate]]];
    
    
}


- (void) dataDownloadFailed:(NSString *) reason{
	if (self.delegate && [self.delegate respondsToSelector:@selector(dataDownloadFailed:)]){
		[self.delegate dataDownloadFailed:reason];
	}
}


- (NSDate*) getStringAsDate:(NSString*) dateString{
    return [[[[ISO8601DateFormatter alloc]init]autorelease]dateFromString:dateString];  
}


- (NSString*) getDateAsString:(NSDate*) date{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];  
    return [dateFormatter stringFromDate:date];
}



void DumpError(NSString* action, NSError* error) {
    
    if (!error)
        return;
    
    NSLog(@"Failed to %@: %@", action, [error localizedDescription]);
    NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
    if(detailedErrors && [detailedErrors count] > 0) {
        for(NSError* detailedError in detailedErrors) {
            NSLog(@"DetailedError: %@", [detailedError userInfo]);
        }
    }
    else {
        NSLog(@"%@", [error userInfo]);
    }
}

- (void)dealloc {
    self.delegate = nil;
    //[persistenceProvider release];
	
    [super dealloc];
}



@end

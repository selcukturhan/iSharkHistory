//
//  DataInfrastructureSetUpService.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 21.02.11.
//  Copyright 2011 own. All rights reserved.
//

#import "DataInfrastructureSetUpService.h"


@implementation DataInfrastructureSetUpService

enum SheetStructure{
	kIncidentId = 0,
	kDate, 
	kVague,
	kVountry,
	kArea,
	kLocation,
	kActivity,
	kSex,
	kAge,
	kInjury,
	kAttackTime,
	kSpecies,
	kProvoked,
	kBoatAttack,
	kQuestionableIncident,
	kCowSeaAirDesaster,
	kLongitude,
	kLatitude 
};


@synthesize persistenceProvider;


- (id) init{
	if(self = [super init]){
		self.persistenceProvider = [PersistenceProvider sharedInstance];
	}
	return self;
}


- (void) importData {
	//    ----------
	NSString *sName, *sFile, *sData;
	NSArray *aRow, *aData;
	
	
	
	sName = @"gpsData.csv";
	sFile = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sName]; 
	sData = [[NSString alloc] initWithContentsOfFile:sFile encoding:NSUTF8StringEncoding error:nil];
	
	aRow = [sData componentsSeparatedByString:@"\n"];
	[sData release];
	NSLog(@"%i", [aRow count]);
	int index = 1;
	for (NSString *sRow in aRow) {
		aData = [sRow componentsSeparatedByString:@"|"];
		NSLog(@"%i", index++);
		
		NSString*   incidentId			= [aData objectAtIndex: 0];
		NSString*   attackDate			= [aData objectAtIndex: 1];
		NSString*   country				= [aData objectAtIndex: 2];
		NSString*   area				= [aData objectAtIndex: 3];
		NSString*   location			= [aData objectAtIndex: 4];
		NSString*   activity			= [aData objectAtIndex: 5];
		NSString*   sex					= [aData objectAtIndex: 6];
		NSString*   age					= [aData objectAtIndex: 7];
		NSString*   injury				= [aData objectAtIndex: 8];
		NSString*   species				= [aData objectAtIndex: 9];
		
		NSNumber*   longitude			= [NSNumber numberWithDouble:[[aData objectAtIndex: 11] doubleValue]];
		NSNumber*   latitude			= [NSNumber numberWithDouble:[[aData objectAtIndex: 10] doubleValue]];
		NSString*   addInfo				= [aData objectAtIndex: 12];
		NSDate*     dateAndTime			= [self normalizeDate: [self asDate: attackDate]];
		
		
		NSError* error;
		
		Incident* incident				= (Incident*) [NSEntityDescription 
													   insertNewObjectForEntityForName: @"Incident" 
													   inManagedObjectContext:			self.persistenceProvider.managedObjectContext];
		
		incident.incidentId				= incidentId;
		incident.attackDate				= dateAndTime;
		incident.country				= country;
		incident.area					= area;
		incident.location				= location;
		incident.activity				= activity;
		incident.sex					= sex;
		incident.age					= age;
		incident.injury					= injury;
		incident.species				= species;
		incident.longitude				= longitude;
		incident.latitude				= latitude;
		incident.addInfo				= addInfo;
		
		if(![self.persistenceProvider.managedObjectContext save: &error]){
			NSLog(@"An Error during save has occured!");
		}
	}//for (NSString *sRow in aRow) 
}


-(BOOL) handleJavaBool: (NSString*) boolValue{
	if(boolValue != nil){
		return ([boolValue isEqualToString: @"true"]) ? YES : NO; 
	}
	return nil;
}


- (NSDate *) nilDate {
	//        -------
	NSDateFormatter *oFormat = [[NSDateFormatter alloc] init];
	[oFormat setDateFormat:@"01/01/0001"];
	
	NSDate *dValue = [oFormat dateFromString:@"01/01/0001"];
	
	[oFormat release];
	
	return dValue;
}

- (NSDate *) asDate: (NSString*) timeIndication {
	//        ------
	// YYYY-MM-DD HH:MM -> Datum
	// siehe http://unicode.org/reports/tr35/tr35-6.html#Date%5FFormat%5FPatterns
	if (timeIndication == nil) {
		return [self nilDate];
	}
	
	static NSDateFormatter *oDateFormatter = nil;
	
	if (oDateFormatter == nil) {
		NSLocale *oLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		oDateFormatter = [[NSDateFormatter alloc] init];
		oDateFormatter.locale = oLocale;
		//[oDateFormatter release];
		[oLocale release];
	}
	
	oDateFormatter.dateFormat = @"dd-MMM-yyyy";
	NSDate *dValue = [oDateFormatter dateFromString:timeIndication];
	
	
	
	return dValue;
}


-(NSDate*)normalizeDate:(NSDate*) date{
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]autorelease];
	NSUInteger mask =	NSYearCalendarUnit | NSMonthCalendarUnit |
						NSDayCalendarUnit  | NSHourCalendarUnit  |
						NSMinuteCalendarUnit | NSSecondCalendarUnit;
	
    NSDateComponents *components = [gregorian components: mask fromDate: date];
	
	[components setHour:    0];
	[components setMinute:  0];
	[components setSecond:  0];
	
	return [gregorian dateFromComponents: components];
	
}


@end

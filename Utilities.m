//
//  Utilities.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 03.03.11.
//  Copyright 2011 own. All rights reserved.
//

#import "Utilities.h"




@implementation Utilities


+ (NSString*) getFormattedDate: (NSDate*) aDate{
	if (!aDate) {
		@throw([NSException exceptionWithName: @"Actualparameter is nil!" reason: @"Actualparameter aDate is nil!"  userInfo:nil]);
	}
	
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	
	NSLocale *usLocale = [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]autorelease];
	[dateFormatter setLocale:usLocale];
	return [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:aDate];
}
@end

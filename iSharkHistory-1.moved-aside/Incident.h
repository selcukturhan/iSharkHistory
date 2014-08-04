//
//  Incident.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 30.07.10.
//  Copyright 2010 own. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Incident :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate   * date;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * activity;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * injury;
@property (nonatomic, retain) NSString * time;

@property (nonatomic, retain) NSString * source;




@end




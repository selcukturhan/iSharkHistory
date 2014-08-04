//
//  PersistenceProvider.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 29.09.10.
//  Copyright 2010 own. All rights reserved.
//


//TODO: singleton

@interface PersistenceProvider : NSObject {
	NSManagedObjectContext			*managedObjectContext_;
	NSManagedObjectModel			*managedObjectModel_;
	NSPersistentStoreCoordinator	*persistentStoreCoordinator_;
}


@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


+ (PersistenceProvider *) sharedInstance;
- (NSString *)applicationDocumentsDirectory;
@end

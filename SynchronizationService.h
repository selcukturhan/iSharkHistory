//
//  ActivityService.h
//  iActiviti
//
//  Created by Selcuk Turhan on 30.06.10.
//  Copyright 2010 own. All rights reserved.
//

#import "AsynchronousDataReceiverDelegate.h"
#import "AsynchronousNetworkService.h"
#import "JSON.h"
#import "Incident.h"
#import "PersistenceProvider.h"

#import "ISO8601DateFormatter.h"

#define URL_SYNCHRONIZATION_SERVICE @"http://localhost:4712/resources/incidentService/getUpdates?lastUpdate="



@interface SynchronizationService : NSObject<AsynchronousNetworkServiceDelegate> {
	id <AsynchronousDataReceiverDelegate> delegate;
	PersistenceProvider* persistenceProvider;
}

@property(nonatomic, retain) id <AsynchronousDataReceiverDelegate> delegate;
@property (nonatomic, retain) PersistenceProvider* persistenceProvider;



-(void) synchronizeIncidents;
@end

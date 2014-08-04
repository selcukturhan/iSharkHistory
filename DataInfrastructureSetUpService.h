//
//  DataInfrastructureSetUpService.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 21.02.11.
//  Copyright 2011 own. All rights reserved.
//


#import "Incident.h"
#import "PersistenceProvider.h"

@interface DataInfrastructureSetUpService : NSObject {
	PersistenceProvider* persistenceProvider;
}

@property (nonatomic, retain) PersistenceProvider* persistenceProvider;

- (void) importData;
@end

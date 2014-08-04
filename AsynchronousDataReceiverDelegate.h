//
//  AsynchronousDataReceiverDelegate.h
//  iActiviti
//
//  Created by Selcuk Turhan on 30.06.10.
//  Copyright 2010 own. All rights reserved.
//




@protocol AsynchronousDataReceiverDelegate <NSObject>
- (void) didReceiveData:		(NSMutableArray *) aTaskCollection;
- (void) didReceiveFilename:	(NSString *) aName;
- (void) dataDownloadFailed:	(NSString *) reason;
- (void) dataDownloadAtPercent: (NSNumber *) aPercent;

@end

//
//  FilterDelegate.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 09.03.11.
//  Copyright 2011 own. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterDelegate
@required
- (void) startFilter:(NSDate*) inputFilterDate dateOperator:(NSString*)inputDateOperator;
- (NSDate*) filterDate;
- (NSString*) getOperator;

@end

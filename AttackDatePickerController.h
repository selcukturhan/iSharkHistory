//
//  AttackDatePicker.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 04.03.11.
//  Copyright 2011 own. All rights reserved.
//

#import "FilterDelegate.h"


@interface AttackDatePickerController : UIViewController {
	NSDate*	filterDate;
	UIDatePicker* pickerView;
	NSArray* queryOperators;
	UISegmentedControl* queryOperatorControls;
	id <FilterDelegate>	filterDelegate;
	NSString* selectedQueryOperator;
}

@property (nonatomic, retain) id <FilterDelegate>			filterDelegate;
@property (nonatomic, retain) UIDatePicker*					pickerView;
@property (nonatomic, retain) NSArray*						queryOperators;
@property (nonatomic, retain) UISegmentedControl*			queryOperatorControls;
@property (nonatomic, retain) NSString*						selectedQueryOperator;
- (id) initWithFilterDelegate: (id <FilterDelegate>) aFilterDelegate;

@end

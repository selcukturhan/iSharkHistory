//
//  AttackDatePicker.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 04.03.11.
//  Copyright 2011 own. All rights reserved.
//

#import "AttackDatePickerController.h"

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

#define UIColorFromRGB(rgbValue) [UIColor \
            colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
            blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.8]


@implementation AttackDatePickerController

@synthesize filterDelegate;
@synthesize pickerView;
@synthesize queryOperators;
@synthesize queryOperatorControls;
@synthesize selectedQueryOperator;


- (id) initWithFilterDelegate: (id <FilterDelegate>) aFilterDelegate
{
	if (self = [super init]) {
        self.filterDelegate = aFilterDelegate;
    }
	return self;
}

- (void) loadView {
	[super loadView];
	UIView* contentView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    contentView.backgroundColor = UIColorFromRGB(0x99AABB);
	self.view = contentView;
	[contentView release];
	
	CGRect pickerFrame = CGRectMake(0.0, 0.0, 320.0, 400.0);
  	pickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
	pickerView.datePickerMode = UIDatePickerModeDate;
	pickerView.date = [self.filterDelegate filterDate];
	[self.view addSubview: pickerView];
	
	
	self.navigationItem.title = @"Timefilter";
	self.queryOperators = [NSArray arrayWithObjects: @"<", @">", @"=", nil];
	
	self.selectedQueryOperator = [self.filterDelegate dateOperator];
	
	
	CGRect segmentedControlFrame = CGRectMake(1, 270.0, 320.0, 100.0);
	UIView* segView = [[[UIView alloc] initWithFrame: segmentedControlFrame]autorelease];
	
	self.queryOperatorControls = [[UISegmentedControl alloc] initWithItems: self.queryOperators];
	
    
    [self.queryOperatorControls setSegmentedControlStyle:UISegmentedControlStyleBordered];
    [self.queryOperatorControls setWidth: 105 forSegmentAtIndex:0];
    [self.queryOperatorControls setWidth: 105 forSegmentAtIndex:1];
    [self.queryOperatorControls setWidth: 105 forSegmentAtIndex:2];
    
    [self.queryOperatorControls widthForSegmentAtIndex:1];
	if(self.selectedQueryOperator == nil){
		self.selectedQueryOperator = @"<"; //default show all
		self.queryOperatorControls.selectedSegmentIndex = 1;
	} else {
		if ([self.selectedQueryOperator isEqualToString:@"<"]) {
			self.queryOperatorControls.selectedSegmentIndex = 0;
		} else if ([self.selectedQueryOperator isEqualToString:@">"]) {
			self.queryOperatorControls.selectedSegmentIndex = 1;
		} else if ([self.selectedQueryOperator isEqualToString:@"="]) {
			self.queryOperatorControls.selectedSegmentIndex = 2;
		}
	}

	
	
	
	
	[segView addSubview: self.queryOperatorControls];
	
	self.queryOperatorControls.segmentedControlStyle = UISegmentedControlStyleBordered;
	[self.queryOperatorControls addTarget:self action:@selector(setQueryOperator:) forControlEvents:UIControlEventValueChanged];
	
	[self.view addSubview: segView];
	
	self.navigationItem.rightBarButtonItem = BARBUTTON(@"Apply", @selector(searchWithFilter:));
}



-(void) setQueryOperator: (UISegmentedControl*) sender{
	self.selectedQueryOperator = [self.queryOperators objectAtIndex:sender.selectedSegmentIndex];
	NSLog(@"%@", self.selectedQueryOperator);
}

- (void) searchWithFilter: (id) sender{
	[self.filterDelegate startFilter: pickerView.date dateOperator: self.selectedQueryOperator];
	[self.parentViewController popViewControllerAnimated:YES];
}

- (void) dealloc
{
	[filterDelegate release];
	[pickerView release];
	[super dealloc];
}


@end

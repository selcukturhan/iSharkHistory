//
//  SharkAdvicesViewController.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 08.04.11.
//  Copyright 2011 own. All rights reserved.
//

#import "SharkAdvicesViewController.h"
#define BASEHEIGHT	284.0f
#define NPAGES		3
@implementation SharkAdvicesViewController


- (id)init {
	if (self = [super init]) {
        UITabBarItem *tbi = [self tabBarItem];
        [tbi setTitle:@"Recommendations"];
        UIImage *i = [UIImage imageNamed:@"warning.png"];
        [tbi setImage:i];
    }
	return self;
}



- (void) loadView {
	[super loadView];
    UIScrollView* contentView = [[UIScrollView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];
    contentView.contentSize = CGSizeMake(320.0f, 3300);
    contentView.scrollEnabled = YES;
    contentView.delegate = self;
       
    UILabel* textField = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 0.0, 320, 3300)];
    textField.backgroundColor = [UIColor cyanColor];
    textField.numberOfLines = 700;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recommendations" ofType:@"txt"];
    NSString* recommendations =[NSString stringWithContentsOfFile:path];
    [textField setText: recommendations];
    [contentView addSubview:textField];
    
    [self.view addSubview:contentView];
    [textField release];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

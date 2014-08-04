//
//  ReportIncidentController.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 18.09.10.
//  Copyright 2010 own. All rights reserved.
//

#import "ReportIncidentController.h"


@implementation ReportIncidentController


- (id) init {
	if (self = [super init]) {
    
    }
	return self;
}

- (void) loadView {
    [super loadView];
	NSLog(@"%i", [MFMailComposeViewController canSendMail]);
	[self displayComposerSheet];
}

-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Report Sharkattack"];
	
	
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"selcuks.startup@googlemail.com"]; 
		
	[picker setToRecipients:toRecipients];
		
	// Attach an image to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"sharks_may_be_present" ofType:@"jpg"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
	
	//[picker addAttachmentData:myData mimeType:@"image/jpg" fileName:@"sharks"];
	
	// Fill out the email body text
	NSString *emailBody = @"Text goes here...";
	[picker setMessageBody:emailBody isHTML:NO];
	[self presentModalViewController:picker animated:NO];
	[emailBody release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			break;
		case MFMailComposeResultFailed:
			break;
		default:
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
	//[((UINavigationController*)self.parentViewController) popViewControllerAnimated:NO];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end


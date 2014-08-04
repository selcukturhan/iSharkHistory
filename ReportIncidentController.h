//
//  ReportIncidentController.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 18.09.10.
//  Copyright 2010 own. All rights reserved.
//


#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ReportIncidentController :  UIViewController <MFMailComposeViewControllerDelegate> {

}

-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

@end

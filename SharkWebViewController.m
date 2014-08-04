    //
//  WebView.m
//  iSharkHistory
//
//  Created by Selcuk Turhan on 27.08.10.
//  Copyright 2010 own. All rights reserved.
//

#import "SharkWebViewController.h"


@implementation SharkWebViewController
@synthesize url;
@synthesize webView;
@synthesize aiv;

- (id) initWithUrl: (NSString *) aUrl{
	if ([super init]) {
        self.url= aUrl;
    }
	return self;
}


- (void)loadView {
	[super loadView];
	CGRect webFrame = CGRectMake(0.0, 0.0, 320.0, 460.0);
	self.webView = [[UIWebView alloc] initWithFrame:webFrame];

	self.navigationItem.title = @"Shark Info";
	self.webView.delegate = self;
	
	self.aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
	[aiv setCenter: CGPointMake(160.0f, 230.0f)]; 
	[self.webView addSubview: aiv];
	
	
	//URL Request Object
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
	[self.view addSubview:webView]; 
	
	
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	[self.aiv startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[self.aiv stopAnimating];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[url release];
	[webView release];
    [super dealloc];
}


@end

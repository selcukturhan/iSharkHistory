//
//  WebView.h
//  iSharkHistory
//
//  Created by Selcuk Turhan on 27.08.10.
//  Copyright 2010 own. All rights reserved.
//




@interface SharkWebViewController : UIViewController<UIWebViewDelegate> {
	UIWebView*					webView;
	NSString*					url;
	UIActivityIndicatorView*	aiv; 
}

@property (nonatomic, retain) UIWebView*				webView;
@property (nonatomic, retain) NSString*					url;
@property (nonatomic, retain) UIActivityIndicatorView*	aiv;
- (id) initWithUrl: (NSString *)						aUrl;
@end

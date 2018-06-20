//
//  StoryViewController.m
//  HackerNews
//
//  Created by SonNguyen on 6/20/18.
//  Copyright © 2018 SonNguyen. All rights reserved.
//

#import "StoryViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <WebKit/WebKit.h>

@interface StoryViewController () <WKNavigationDelegate>

@property (nonatomic, strong) IBOutlet WKWebView *webView;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.webView isLoading]) {
        [self.webView stopLoading];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}

#pragma mark - Bindings

- (void)bindViewModel {
    self.title = self.viewModel.title;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.viewModel.url]];
}

#pragma mark - Webview

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

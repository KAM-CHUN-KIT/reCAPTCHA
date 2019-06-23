//
//  ReCaptchaViewController.m
//  reCAPTCHA
//
//  Created by Kam on 23/6/2019.
//  Copyright © 2019 Kam. All rights reserved.
//

#import "ReCaptchaViewController.h"

@interface ReCaptchaViewController ()

@end

@implementation ReCaptchaViewController {
    WKWebView *wk;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self initWebkitView];
}

- (void)dealloc {
    if (wk) {
        [wk.configuration.userContentController removeScriptMessageHandlerForName:@"reCaptcha"];
    }
}

#pragma public method

- (void)loadCaptchaWithSiteKey:(NSString *)siteKey Locale: (NSString *)locale {
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"recaptcha" ofType:@"html"];
    NSString *htmlStr = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"{site_key}"
                                                 withString:siteKey ? siteKey : @""];
    
    htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"replaced_locale_string"
                                                 withString:siteKey ? siteKey : @"en"];
    
    [wk loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"http://localhost"]];
}

#pragma private method

- (void)initWebkitView {
    WKUserContentController *wkController = [[WKUserContentController alloc] init];
    
    [wkController addScriptMessageHandler:self name:@"reCaptcha"];
    
    WKWebViewConfiguration *wkConf = [[WKWebViewConfiguration alloc] init];
    [wkConf setUserContentController:wkController];
    
    wk = [[WKWebView alloc] initWithFrame:self.view.frame
                            configuration:wkConf];
    
    wk.backgroundColor = [UIColor clearColor];
    wk.opaque = NO;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSArray<NSString*> *args = (NSArray*)message.body;
    
    if ([args[0] isEqualToString:@"didLoad"])
        [self captchaDidLoad];
    else if ([args[0] isEqualToString:@"didSolve"])
        [self captchaDidSolve:args[1]];
    else if ([args[0] isEqualToString:@"didExpire"])
        [self captchaDidExpire];
    else if ([args[0] isEqualToString:@"didPressEmptySpace"])
        [self exitCaptchaView];
}

- (void)captchaDidLoad {
    [wk setFrame:self.view.frame];
    [self.view addSubview:wk];
}

- (void)captchaDidSolve:(NSString *)response {
    NSLog(@"%@", response);
    if (response && self.delegate && [_delegate respondsToSelector:@selector(captchaValidateSuccess:)]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate captchaValidateSuccess:response];
        });
    }
}

- (void)captchaDidExpire {
    NSLog(@"Captcha Expired");
    if (self.delegate && [_delegate respondsToSelector:@selector(captchaDidExpire)]) {
        [self.delegate captchaDidExpire];
    }
}

- (void)exitCaptchaView {
    NSLog(@"Exit Captcha View");
    if (self.delegate && [_delegate respondsToSelector:@selector(exitCaptchaView)]) {
        [self.delegate exitCaptchaView];
    }
}


@end

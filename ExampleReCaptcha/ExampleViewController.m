//
//  ExampleViewController.m
//  ExampleReCaptcha
//
//  Created by Kam on 23/6/2019.
//  Copyright © 2019 Kam. All rights reserved.
//

#import "ExampleViewController.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self promptRobotCheckDialog];
}

- (void)promptRobotCheckDialog {
    ReCaptchaViewController *vc = [ReCaptchaViewController new];
    vc.delegate = self;
    NSString *locale = @"zh_CN";
    NSString *siteKey = @"6LdBUp0UAAAAAPgyEuWycICiSTbqzlBv36C2d0BQ";
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:false completion:nil];
    [vc loadCaptchaWithSiteKey:siteKey Locale:locale];
}

#pragma mark - robot check delegate

- (void)captchaValidateSuccess:(NSString *)token {
    NSLog(@"Your token : %@", token);
}

- (void)captchaDidExpire {
    NSLog(@"token expired");
}

- (void)exitCaptchaView {
    [self dismissViewControllerAnimated:false completion:^{
        NSLog(@"exit robot check page");
    }];
}

@end

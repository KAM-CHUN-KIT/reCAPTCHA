//
//  ReCaptchaViewController.h
//  reCAPTCHA
//
//  Created by Kam on 23/6/2019.
//  Copyright © 2019 Kam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Webkit/Webkit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RobotCheckResponseDelegate <NSObject>

- (void) captchaValidateSuccess:(NSString*)token;
- (void) captchaDidExpire;
- (void) exitCaptchaView;

@end

@interface ReCaptchaViewController : UIViewController<WKScriptMessageHandler>

@property (weak, nonatomic) id <RobotCheckResponseDelegate> delegate;

- (void)loadCaptchaWithSiteKey:(NSString *)siteKey Locale:(NSString *)locale; //public function. to assign locale and sitekey

@end

NS_ASSUME_NONNULL_END

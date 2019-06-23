//
//  ViewController.m
//  ExampleReCaptcha
//
//  Created by Kam on 23/6/2019.
//  Copyright © 2019 Kam. All rights reserved.
//

#import "ViewController.h"
#import "ExampleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *vc = [ExampleViewController new];
    [self pushViewController:vc animated:NO];
}



@end

//
//  ViewController.m
//  SoapServiceApp
//
//  Created by Kevin Peng on 2019-11-03.
//  Copyright © 2019 Kevin Peng. All rights reserved.
//

#import "ViewController.h"
#import "SoapService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SoapService alloc] init];
}


@end

//
//  FacebookVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 09/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "FacebookVC.h"

@interface FacebookVC ()

@end

@implementation FacebookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *urlAddress = @"http://www.facebook.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnBack:(id)sender {
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end

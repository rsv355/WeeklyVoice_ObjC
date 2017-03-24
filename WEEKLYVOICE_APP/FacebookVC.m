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
    
    _lblTitle.text = _strVideoTitle;
    [self loadFacebookPageFromURL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadFacebookPageFromURL
{
    
    if ([_strVideoID isEqualToString:@"video"])
    {
        _lblTitle.font = [UIFont systemFontOfSize:14];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *urlAddress = _strVideoURL;
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    else
    {
        _lblTitle.text = @"Facebook";
        _lblTitle.font = [UIFont systemFontOfSize:12];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *urlAddress = @"https://www.facebook.com/WebmyneSystems";
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
    }
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (IBAction)btnBack:(id)sender {
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
}
@end

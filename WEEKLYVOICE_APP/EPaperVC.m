//
//  EPaperVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 09/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "EPaperVC.h"
#import "HomePageVC.h"

@interface EPaperVC ()

@end

@implementation EPaperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//        NSString *urlAddress = @"http://www.google.com";
//        NSURL *url = [NSURL URLWithString:urlAddress];
//        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:requestObj];
    
    
    NSLog(@"--------%@", self.videoUrl);
    
    if ([_viewID isEqualToString:@"videoVC"])
    {
        
       [MBProgressHUD showHUDAddedTo: self.view animated:YES];
        NSString *urlAddress = _videoUrl;
        
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:requestObj];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

        
    }
    else
    {

        [self FatchEpaperUrl:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_EPAPEER]];

    }
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FatchEpaperUrl:(NSString*)Epaper_url
{
    
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:Epaper_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self Parse_Epaper:responseArr];
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [errorAlert show];
        
    }];
    
    
}

-(void)Parse_Epaper:(NSDictionary *)dictionary
{
    NSMutableArray * posts_dictionary=[dictionary valueForKey:@"posts"];
    NSMutableDictionary * post_dictionary=[posts_dictionary objectAtIndex:0];
    NSMutableDictionary * post_url=[post_dictionary valueForKey:@"post"];
    Url=[post_url valueForKey:@"URL"];
    
    NSLog(@"------>> %@",Url);
    NSURL *url = [NSURL URLWithString:Url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
   [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}


- (IBAction)btnBack:(id)sender {
    
    
    if ([_viewID isEqualToString:@"videoVC"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];

    
//    exit(0);
}


@end

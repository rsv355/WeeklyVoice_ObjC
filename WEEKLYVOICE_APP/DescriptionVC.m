//
//  DescriptionVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "DescriptionVC.h"

@interface DescriptionVC ()

@end

@implementation DescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnCommentTap:(id)sender {
    
    AddCommentVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCommentVC"];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [vc setTransitioningDelegate:_CustomAnimationAndTransiotion];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnBack:(id)sender {
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnShareTap:(id)sender {
    
    NSString *shareString = @"text...";
    NSArray *activityItems = @[shareString];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypePostToFacebook,
                                   UIActivityTypeMail,UIActivityTypeMessage,
                                   UIActivityTypeAssignToContact,UIActivityTypeAirDrop,UIActivityTypePostToTwitter,UIActivityTypeSaveToCameraRoll];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}


@end

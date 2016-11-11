//
//  AddCommentVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 09/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "AddCommentVC.h"

@interface AddCommentVC ()

@end

@implementation AddCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _backView.layer.masksToBounds = NO;
    _backView.layer.cornerRadius = 3; // if you like rounded corners
    _backView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    _backView.layer.shadowRadius = 1;
    
    _backView.layer.shadowOpacity = 0.7;
    //  button.layer.shadowColor = [UIColor colorWithRed:(246/255.0) green:(192/255.0) blue:(51/255.0) alpha:1.0].CGColor;
    
    _backView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_backView.bounds];
    _backView.maskView.layer.shadowPath = path.CGPath;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelTap:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnOkTap:(id)sender {
}


@end

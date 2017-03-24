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

    
    if ( [_txtName.text length] == 0 && [_txtComment.text length] == 0) {
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please enter all fields.." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        [errorAlert show];
        return;
    }
    else
    {
        [self AddCommentWebService];
    }
}

-(void)AddCommentWebService
{
    
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",BASE_URL,ADD_COMMENT];

    
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:_passNIDString,@"nid",_txtComment.text,@"subject",_txtName.text,@"name", nil] ;
    
    [manager POST:stringURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        [self parseDataResponseObject:responseArr];
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [errorAlert show];
        
    }];
    
}


-(void)parseDataResponseObject:(NSDictionary *)dictionary{
    
    
    NSString *stringMessage = [dictionary valueForKey:@"code"];
    
    UIAlertView *successAlert = [[UIAlertView alloc]initWithTitle:@"Success" message:stringMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [self dismissViewControllerAnimated:YES completion:nil];

    [successAlert show];
    
}


@end

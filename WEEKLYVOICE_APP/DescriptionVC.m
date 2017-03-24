//
//  DescriptionVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "DescriptionVC.h"

@interface DescriptionVC () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation DescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [_Discription_textView setUserInteractionEnabled:NO];
    
    
    self.Discription_textView.text = @"";
    self.tilte_Lbl.text = @"";
    
    [self fetchDiscriptionDataFromWebService:[NSString stringWithFormat:@"%@%@nid=%@",BASE_URL,FETCH_NEWS_DETAIL,_stringNID] for:1];
    
     }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)fetchDiscriptionDataFromWebService:(NSString *)stringURL for:(NSInteger)selectInteger
{
    
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:stringURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self parseDataResponseObject:responseArr for:selectInteger];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [errorAlert show];
        
    }];
    
}


-(void)parseDataResponseObject:(NSDictionary *)dictionary for:(NSInteger)selectInteger
{
    
    
    if (selectInteger == 1) {
        Discription_Dictionary = [dictionary objectForKey:@"posts"];
        
        NSMutableDictionary * dictionary_Postdetail=[Discription_Dictionary objectAtIndex:0];
        NSMutableDictionary * dictionary_post=[dictionary_Postdetail valueForKey:@"post"];
        
        
        
        NSString * image_url=[NSString stringWithFormat:@"%@",[dictionary_post valueForKey:@"image"]];
        
        [self.Discription_image setImageWithURL:[NSURL URLWithString:image_url]];
        
//        self.Discription_image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]]];   // working code
        
        self.tilte_Lbl.text=[dictionary_post valueForKey:@"title"];
        
        
        
        
        NSString *htmlString = [dictionary_post valueForKey:@"body_value"];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                documentAttributes: nil
                                                error: nil
                                                ];
        
//        
//        [self textViewHeightForAttributedText:attributedString andWidth:_Discription_textView.frame.size.width];
        
        self.Discription_textView.attributedText = attributedString;
        [self.Discription_textView setFont:[UIFont systemFontOfSize:13]];

        
        [self fetchDiscriptionDataFromWebService:[NSString stringWithFormat:@"%@%@&nid=%@",BASE_URL,FETCH_COMMENT,_stringNID] for:2];
       
        
        
    }
    
    if (selectInteger == 2) {
        commentArray = [[dictionary objectForKey:@"posts"]valueForKey:@"post"];
        
        self.tableviewHeightConstraint.constant = (commentArray.count)*67;
        
        if (commentArray.count == 0) {
            
            _lblCommentHeightConstraint.constant = 0;
            
        }
        else
        {
            _lblCommentHeightConstraint.constant = 29;
            
        }
        
        [_tableviewComment reloadData];
        
        
    }

    
   
    
}




- (IBAction)btnCommentTap:(id)sender {
    
    AddCommentVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AddCommentVC"];
    vc.passNIDString = _stringNID;
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [vc setTransitioningDelegate:_CustomAnimationAndTransiotion];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnBack:(id)sender {
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - UITableview Delegates Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lblName.text = [[commentArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.lblSubject.text = [[commentArray objectAtIndex:indexPath.row]valueForKey:@"subject"];
    
    return cell;
}




















@end

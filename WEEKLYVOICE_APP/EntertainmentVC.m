//
//  EntertainmentVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "EntertainmentVC.h"
#import "EntertainmentVcCell.h"
#import "DropdownTableViewCell.h"

@interface EntertainmentVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end


@implementation EntertainmentVC
{
    NSArray *dropdownNameArray;
    NSMutableArray *imageArray, *nameArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"----------- %@",self.passedString);
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    
    
    if ([_passedString isEqualToString:@"Videos"]) {
        
        _lblName.text = @"Videos";
    }
    else
    {
//        self.lblName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"catTitle"];
        
        self.lblName.text = _passedString;

    }
    
    
//    self.lblSubCategoryTitle.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"subcatTitle"];
    
    
    dropdownNameArray = [[NSArray alloc]initWithObjects:@"Tell yout Friend",@"E-paper",@"Facebook Page", nil];
    
    _tableviewDropDown.hidden = true;
    _tableviewDropDown.scrollEnabled = false;
    _tableviewDropDown.separatorColor = [UIColor colorWithRed:176.0/255.0 green:190.0/255.0 blue:197.0/255.0 alpha:1.0];
    
    _dropdownTableviewHeightConstraint.constant = (dropdownNameArray.count)* 39;

    
    [self setCustomButton];
    
    [self fetchDataFromWebService];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _tableviewDropDown.hidden = YES;
    _btnDropdown.selected=false;
}

-(void)setCustomButton
{
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(9.0, 25.0, 30.0, 30.0)];
    [btnBack setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewNavigationBar addSubview:btnBack];
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wv_logonew.png"]];
    imageview.frame = CGRectMake(50, 28, 200, 25);
    [self.viewNavigationBar addSubview:imageview];
    
    
    if ([_passedString isEqualToString:@"Videos"]) {
        _btnTopNews.hidden = YES;
        _btnDropdown.hidden = YES;
        _btnLeftMenu.hidden = YES;
        
        btnBack.hidden = NO;
        imageview.hidden = NO;
    }
    else{
        _btnTopNews.hidden = NO;
        _btnDropdown.hidden = NO;
        _btnLeftMenu.hidden = NO;
        
        btnBack.hidden = YES;
        imageview.hidden = YES;
        
    }

}


#pragma mark - Fetch Data From WebService
-(void)fetchDataFromWebService
{
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:@"%@%@%@",BASE_URL,FETCH_CATEGORY_NEWS,_passCategoryId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self parseDataResponseObject:responseArr];
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [errorAlert show];
        
    }];

    
}

-(void)parseDataResponseObject:(NSDictionary *)dictionary
{
    
    imageArray = [[[dictionary objectForKey:@"posts"]valueForKey:@"post"]valueForKey:@"image"];
    
    nameArray = [[[dictionary objectForKey:@"posts"]valueForKey:@"post"]valueForKey:@"title"];
    
    [_tableView reloadData];
}

#pragma mark - Navigation bar button Action

-(void)btnBackAction:(UIButton *)sender
{
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)AppIconTap:(id)sender {
    
    NSString *catID = [[NSUserDefaults standardUserDefaults]valueForKey:@"categoryId"];
    
    [self.EntertainmentVcDelegate RefreshTableviewData:_passedString :catID];
    
    [self.rootNav drawerToggle];
}
- (IBAction)leftMenuTap:(id)sender {
    
     NSString *catID = [[NSUserDefaults standardUserDefaults]valueForKey:@"categoryId"];
    [self.EntertainmentVcDelegate RefreshTableviewData:_passedString :catID];
    
    [self.rootNav drawerToggle];
}


- (IBAction)btnDropdownTap:(id)sender {
    
    if(_btnDropdown.selected == false)
    {
        _btnDropdown.selected = true;
        _tableviewDropDown.hidden = false;
    }
    else
    {
        _btnDropdown.selected = false;
        _tableviewDropDown.hidden = true;
    }
}

- (IBAction)btnTopNewsTap:(id)sender {
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.EntertainmentVcDelegate RefreshTableviewData:@"" :@""];
    
     [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"SUBCAT"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
   [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CCKFNavDrawer Selection Section Method

-(void)CCKFNavDrawerSelection:(NSString *)selectedIndexString :(NSString *)categoryId
{
//    NSLog(@"CCKFNavDrawerSelection = %li", (long)selectionIndex);
    
    _passedString = selectedIndexString;
    
    
    NSLog(@"--------DrawerSelected String:- %@",selectedIndexString);
    
   
    [[NSUserDefaults standardUserDefaults]setValue:selectedIndexString forKey:@"subcatTitle"];
    
    
}




#pragma mark - UITableview Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _tableviewDropDown)
    {
        return dropdownNameArray.count;
    }
    else
    {
        
        return nameArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableviewDropDown)
    {
        DropdownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDropdown" forIndexPath:indexPath];
        
        cell.lblCategoryName.text = [dropdownNameArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    else {
    EntertainmentVcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        NSString *strImagePath  = [NSString stringWithFormat:@"%@",[imageArray objectAtIndex:indexPath.row]];
        [cell.imageview setImageWithURL:[NSURL URLWithString:strImagePath]];
        cell.lblTitle.text = [nameArray objectAtIndex:indexPath.row];
        
    return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_tableView deselectRowAtIndexPath:indexPath
                              animated:YES];
    [_tableviewDropDown deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _tableviewDropDown)
    {
        if (indexPath.row == 0) {
            NSLog(@"Tell your Friend");
            
            NSString *shareString = @"text...";
            NSArray *activityItems = @[shareString];
            
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypePostToFacebook,
                                           UIActivityTypeMail,UIActivityTypeMessage,
                                           UIActivityTypeAssignToContact,UIActivityTypeAirDrop,UIActivityTypePostToTwitter,UIActivityTypeSaveToCameraRoll];
            
            activityVC.excludedActivityTypes = excludeActivities;
            
            [self presentViewController:activityVC animated:YES completion:nil];
            
        }
        else if (indexPath.row == 1) {
            NSLog(@"E-Paper");
            
            EPaperVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EPaperVC"];
        
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else if (indexPath.row == 2) {
            NSLog(@"Facebook Page");
            
            FacebookVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookVC"];
    
            [self.navigationController pushViewController:vc animated:YES];
        }

        
        
        
        
    }
    else
    {
        
        DescriptionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionVC"];
   
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    _tableviewDropDown.hidden = YES;
    _btnDropdown.selected = false;

}


@end

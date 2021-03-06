//
//  HomePageVC.m
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "HomePageVC.h"
@interface HomePageVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate>
{
    int index;
    NSTimer *imageTimer;
    NSString *mmmmm;
}


@property (strong, nonatomic) CCKFNavDrawer *rootNav;

@end

@implementation HomePageVC
{
    NSArray *dropdownNameArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    index = 0;
    imageTimer = [NSTimer scheduledTimerWithTimeInterval: 5.0 target:self selector:@selector(FetchImageFromURL) userInfo:nil repeats: YES];

    
    _scrollView.delegate = self;
    
    self.rootNav = (CCKFNavDrawer *)self.navigationController;
    [self.rootNav setCCKFNavDrawerDelegate:self];
    
    [_collectionView setScrollEnabled:false];
    [_tableView setScrollEnabled:false];
    
    self.navigationController.navigationBarHidden = YES;
    
     dropdownNameArray = [[NSArray alloc]initWithObjects:@"Tell yout Friend",@"E-paper",@"Facebook Page", nil];
    
    self.tableviewDropdownHeightConstraint.constant = (dropdownNameArray.count)* 39;
    
    _tableviewDropdown.scrollEnabled = false;
    
    _tableviewDropdown.hidden = true;
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"subcatTitle"];
   
    [self setColorArray];
    
   
    
    [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_TOP_NEWS] for:1];
    
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FetchImageFromURL
{

    if(index != topNewsArray.count-1)
    {
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:topNewsImageArray[index]]];
//        
//        _imageTopNews.image = [UIImage imageWithData:imageData];
        
        
        NSString *strImagePath  = [NSString stringWithFormat:@"%@",[topNewsArray valueForKey:@"image"][index]];
        [_imageTopNews setImageWithURL:[NSURL URLWithString:strImagePath]];
        
        _lblTopNewsTitle.text = [[topNewsArray valueForKey:@"title"]objectAtIndex:index];
        
        
        DescriptionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionVC"];
        
        vc.stringNID = [[topNewsArray valueForKey:@"nid"]objectAtIndex:index];
        
        index++;
    }
    else
    {
        index = 0;
    }
}

-(void)fetchDataFromWebService:(NSString *)stringURL for:(NSInteger)selectInteger
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
-(void)parseDataResponseObject:(NSDictionary *)dictionary for:(NSInteger)selectInteger {
    
    if (selectInteger == 1) {
        
        topNewsArray = [[dictionary objectForKey:@"posts"]valueForKey:@"post"];
        [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_RIGHT_NOW] for:3];
    }
    
    
    else if (selectInteger == 2){

        headlinesArray = [[dictionary objectForKey:@"posts"]valueForKey:@"post"];
        [_collectionView reloadData];
        
        [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_BREAKING_NEWS] for:4];
        
    }
    
    
    else if (selectInteger == 3){

        rightNowArray = [[dictionary objectForKey:@"posts"]valueForKey:@"post"];

        _tableviewHeightConstraint.constant = (rightNowArray.count)*99;
        
        [_tableView reloadData];
        
        [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_HEADLINE] for:2];
        
    }
    
    else if (selectInteger == 4){
 
        breakingNewsTitleArray = [[[dictionary objectForKey:@"posts"]valueForKey:@"post"]valueForKey:@"title"];
        
//        NSLog(@"Breaking News Title:- %@",breakingNewsTitleArray);
        
    }
    
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _tableviewDropdown.hidden = YES;
    _btnDropdown.selected = false;
}

- (IBAction)btnTopStoriesTap:(id)sender {
    
    DescriptionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionVC"];
    
    if (index == 0) {
        vc.stringNID = [[topNewsArray valueForKey:@"nid"]objectAtIndex:index];
    } else{
        vc.stringNID = [[topNewsArray valueForKey:@"nid"]objectAtIndex:index-1];
    }
    
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)setColorArray
{
    
  
    colorArray = [[NSMutableArray alloc]initWithObjects:[UIColor colorWithRed:128.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0],[UIColor colorWithRed:185.0/255.0 green:95.0/255.0 blue:0.0/255.0 alpha:1.0],[UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:186.0/255.0 alpha:1.0],[UIColor colorWithRed:0.0/255.0 green:128.0/255.0 blue:64.0/255.0 alpha:1.0],[UIColor colorWithRed:199.0/255.0 green:163.0/255.0 blue:23.0/255.0 alpha:1.0],[UIColor colorWithRed:205.0/255.0 green:0.0/255.0 blue:205.0/255.0 alpha:1.0], nil];
    
    

}

#pragma mark - Navigationbar Button Action
- (IBAction)AppLogoBtnTap:(id)sender {
    [self.rootNav drawerToggle];
   
}

- (IBAction)leftMenuBtnTap:(id)sender {
    [self.rootNav drawerToggle];

}



- (IBAction)btnDropdownTap:(id)sender {
    
    if(_btnDropdown.selected == false)
    {
        _btnDropdown.selected = true;
        _tableviewDropdown.hidden = false;
    }
    else
    {
        _btnDropdown.selected = false;
        _tableviewDropdown.hidden = true;
    }
}
- (IBAction)btnVideoTap:(id)sender {
    
    VideoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoVC"];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark- CCKFNavDrawer Selection Section Method

-(void)CCKFNavDrawerSelection:(NSString *)selectedIndexString :(NSString *)categoryId
{
//    NSLog(@"CCKFNavDrawerSelection = %li", (long)selectionIndex);
//    self.selectionIdx.text = [NSString stringWithFormat:@"%i",selectionIndex];
    
    NSLog(@"Category Id:- %@",categoryId);
    NSLog(@"DrawerSelected String:- %@",selectedIndexString);
    
    
     [[NSUserDefaults standardUserDefaults]setValue:@"YES" forKey:@"SUBCAT"];
    
    [[NSUserDefaults standardUserDefaults]setValue:selectedIndexString forKey:@"catTitle"];
    
    [[NSUserDefaults standardUserDefaults]setObject:categoryId forKey:@"categoryId"];

}



#pragma mark - Collectionview Delegates Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (headlinesArray.count == 0) {
         self.collectionviewHeightConstraint.constant = 5;
    }
    return headlinesArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HeadlinesVcCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
  
    NSString *strImagePath  = [NSString stringWithFormat:@"%@",[[headlinesArray valueForKey:@"image"]objectAtIndex:indexPath.row]];
    [cell.imageViewCategory setImageWithURL:[NSURL URLWithString:strImagePath]];
    
    cell.lblCategoryName.text = [[headlinesArray valueForKey:@"name"]objectAtIndex:indexPath.row];
    [cell.lblCategoryName setBackgroundColor:[colorArray objectAtIndex:indexPath.row]];
    cell.lblCategoryDescription.text = [[headlinesArray valueForKey:@"title"]objectAtIndex:indexPath.row];
   
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DescriptionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionVC"];
    vc.stringNID = [[headlinesArray valueForKey:@"nid"]objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double side1,side2;
    CGSize collectionviewSize=self.collectionView.frame.size;
    side1=collectionviewSize.width/4 + 20;
    side2= side1 + 15;
    
    self.collectionviewHeightConstraint.constant = (side2*2)-10;

    return CGSizeMake(side1, side1+5);
    
}

#pragma mark - Tableview Delegates Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableviewDropdown)
    {
        return dropdownNameArray.count;
    }
    else
    {
    
        return rightNowArray.count;
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableviewDropdown)
    {
        HomepageDropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellDropdown" forIndexPath:indexPath];
        
        cell.lblCategoryName.text = [dropdownNameArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        RightnowVcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        NSString *strImagePath  = [NSString stringWithFormat:@"%@",[[rightNowArray valueForKey:@"image"]objectAtIndex:indexPath.row]];
        [cell.imageviewRightNow setImageWithURL:[NSURL URLWithString:strImagePath]];

        cell.lblTitleRightNow.text = [[rightNowArray valueForKey:@"taxonomy_term_data_name"]objectAtIndex:indexPath.row];
        cell.lblDateRightNow.text = [[rightNowArray valueForKey:@"field_category_taxonomy_term_data_created"]objectAtIndex:indexPath.row];
        cell.lblDescriptionRightNow.text = [[rightNowArray valueForKey:@"field_category_taxonomy_term_data_title"]objectAtIndex:indexPath.row];
    
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_tableviewDropdown deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView == _tableviewDropdown) {
        
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
            vc.viewID=@"homeVC";


            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if (indexPath.row == 2) {
            NSLog(@"Facebook Page");
            
            NSLog(@"Facebook Page");
            
            FacebookVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookVC"];
           
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
        
    }
    
    if (tableView == self.tableView)
    {
        DescriptionVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionVC"];
        
        vc.stringNID = [[rightNowArray valueForKey:@"nid"]objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    _tableviewDropdown.hidden = YES;
    _btnDropdown.selected = false;
    
}

//-(void)FatchEpaperUrl:(NSString*)Epaper_url
//{
//    
//    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:Epaper_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//       
//        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
//        
//        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        [self Parse_Epaper:responseArr];
//       
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
//        
//        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        
//        [errorAlert show];
//        
//    }];
//    
//    
//}
//
//-(void)Parse_Epaper:(NSDictionary *)dictionary
//{
//    NSMutableArray * posts_dictionary=[dictionary valueForKey:@"posts"];
//    NSMutableDictionary * post_dictionary=[posts_dictionary objectAtIndex:0];
//    NSMutableDictionary * post_url=[post_dictionary valueForKey:@"post"];
//    NSString * Url=[post_url valueForKey:@"URL"];
//}
//

@end

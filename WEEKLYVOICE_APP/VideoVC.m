//
//  VideoVC.m
//  WEEKLYVOICE_APP
//
//  Created by Webmyne on 11/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import "VideoVC.h"
#import "HomePageVC.h"
#import "AFNetworking.h"
#import "VideoVCcell.h"
#import "UIImageView+AFNetworking.h"
#import "EPaperVC.h"
#import "FacebookVC.h"



@interface VideoVC ()

@end

@implementation VideoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_YOUTUBE_VIDEO]];
    
    // Do any additional setup after loading the view.
}

-(void)fetchDataFromWebService:(NSString *)stringURL
{
    
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:stringURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
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
 
    video_array = [dictionary objectForKey:@"posts"];
    [_tableViewVideoList reloadData];
    [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return video_array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     VideoVCcell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    
     NSMutableDictionary * postAtIndex=[video_array objectAtIndex:indexPath.row];
    
     postDictionary=[postAtIndex valueForKey:@"post"];
    
    // videoUrl=[postDictionary valueForKey:@"field_myvedionew_video_url"];

    
    NSString *strImagePath  = [NSString stringWithFormat:@"%@",[postDictionary valueForKey:@"image"]];
    [cell.VideoImage setImageWithURL:[NSURL URLWithString:strImagePath]];
   
    cell.video_titleLable.text=[postDictionary valueForKey:@"title"];
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"u----- %@",[[[video_array objectAtIndex:indexPath.row] objectForKey:@"post"] objectForKey:@"field_myvedionew_video_url"]);
    
    FacebookVC *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookVC"];
    
    viewController.strVideoURL=[[[video_array objectAtIndex:indexPath.row] objectForKey:@"post"] objectForKey:@"field_myvedionew_video_url"];
    
    viewController.strVideoID=@"video";
    viewController.strVideoTitle = [[[video_array valueForKey:@"post"]objectAtIndex:indexPath.row]valueForKey:@"title"];
    
//     [self presentViewController:viewController animated:YES completion:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonPressed:(id)sender
{
    
    HomePageVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageVC"];
    
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
@end

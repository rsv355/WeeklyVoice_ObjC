//
//  CCKFNavDrawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "CCKFNavDrawer.h"
#import "DrawerView.h"
#import "EntertainmentVC.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface CCKFNavDrawer () <EntertainmentVcDelegate>
{
    
    
    NSMutableArray *categoryNameArray, *categoryArray, *categoryIdArray;
    
}

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;


@end

@implementation CCKFNavDrawer

#pragma mark - VC lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setUpDrawer];
    
    [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@",BASE_URL,FETCH_CATEGORY] for:1];
 
    
    categoryTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _drawerView.drawerTableView.frame.size.width, 40)];
    categoryTitleLabel.text = @"Title";
    categoryTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    
    categoryTitleLabel.backgroundColor = [UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:152.0/255.0 alpha:1.0];
    
    categoryTitleLabel.textColor = [UIColor whiteColor];
    
    categoryTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    _drawerView.drawerTableView.tableHeaderView = categoryTitleLabel;
    
    categoryTitleLabel.hidden = YES;
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    tapGesture.numberOfTapsRequired = 1;
    
    [categoryTitleLabel addGestureRecognizer:tapGesture];
    
    [categoryTitleLabel setUserInteractionEnabled:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITapGestureRecognizer
-(void)tapAction:(UITapGestureRecognizer *)gesture
{
    EntertainmentVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EntertainmentVC"];
    
    vc.EntertainmentVcDelegate = (id)self;
    
    _selectedString = categoryTitleLabel.text;
    
    vc.passedString = _selectedString;
    vc.passCategoryId = _categoryId;
    
    [self pushViewController:vc animated:YES];
    
    [self closeNavigationDrawer];

}

#pragma mark - Fetch & Parse Data From WEBSERVICE

-(void)fetchDataFromWebService: (NSString *)stringURL for:(NSInteger)selectInteger
{
    
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GET:stringURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *responseArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        [self parseDataResponseObject:responseArr for:selectInteger];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
        

        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        
        [errorAlert show];
        
    }];

    
    
}
-(void)parseDataResponseObject:(NSDictionary *)dictionary for:(NSInteger)selectInteger
{
    
    if (selectInteger == 1) {
        categoryArray = [[dictionary objectForKey:@"posts"]valueForKey:@"post"];
        
        categoryNameArray = [categoryArray valueForKey:@"cat_name"];
        categoryIdArray = [categoryArray valueForKey:@"tid"];
        
        _drawerView.drawerTableView.reloadData;
        
        [MBProgressHUD hideAllHUDsForView: self.view animated:YES];

    }
    
    else if (selectInteger == 2){
        
        categoryNameArray = [[[dictionary objectForKey:@"posts"]valueForKey:@"post"]valueForKey:@"cat_name"];
        categoryIdArray = [[[dictionary objectForKey:@"posts"]valueForKey:@"post"]valueForKey:@"tid"];
        
        _drawerView.drawerTableView.reloadData;

        
    }

    
}

#pragma mark - push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark - drawer

- (void)setUpDrawer
{
    self.isOpen = NO;
    
    // load drawer view
    self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    
    self.meunHeight = self.drawerView.frame.size.height;
    self.menuWidth = self.drawerView.frame.size.width;
    self.outFrame = CGRectMake(-self.menuWidth,0,self.menuWidth,self.meunHeight);
    self.inFrame = CGRectMake (0,0,self.menuWidth,self.meunHeight);
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:self.view.frame];
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    [self.shawdowView addGestureRecognizer:tapIt];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // drawer list
    [self.drawerView.drawerTableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)]; // statuesBarHeight+navBarHeight
    self.drawerView.drawerTableView.dataSource = self;
    self.drawerView.drawerTableView.delegate = self;
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    [self.view addGestureRecognizer:self.pan_gr];
    
    [self.view bringSubviewToFront:self.navigationBar];
    
//    for (id x in self.view.subviews){
//        NSLog(@"%@",NSStringFromClass([x class]));
//    }
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

#pragma open and close action

- (void)openNavigationDrawer{
//    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
}

- (void)closeNavigationDrawer{
//    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.outFrame;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
//    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
//        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
//        NSLog(@"changing");
        float movingx = self.drawerView.center.x + translation.x;
        if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
            
            self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
            self.shawdowView.hidden = NO;
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
//        NSLog(@"end");
        if (self.drawerView.center.x>0){
            [self openNavigationDrawer];
        }else if (self.drawerView.center.x<0){
            [self closeNavigationDrawer];
        }
    }

}

#pragma mark - EntertainmentVcDelegate Method

-(void)RefreshTableviewData:(NSString *)strSelected :(NSString *)categoryID
{
    NSLog(@"String Selected := %@",strSelected);
    _selectedString = strSelected;
    _categoryId = categoryID;
    
    if ([categoryID isEqualToString:@""]) {
        
        [[NSUserDefaults standardUserDefaults]setValue:@"NO" forKey:@"SUBCAT"];

        [self viewDidLoad];

    } else {
        
        [self fetchDataFromWebService:[NSString stringWithFormat:@"%@%@&tid=%@",BASE_URL,FETCH_SUB_CATEGORY,categoryID] for:2];
    }
    
 
    
    NSString *value = [[NSUserDefaults standardUserDefaults]valueForKey:@"SUBCAT"];
    
    if ([value isEqualToString:@"YES"]) {
        categoryTitleLabel.hidden = NO;
        
        categoryTitleLabel.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"catTitle"];
    } else
    {
        categoryTitleLabel.hidden = YES;
    }
    
    
    [MBProgressHUD hideAllHUDsForView: self.view animated:YES];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return categoryNameArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
 
    
        cell.textLabel.text = [categoryNameArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [ UIFont boldSystemFontOfSize:15.0];


    
  
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_drawerView.drawerTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.CCKFNavDrawerDelegate CCKFNavDrawerSelection:categoryNameArray[indexPath.row] :categoryIdArray[indexPath.row]];
    
    [self closeNavigationDrawer];
    
    _selectedString = [categoryNameArray objectAtIndex:indexPath.row];
    

    EntertainmentVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EntertainmentVC"];
    
    vc.EntertainmentVcDelegate = (id)self;
    
    vc.passedString = _selectedString;
    vc.passCategoryId = [categoryIdArray objectAtIndex:indexPath.row];
    
    [self pushViewController:vc animated:YES];
    

    

    
}

@end

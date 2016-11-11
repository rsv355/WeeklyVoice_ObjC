//
//  HomePageVC.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCKFNavDrawer.h"

#import "HeadlinesVcCell.h"
#import "RightnowVcCell.h"
#import "HomepageDropdownCell.h"

#import "DescriptionVC.h"
#import "EntertainmentVC.h"
#import "EPaperVC.h"
#import "FacebookVC.h"

#import "WEEKLYVOICEURL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#import "UIViewController+Transition.h"


@interface HomePageVC : UIViewController<CCKFNavDrawerDelegate>
{
    
    NSMutableArray *colorArray;
    
    NSMutableArray *topNewsImageArray, *topNewsLabelArray;
    
    NSMutableArray *rightNowImageArray, *rightNowTitleArray, *rightNowDateArray, *rightNowDescriptionArray ;
    
    NSMutableArray *headlinesNameArray, *headlinesImageArray, *headlinesDescriptionArray;
    
    NSMutableArray *breakingNewsTitleArray;

}


// TOP STORIES
@property (strong, nonatomic) IBOutlet UILabel *lblTopNewsTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageTopNews;



@property (strong, nonatomic) IBOutlet UIView *viewImagePager;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeightConstraint;

@property (weak, nonatomic) IBOutlet UIButton *btnWeeklyVoice;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionviewHeightConstraint;

@property (strong, nonatomic) IBOutlet UIButton *btnDropdown;

@property (strong, nonatomic) IBOutlet UITableView *tableviewDropdown;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableviewDropdownHeightConstraint;



@end

//
//  EntertainmentVC.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DescriptionVC.h"
#import "HomePageVC.h"
#import "CCKFNavDrawer.h"
#import "EPaperVC.h"


@protocol EntertainmentVcDelegate <NSObject>
@optional
-(void)RefreshTableviewData:(NSString *)strSelected;

@end


@interface EntertainmentVC : UIViewController <CCKFNavDrawerDelegate>

@property (weak, nonatomic)id<EntertainmentVcDelegate> EntertainmentVcDelegate;

@property (strong, nonatomic) NSString *passedString;
@property (strong, nonatomic) NSString *passedSubCategoryTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSubCategoryTitle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *tableviewDropDown;
@property (strong, nonatomic) IBOutlet UIButton *btnDropdown;
@property (strong, nonatomic) IBOutlet UIButton *btnTopNews;
@property (strong, nonatomic) IBOutlet UIButton *btnLeftMenu;

@property (strong, nonatomic) IBOutlet UIView *viewNavigationBar;



@property (strong, nonatomic) IBOutlet NSLayoutConstraint *dropdownTableviewHeightConstraint;


@end

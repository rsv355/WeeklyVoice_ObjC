//
//  CCKFNavDrawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 23/1/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WEEKLYVOICEURL.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@protocol CCKFNavDrawerDelegate <NSObject>
@required
- (void)CCKFNavDrawerSelection:(NSString *)selectedIndexString;

@end

@interface CCKFNavDrawer : UINavigationController<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *selectedString;
@property (nonatomic, strong) NSString *selectedSubCategoryString;
@property (nonatomic, strong) UIPanGestureRecognizer *pan_gr;

@property (weak, nonatomic)id<CCKFNavDrawerDelegate> CCKFNavDrawerDelegate;

- (void)drawerToggle;

@end

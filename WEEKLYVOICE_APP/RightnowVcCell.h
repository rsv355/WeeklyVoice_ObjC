//
//  RightnowVcCell.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightnowVcCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageviewRightNow;
@property (strong, nonatomic) IBOutlet UILabel *lblTitleRightNow;
@property (strong, nonatomic) IBOutlet UILabel *lblDateRightNow;
@property (strong, nonatomic) IBOutlet UILabel *lblDescriptionRightNow;

@end

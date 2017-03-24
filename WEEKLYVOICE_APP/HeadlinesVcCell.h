//
//  HeadlinesVcCell.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadlinesVcCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblCategoryName;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblCategoryDescription;

@end

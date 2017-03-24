//
//  VideoVC.h
//  WEEKLYVOICE_APP
//
//  Created by Webmyne on 11/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * video_array;
    NSMutableDictionary * postDictionary;
    NSString * videoUrl;
}
- (IBAction)backButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableViewVideoList;

@end

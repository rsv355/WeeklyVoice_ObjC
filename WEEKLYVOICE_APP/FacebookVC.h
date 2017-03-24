//
//  FacebookVC.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 09/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageVC.h"

@interface FacebookVC : UIViewController

@property (strong, nonatomic) NSString *strVideoID;
@property (strong, nonatomic) NSString *strVideoURL;
@property (strong, nonatomic) NSString *strVideoTitle;




@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;



@end

//
//  EPaperVC.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 09/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EPaperVC : UIViewController <UIWebViewDelegate>
{
    NSString * Url;

}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property(strong,atomic) NSString * videoUrl;
@property(strong,atomic) NSString * viewID;

@end

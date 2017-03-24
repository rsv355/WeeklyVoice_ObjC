//
//  UIViewController+Transition.h
//  KIImagePager
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Transition)
- (void) presentViewController:(UIViewController *)viewController withPushDirection: (NSString *) direction;
- (void) dismissViewControllerWithPushDirection:(NSString *) direction;

@end

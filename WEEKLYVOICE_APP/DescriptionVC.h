//
//  DescriptionVC.h
//  WEEKLYVOICE_APP
//
//  Created by Jenish Mistry on 07/11/16.
//  Copyright © 2016 Jenish Mistry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageVC.h"
#import "AddCommentVC.h"
#import "CommentCell.h"
#import "CustomAnimationAndTransiotion.h"

@interface DescriptionVC : UIViewController
{
    NSMutableArray *Discription_Dictionary;
    
    NSMutableArray *commentArray;


}


@property (strong, nonatomic) NSString *stringNID;

@property (strong, nonatomic) NSMutableDictionary *commentDictionary;

@property (strong, nonatomic) IBOutlet UIImageView *Discription_image;

@property (strong, nonatomic) IBOutlet UILabel *tilte_Lbl;

@property (strong, nonatomic) IBOutlet UITextView *Discription_textView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *DescriptionTextviewHeightConstraint;


@property (strong, nonatomic) CustomAnimationAndTransiotion *CustomAnimationAndTransiotion;

@property (strong, nonatomic) IBOutlet UILabel *lblCommentsTitle;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblCommentHeightConstraint;

@property (strong, nonatomic) IBOutlet UITableView *tableviewComment;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeightConstraint;

@end

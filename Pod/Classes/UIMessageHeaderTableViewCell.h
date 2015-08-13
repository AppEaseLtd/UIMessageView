//
//  UIMessageHeaderTableViewCell.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIMessageHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDate *date;

+ (CGFloat)height;

@end

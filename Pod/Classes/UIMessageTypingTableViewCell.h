//
//  UIMessageTypingTableViewCell.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMessageView.h"

@interface UIMessageTypingTableViewCell : UITableViewCell

@property (nonatomic) NSMessageTypingType type;
@property (nonatomic) BOOL showAvatar;

+ (CGFloat)height;

@end

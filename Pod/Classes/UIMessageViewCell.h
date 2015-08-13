//
//  UIMessageViewCell.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSMessageData;

@interface UIMessageViewCell : UITableViewCell

@property (nonatomic, strong) NSMessageData *data;
@property (nonatomic) BOOL showAvatar;

- (UIImage *)messageMineImage;
- (UIImage *)messageOtherImage;

@end

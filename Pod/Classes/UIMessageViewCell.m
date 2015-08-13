//
//  UIMessageViewCell.m
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import "UIMessageViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "NSMessageData.h"
#import "UIImage+PodImages.h"

@interface UIMessageViewCell ()

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIImageView *messageImage;
@property (nonatomic, strong) UIImageView *avatarImage;

- (void)setupInternalData;

@end

@implementation UIMessageViewCell

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setupInternalData];
}

- (void)setDataInternal:(NSMessageData *)value
{
    self.data = value;
    [self setupInternalData];
}

- (void) setupInternalData
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!self.messageImage)
    {
        self.messageImage = [[UIImageView alloc] init];
        [self addSubview:self.messageImage];
    }
    
    NSMessageType type = self.data.type;
    
    CGFloat width = self.data.view.frame.size.width;
    CGFloat height = self.data.view.frame.size.height;
    
    CGFloat x = (type == NSMessageTypeOther) ? 0 : self.frame.size.width - width - self.data.insets.left - self.data.insets.right;
    CGFloat y = 0;
    
    // Adjusting the x coordinate for avatar
    if (self.showAvatar)
    {
        [self.avatarImage removeFromSuperview];
        
        self.avatarImage = [[UIImageView alloc] initWithImage:(self.data.avatar ? self.data.avatar : [UIImage podImageNamed:@"missingAvatar"])];
        self.avatarImage.layer.cornerRadius = 9.0;
        self.avatarImage.layer.masksToBounds = YES;
        self.avatarImage.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
        self.avatarImage.layer.borderWidth = 1.0;
        
        CGFloat avatarX = (type == NSMessageTypeOther) ? 2 : self.frame.size.width - 52;
        CGFloat avatarY = self.frame.size.height - 50;
        
        self.avatarImage.frame = CGRectMake(avatarX, avatarY, 50, 50);
        [self addSubview:self.avatarImage];
        
        CGFloat delta = self.frame.size.height - (self.data.insets.top + self.data.insets.bottom + self.data.view.frame.size.height);
        if (delta > 0) y = delta;
        
        if (type == NSMessageTypeOther) x += 54;
        if (type == NSMessageTypeMine) x -= 54;
    }
    
    [self.customView removeFromSuperview];
    self.customView = self.data.view;
    self.customView.frame = CGRectMake(x + self.data.insets.left, y + self.data.insets.top, width, height);
    [self.contentView addSubview:self.customView];
    
    if (type == NSMessageTypeOther)
    {
        self.messageImage.image = self.messageOtherImage;
        
    }
    else {
        self.messageImage.image = self.messageMineImage;
    }
    
    self.messageImage.frame = CGRectMake(x, y, width + self.data.insets.left + self.data.insets.right, height + self.data.insets.top + self.data.insets.bottom);
}

- (UIImage *)messageMineImage {
    return [[UIImage podImageNamed:@"messageMine.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
}

- (UIImage *)messageOtherImage {
    return [[UIImage podImageNamed:@"messageOther.png"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
}

@end

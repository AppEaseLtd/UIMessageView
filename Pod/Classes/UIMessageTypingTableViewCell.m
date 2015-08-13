//
//  UIMessageTypingTableViewCell.m
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import "UIMessageTypingTableViewCell.h"
#import "UIImage+PodImages.h"

@interface UIMessageTypingTableViewCell ()

@property (nonatomic, strong) UIImageView *typingImageView;

@end

@implementation UIMessageTypingTableViewCell

+ (CGFloat)height
{
    return 40.0;
}

- (void)setType:(NSMessageTypingType)value
{
    if (!self.typingImageView)
    {
        self.typingImageView = [[UIImageView alloc] init];
        [self addSubview:self.typingImageView];
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImage *messageImage = nil;
    CGFloat x = 0;
    
    if (value == NSMessageTypingTypeMe)
    {
        messageImage = [UIImage podImageNamed:@"typingMine.png"];
        x = self.frame.size.width - 5;
    }
    else
    {
        messageImage = [UIImage podImageNamed:@"typingOther.png"];
        x = 5;
    }
    
    self.typingImageView.image = messageImage;
    self.typingImageView.frame = CGRectMake(x, 10, 63, 37);
}

@end

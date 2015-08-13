//
//  NSMessageData.m
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import "NSMessageData.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSMessageData

#pragma mark - Text Message

const UIEdgeInsets textInsetsMine = {6, 12, 13, 19};
const UIEdgeInsets textInsetsOther = {6, 17, 13, 14};

+ (instancetype)dataWithText:(NSString *)text date:(NSDate *)date type:(NSMessageType)type
{
    return [[NSMessageData alloc] initWithText:text date:date type:type];
}

- (instancetype)initWithText:(NSString *)text date:(NSDate *)date type:(NSMessageType)type
{
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    CGSize size = [(text ? text : @"") boundingRectWithSize:CGSizeMake(220, 9999) 
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{ NSFontAttributeName:font }
                                                    context:nil].size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = (text ? text : @"");
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = type == NSMessageTypeMine ? [UIColor whiteColor] : [UIColor blackColor];
    
    UIEdgeInsets insets = (type == NSMessageTypeMine ? textInsetsMine : textInsetsOther);
    return [self initWithView:label date:date type:type insets:insets];
}

#pragma mark - Image Message

const UIEdgeInsets imageInsetsMine = {11, 13, 16, 22};
const UIEdgeInsets imageInsetsOther = {11, 18, 16, 14};

+ (instancetype)dataWithImage:(UIImage *)image date:(NSDate *)date type:(NSMessageType)type
{
    return [[NSMessageData alloc] initWithImage:image date:date type:type];
}

- (instancetype)initWithImage:(UIImage *)image date:(NSDate *)date type:(NSMessageType)type
{
    CGSize size = image.size;
    if (size.width > 220)
    {
        size.height /= (size.width / 220);
        size.width = 220;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    imageView.image = image;
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    
    UIEdgeInsets insets = (type == NSMessageTypeMine ? imageInsetsMine : imageInsetsOther);
    return [self initWithView:imageView date:date type:type insets:insets];       
}

#pragma mark - Custom view message

+ (instancetype)dataWithView:(UIView *)view date:(NSDate *)date type:(NSMessageType)type insets:(UIEdgeInsets)insets
{
    return [[NSMessageData alloc] initWithView:view date:date type:type insets:insets];
}

- (instancetype)initWithView:(UIView *)view date:(NSDate *)date type:(NSMessageType)type insets:(UIEdgeInsets)insets  
{
    self = [super init];
    if (self)
    {
        _view = view;
        _date = date;
        
        _type = type;
        _insets = insets;
    }
    return self;
}

@end

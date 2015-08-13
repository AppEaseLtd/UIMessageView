//
//  NSMessageData.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _NSMessageType
{
    NSMessageTypeMine = 0,
    NSMessageTypeOther = 1
} NSMessageType;

@interface NSMessageData : NSObject

@property (readonly, nonatomic, strong) NSDate *date;
@property (readonly, nonatomic) NSMessageType type;
@property (readonly, nonatomic, strong) UIView *view;
@property (readonly, nonatomic) UIEdgeInsets insets;
@property (nonatomic, strong) UIImage *avatar;

- (instancetype)initWithText:(NSString *)text date:(NSDate *)date type:(NSMessageType)type;
+ (instancetype)dataWithText:(NSString *)text date:(NSDate *)date type:(NSMessageType)type;
- (instancetype)initWithImage:(UIImage *)image date:(NSDate *)date type:(NSMessageType)type;
+ (instancetype)dataWithImage:(UIImage *)image date:(NSDate *)date type:(NSMessageType)type;
- (instancetype)initWithView:(UIView *)view date:(NSDate *)date type:(NSMessageType)type insets:(UIEdgeInsets)insets NS_DESIGNATED_INITIALIZER;
+ (instancetype)dataWithView:(UIView *)view date:(NSDate *)date type:(NSMessageType)type insets:(UIEdgeInsets)insets;

@end
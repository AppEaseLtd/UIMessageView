//
//  UIMessageView.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMessageViewDataSource.h"
#import "UIMessageViewCell.h"

typedef enum _NSMessageTypingType
{
    NSMessageTypingTypeNobody = 0,
    NSMessageTypingTypeMe = 1,
    NSMessageTypingTypeOther = 2
} NSMessageTypingType;

@interface UIMessageView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet id<UIMessageViewDataSource> messageDataSource;
@property (nonatomic) NSTimeInterval snapInterval;
@property (nonatomic) NSMessageTypingType typingMessage;
@property (nonatomic) BOOL showAvatars;

@property (nonatomic) Class messageCellClass;

- (void) scrollMessageViewToBottomAnimated:(BOOL)animated;

@end

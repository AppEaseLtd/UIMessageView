//
//  UIMessageViewDataSource.h
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSMessageData;
@class UIMessageView;
@protocol UIMessageViewDataSource <NSObject>

@optional

@required

- (NSInteger)rowsForMessagesTable:(UIMessageView *)messageView;
- (NSMessageData *)messagesView:(UIMessageView *)messageView dataForRow:(NSInteger)row;

@end
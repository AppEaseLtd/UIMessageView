//
//  UIMessageView.m
//  UIMessageView
//
//  Created by Robin Crorie on 11/08/2015.
//  Copyright (c) 2015 AppEase Ltd. All rights reserved.
//

#import "UIMessageView.h"
#import "NSMessageData.h"
#import "UIMessageHeaderTableViewCell.h"
#import "UIMessageTypingTableViewCell.h"

@interface UIMessageView ()

@property (nonatomic, strong) NSMutableArray *messageSection;

@end

@implementation UIMessageView

#pragma mark - Initializators

- (void)initializator
{
    // UITableView properties
    
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    assert(self.style == UITableViewStylePlain);
    
    self.delegate = self;
    self.dataSource = self;
    
    // UIMessageView default properties
    
    self.snapInterval = 120;
    self.typingMessage = NSMessageTypingTypeNobody;
}

- (instancetype)init
{
    self = [super init];
    if (self) [self initializator];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self initializator];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self initializator];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) [self initializator];
    return self;
}

#pragma mark - Override

- (void)reloadData
{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    // Cleaning up
    self.messageSection = nil;
    
    // Loading new data
    NSInteger count = 0;
    
    self.messageSection = [[NSMutableArray alloc] init];
    
    if (self.messageDataSource && (count = [self.messageDataSource rowsForMessagesTable:self]) > 0)
    {
        NSMutableArray *messageData = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (int i = 0; i < count; i++)
        {
            NSObject *object = [self.messageDataSource messagesView:self dataForRow:i];
            assert([object isKindOfClass:[NSMessageData class]]);
            [messageData addObject:object];
        }
        
        [messageData sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
         {
             NSMessageData *messageData1 = (NSMessageData *)obj1;
             NSMessageData *messageData2 = (NSMessageData *)obj2;
             
             return [messageData1.date compare:messageData2.date];            
         }];
        
        NSDate *last = [NSDate dateWithTimeIntervalSince1970:0];
        NSMutableArray *currentSection = nil;
        
        for (int i = 0; i < count; i++)
        {
            NSMessageData *data = (NSMessageData *)messageData[i];
            
            if ([data.date timeIntervalSinceDate:last] > self.snapInterval)
            {
                currentSection = [[NSMutableArray alloc] init];
                [self.messageSection addObject:currentSection];
            }
            
            [currentSection addObject:data];
            last = data.date;
        }
    }
    
    NSInteger numRows = [self tableView:self numberOfRowsInSection:0];
    CGFloat contentInsetTop = self.bounds.size.height;
    for (NSInteger i = 0; i < numRows; i++) {
        contentInsetTop -= [self tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        if (contentInsetTop <= 0) {
            contentInsetTop = 0;
            break;
        }
    }
    self.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
    
    [super reloadData];
}

#pragma mark - UITableViewDelegate implementation

#pragma mark - UITableViewDataSource implementation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger result = [self.messageSection count];
    if (self.typingMessage != NSMessageTypingTypeNobody) result++;
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // This is for now typing bubble
    if (section >= [self.messageSection count]) return 1;
    
    return [(self.messageSection)[section] count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Now typing
    if (indexPath.section >= [self.messageSection count])
    {
        return MAX([UIMessageTypingTableViewCell height], self.showAvatars ? 52 : 0);
    }
    
    // Header
    if (indexPath.row == 0)
    {
        return [UIMessageHeaderTableViewCell height];
    }
    
    NSMessageData *data = (self.messageSection)[indexPath.section][indexPath.row - 1];
    return MAX(data.insets.top + data.view.frame.size.height + data.insets.bottom, self.showAvatars ? 52 : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Now typing
    if (indexPath.section >= [self.messageSection count])
    {
        static NSString *cellId = @"tblMessageTypingCell";
        UIMessageTypingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (cell == nil) cell = [[UIMessageTypingTableViewCell alloc] init];
        
        cell.type = self.typingMessage;
        cell.showAvatar = self.showAvatars;
        
        return cell;
    }
    
    // Header with date and time
    if (indexPath.row == 0)
    {
        static NSString *cellId = @"tblMessageHeaderCell";
        UIMessageHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        NSMessageData *data = (self.messageSection)[indexPath.section][0];
        
        if (cell == nil) cell = [[UIMessageHeaderTableViewCell alloc] init];
        
        cell.date = data.date;
        
        return cell;
    }
    
    // Standard message    
    static NSString *cellId = @"tblMessageCell";
    UIMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSMessageData *data = (self.messageSection)[indexPath.section][indexPath.row - 1];
    
    if (cell == nil) cell = (UIMessageViewCell *) [[[_messageCellClass class] alloc] init];
    
    cell.data = data;
    cell.showAvatar = self.showAvatars;
    
    return cell;
}

#pragma mark - Public interface

- (void)scrollMessageViewToBottomAnimated:(BOOL)animated
{
    NSInteger lastSectionIdx = [self numberOfSections] - 1;
    
    if (lastSectionIdx >= 0)
    {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:([self numberOfRowsInSection:lastSectionIdx] - 1) inSection:lastSectionIdx] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}


#pragma mark - Appearance

- (Class)messageCellClass {
    return _messageCellClass ? _messageCellClass : [UIMessageViewCell class];
}

@end

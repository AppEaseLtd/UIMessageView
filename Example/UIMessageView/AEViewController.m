//
//  AEViewController.m
//  UIMessageView
//
//  Created by Robin Crorie on 08/12/2015.
//  Copyright (c) 2015 Robin Crorie. All rights reserved.
//

#import "AEViewController.h"
#import "AECustomMessageTableViewCell.h"
#import "UIMessageView.h"
#import "NSMessageData.h"
#import "UIMessageViewDataSource.h"

@interface AEViewController () <UIMessageViewDataSource>
{
    IBOutlet UIMessageView *messageTable;
    IBOutlet UIView *textInputView;
    IBOutlet UITextField *textField;
    __weak IBOutlet NSLayoutConstraint *textInputBottomConstraint;

    NSMutableArray *messageData;
}
@end

@implementation AEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    messageTable.messageCellClass = [AECustomMessageTableViewCell class];
    
    NSMessageData *heyMessage = [NSMessageData dataWithText:@"Hey Robin, How's the app coming along?" date:[NSDate dateWithTimeIntervalSinceNow:-300] type:NSMessageTypeOther];
    heyMessage.avatar = nil;
    
    NSMessageData *replyMessage = [NSMessageData dataWithText:@"Whatsup Nick! Really good... You finished my API yet?" date:[NSDate dateWithTimeIntervalSinceNow:-200] type:NSMessageTypeMine];
    replyMessage.avatar = nil;
    
    NSMessageData *eekMessage = [NSMessageData dataWithText:@"Urm.. No - I got distracted" date:[NSDate dateWithTimeIntervalSinceNow:-100] type:NSMessageTypeOther];
    heyMessage.avatar = nil;
    
    NSMessageData *lolMessage = [NSMessageData dataWithText:@"lol" date:[NSDate dateWithTimeIntervalSinceNow:-99] type:NSMessageTypeOther];
    heyMessage.avatar = nil;
    
    NSMessageData *photoMessage = [NSMessageData dataWithImage:[UIImage imageNamed:@"lol.jpg"] date:[NSDate dateWithTimeIntervalSinceNow:-90] type:NSMessageTypeOther];
    photoMessage.avatar = nil;
    
    messageData = [[NSMutableArray alloc] initWithObjects:heyMessage, replyMessage, lolMessage, eekMessage, photoMessage, nil];
    messageTable.messageDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the messages will be grouped in time.
    // Interval of 120 means that if the next messages comes within 2 minutes of the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    messageTable.snapInterval = 120;

    // The line below enables avatar support. Avatar can be specified for each message with .avatar property of NSMessageData.
    // Avatars are enabled for the whole table at once. If a particular NSMessageData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    messageTable.showAvatars = NO;
    
    // The line below adds "Now typing" message indicator
    // Possible values are
    //    - NSBubbleTypingTypeOther - shows "now typing" icon on the left
    //    - NSBubbleTypingTypeMe    - shows "now typing" icon on the right
    //    - NSBubbleTypingTypeNone  - no "now typing" icon shown
    
    messageTable.typingMessage = NSMessageTypingTypeOther;

    

    // Keyboard events
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [messageTable reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForMessagesTable:(UIMessageView *)messageView
{
    return [messageData count];
}

- (NSMessageData *)messagesView:(UIMessageView *)messageView dataForRow:(NSInteger)row
{
    return messageData[row];
}

#pragma mark - Keyboard events

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [info[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    textInputBottomConstraint.constant = kbSize.height;
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [messageTable reloadData];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    textInputBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [messageTable reloadData];
}

#pragma mark - Actions

- (IBAction)sendMessage:(id)sender
{
    messageTable.typingMessage = NSMessageTypingTypeNobody;
    
    if (textField.text.length > 0) {
        NSMessageData *message = [NSMessageData dataWithText:textField.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:NSMessageTypeMine];
        [messageData addObject:message];
        [messageTable reloadData];
    }
    
    textField.text = @"";
    [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

//
//  MUNWindowController.m
//  Munenori
//
//  Created by Aaron Vegh on 2013-06-29.
//  Copyright (c) 2013 Aaron Vegh. All rights reserved.
//

#import "MUNWindowController.h"
#import "MUNAppDelegate.h"
#import <ADNKit/ADNKit.h>
#import "MUNReplyMessageCell.h"
#import "MUNToMessageCell.h"

@interface MUNWindowController ()

@end

@implementation MUNWindowController

- (id)initWithWindowNibName:(NSString*)nibName andChannel:(ANKChannel*)channel
{
    self = [super initWithWindowNibName:nibName];
    if (self) {
        self.thisChannel = channel;
        self.messages = [NSMutableArray array];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [[ANKClient sharedClient] fetchMessagesInChannel:self.thisChannel completion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
        NSArray * originalMessages = (NSMutableArray*)responseObject;
        
        NSEnumerator *enumerator = [originalMessages reverseObjectEnumerator];
        for (id element in enumerator) {
            [self.messages addObject:element];
        }
        
        self.appDelegate = (MUNAppDelegate *)[NSApp delegate];
        [self.tableView reloadData];
        [self.tableView scrollRowToVisible:[self.messages count] - 1];
    }];
}

- (IBAction)sendMessage:(id)sender
{
    NSString * textToSend = self.entryField.stringValue;
    
    
    [[ANKClient sharedClient] createMessageWithText:textToSend inReplyToMessageWithID:[self.thisChannel latestMessageID] inChannel:self.thisChannel completion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
        NSLog(@"Post successful?");
    }];
    
}

# pragma mark - Table View Data Source and Delegate Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.messages count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    ANKMessage * thisMessage = [self.messages objectAtIndex:row];
    ANKUser * messageUser = thisMessage.user;
    
    NSImage * avatar = [[NSImage alloc] initWithContentsOfURL:[[messageUser avatarImage] URL]];
    
    if ([[messageUser userID] isEqualTo:[self.appDelegate authenticatedUserID]]) {
        MUNReplyMessageCell * cell = [tableView makeViewWithIdentifier:@"replyMessageCell" owner:self];
        cell.textField.stringValue = [thisMessage text];
        cell.imageView.image = avatar;
        return cell;
    }
    else {
        MUNToMessageCell * cell = [tableView makeViewWithIdentifier:@"toMessageCell" owner:self];
        cell.textField.stringValue = [thisMessage text];
        cell.imageView.image = avatar;
        return cell;
    }
    
    
}



@end

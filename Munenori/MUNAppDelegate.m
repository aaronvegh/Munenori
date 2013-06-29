//
//  MUNAppDelegate.m
//  Munenori
//
//  Created by Aaron Vegh on 2013-06-28.
//  Copyright (c) 2013 Aaron Vegh. All rights reserved.
//

#import "MUNAppDelegate.h"
#import <ADNKit/ADNKit.h>
#import <WebKit/WebKit.h>
#import <JLRoutes/JLRoutes.h>
#include "NSWindow+AccessoryView.h"
#include "MUNAuthWindowWindowController.h"
#include "MUNChannelTableViewCell.h"
#include "MUNWindowController.h"

NSString * const kADNAccessId = @"";
NSString * const kADNSecret = @"";

@implementation MUNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    NSButton * authenticateButton = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
    [authenticateButton setBezelStyle:NSRecessedBezelStyle];
    [authenticateButton setTarget:self];
    authenticateButton.title = @"Authenticate";
    [authenticateButton setAction:@selector(openAuthWindow:)];
    [self.window addViewToTitleBar:authenticateButton atXPosition:self.window.frame.size.width - authenticateButton.frame.size.width - 10];
    
    
    [ANKClient sharedClient].webAuthCompletionHandler = ^(BOOL success, NSError *error) {
        if (success) {
            self.authenticatedUsername = [[[ANKClient sharedClient] authenticatedUser] username];
            self.authenticatedUserID = [[[ANKClient sharedClient] authenticatedUser] userID];
            authenticateButton.title = self.authenticatedUsername;
            [self.authWindow close];
            self.authWindow = nil;
            
            [self showChannels];
        } else {
            NSLog(@"could not authenticate, error: %@", error);
        }
    };
    
    
    [JLRoutes addRoute:@"/auth" handler:^BOOL(NSDictionary *parameters) {
        NSString *accessCode = parameters[@"code"];
        
        // now that we have the accessCode, we need to finish the process.
        [[ANKClient sharedClient] authenticateWebAuthAccessCode:accessCode forClientID:kADNAccessId clientSecret:kADNSecret];
        
        return YES; // return YES to say we have handled the route
    }];
    
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleAppleEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
    
    [self.tableView setTarget:self];
    [self.tableView setDoubleAction:@selector(openChannel:)];
    
}

- (void)handleAppleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    NSString *urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    [JLRoutes routeURL:[NSURL URLWithString:urlString]];
}

- (void)openAuthWindow:(id)sender
{
    if(!self.authWindow) {
        self.authWindow = [[MUNAuthWindowWindowController alloc] initWithWindowNibName:@"MUNAuthWindowWindowController"];
     }
    
     [self.authWindow showWindow:self];
}

- (void)showChannels
{
    
    [[ANKClient sharedClient] fetchCurrentUserSubscribedChannelsWithCompletion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
        self.channelArray = (NSArray*)responseObject;
        [self.tableView reloadData];
        
    }];
}

# pragma mark - Table View Data Source and Delegate Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.channelArray count];
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    MUNChannelTableViewCell *result = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    __block ANKChannel * channel = [self.channelArray objectAtIndex:row];
    NSArray * participants = [[channel writers] userIDs];
    
    [[ANKClient sharedClient] fetchUsersWithIDs:participants completion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
        NSArray * users = (NSArray*)responseObject;
        NSMutableString * userString = [NSMutableString stringWithString:[[channel owner] username]];
        for (ANKUser * userObj in users) {
            [userString appendFormat:@", %@", [userObj username]];
        }
        
        NSImage * avatar = [[NSImage alloc] initWithContentsOfURL:[[channel.owner avatarImage] URL]];
        result.imageView.image = avatar;
        result.textField.stringValue = userString;
        
        [[ANKClient sharedClient] fetchMessageWithID:[channel latestMessageID] inChannel:channel completion:^(id responseObject, ANKAPIResponseMeta *meta, NSError *error) {
            result.lastMessage.stringValue = [NSString stringWithFormat:@"%@: '%@'", [(ANKUser*)[responseObject user] username], [responseObject text]];
        }];
    }];
    
    return result;
}

- (void)openChannel:(id)sender
{
    NSInteger clickedRow = [self.tableView clickedRow];
    ANKChannel * openingChannel = [self.channelArray objectAtIndex:clickedRow];
    
    if (!self.messageWindow) {
        self.messageWindow = [[MUNWindowController alloc] initWithWindowNibName:@"MUNWindowController" andChannel:openingChannel];
    }
    
    [self.messageWindow showWindow:nil];
    
}

@end

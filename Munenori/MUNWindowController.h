//
//  MUNWindowController.h
//  Munenori
//
//  Created by Aaron Vegh on 2013-06-29.
//  Copyright (c) 2013 Aaron Vegh. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ANKChannel;
@class MUNAppDelegate;

@interface MUNWindowController : NSWindowController <NSTableViewDataSource, NSTableViewDelegate>

@property (strong, readwrite) MUNAppDelegate * appDelegate;
@property (strong, readwrite) ANKChannel * thisChannel;
@property (strong, readwrite) NSMutableArray * messages;

@property (strong, readwrite) IBOutlet NSTableView * tableView;
@property (strong, readwrite) IBOutlet NSTextField * entryField;
@property (strong, readwrite) IBOutlet NSButton * sendButton;

- (IBAction)sendMessage:(id)sender;
- (id)initWithWindowNibName:(NSString*)nibName andChannel:(ANKChannel*)channel;

@end

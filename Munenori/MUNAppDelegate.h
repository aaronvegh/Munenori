//
//  MUNAppDelegate.h
//  Munenori
//
//  Created by Aaron Vegh on 2013-06-28.
//  Copyright (c) 2013 Aaron Vegh. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@class MUNAuthWindowWindowController;
@class MUNWindowController;

extern NSString * const kADNAccessId;
extern NSString * const kADNSecret;

@interface MUNAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, strong) MUNAuthWindowWindowController * authWindow;
@property (readwrite, strong) MUNWindowController * messageWindow;

@property (readwrite, strong) NSString * authenticatedUsername;
@property (readwrite, strong) NSString * authenticatedUserID;
@property (readwrite, strong) NSArray * channelArray;
@property (readwrite, strong) IBOutlet NSTableView * tableView;
@end

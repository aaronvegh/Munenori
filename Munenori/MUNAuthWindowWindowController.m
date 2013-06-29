//
//  MUNAuthWindowWindowController.m
//  Munenori
//
//  Created by Aaron Vegh on 2013-06-28.
//  Copyright (c) 2013 Aaron Vegh. All rights reserved.
//

#import "MUNAuthWindowWindowController.h"
#import <ADNKit/ADNKit.h>
#import "MUNAppDelegate.h"

@interface MUNAuthWindowWindowController ()

@end

@implementation MUNAuthWindowWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // ask for permission to see user information, fetch their streams, and send Posts
        
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    ANKAuthScope requestedScopes = ANKAuthScopeBasic | ANKAuthScopeMessages;
    
    // create a URLRequest to kick off the auth process...
    NSURLRequest *authRequest = [[ANKClient sharedClient] webAuthRequestForClientID:kADNAccessId
                                                                        redirectURI:@"munenori://auth"
                                                                         authScopes:requestedScopes
                                                                              state:nil
                                                                  appStoreCompliant:YES];
    
    [self.myWebView.mainFrame loadRequest:authRequest];
}

@end

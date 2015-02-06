//
//  AppDelegate.h
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/07.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TwitterController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    TwitterController *twitter;
}
@property (weak) IBOutlet NSTextField *consumerKey;
@property (weak) IBOutlet NSTextField *consumerSecret;
@property (weak) IBOutlet NSTextField *accessToken;

@property (weak) IBOutlet NSTextField *accessTokenSecret;

- (IBAction)startButton:(id)sender;




@end


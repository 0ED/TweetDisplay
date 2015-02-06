//
//  DisplayOnDesktop.h
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/09.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

#define ANIMATION_MODE NSAnimationNonblocking

@interface DisplayOnDesktop : NSObject <NSApplicationDelegate, NSStreamDelegate, NSAnimationDelegate> {

}
-(void) displayTweetText:(NSString *) str imageURL:(NSString *) url;
@end

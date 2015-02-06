//
//  TwitterController.h
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/07.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTwitter/STTwitter.h"
#import "DisplayOnDesktop.h"

#define CONSUMER_KEY @"??"
#define CONSUMER_SEC @"??";
#define ACCESS_TOKEN @"??";
#define ACCESS_TOKEN_SEC @"??";




@interface TwitterController : NSObject{
    STTwitterAPI   *twitterAPI;
    DisplayOnDesktop *displayOnDesktop;
    NSString *beforeId;
}
@property (strong, nonatomic) STTwitterAPI   *twitterAPI;
@property (strong, nonatomic) DisplayOnDesktop *displayOnDesktop;
@property (strong, nonatomic) id appDelegate;
@property (strong, nonatomic) NSString *beforeId;

- (void)initTwitter;
- (void)loginTwitterConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accsessToken:(NSString *)accessToken accessTokenSecret:(NSString *) accessTokenSecret ;
- (void)setDisplayOnDesktop:(DisplayOnDesktop *) ddod;
- (void)getTimeLine;
@end

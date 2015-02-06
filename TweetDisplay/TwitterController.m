//
//  TwitterController.m
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/07.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import "TwitterController.h"


@implementation TwitterController

-(void) setDisplayOnDesktop:(DisplayOnDesktop *) ddod{
    displayOnDesktop = ddod;
        
}
-(void) loginTwitterConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accsessToken:(NSString *)accessToken accessTokenSecret:(NSString *) accessTokenSecret
{
    
    self.twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                   consumerKey:consumerKey
                                                consumerSecret:consumerSecret
                                                    oauthToken:accessToken
    oauthTokenSecret:accessTokenSecret];
/*   self.twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerName:nil
                                                   consumerKey:CONSUMER_KEY
                                                consumerSecret:CONSUMER_SEC
                                                    oauthToken:ACCESS_TOKEN
                                                   oauthTokenSecret:ACCESS_TOKEN_SEC];*/
    [self.twitterAPI verifyCredentialsWithSuccessBlock:^(NSString *username) {
        //NSLog(@"succeeded");
    } errorBlock:^(NSError *error) {
        //NSLog(@"error : %@", error);
    }];
    self.beforeId = nil;
}
-(void) getTimeLine{

    [self.twitterAPI getHomeTimelineSinceID:nil count:30 successBlock:^(NSArray *status){
        NSString *firstTweetId;
        NSMutableArray *keepText = [[NSMutableArray alloc] init];
        NSMutableArray *keepImageURL = [[NSMutableArray alloc] init];
        
        int count = 0;
        for(NSDictionary *dic in status){
            NSString *text,*account,*imageURL,*tweetId;
            text = [[NSString alloc]  initWithString:[dic objectForKey:@"text"]];
            NSDictionary *user  = [dic objectForKey:@"user"];
            tweetId = [user objectForKey:@"id_str"];
            account = [user objectForKey:@"screen_name"];
            imageURL = [user objectForKey:@"profile_image_url"];
            if(count == 0)firstTweetId = [NSString stringWithString:tweetId];
            if([self.beforeId isEqualToString:tweetId]){
                self.beforeId = [NSString stringWithString:tweetId];
                break;
            }
            account =[[@"@" stringByAppendingString:account] stringByAppendingString:@" "];
            [keepText addObject:[account stringByAppendingString:text]];
            [keepImageURL addObject:imageURL];
            count++;
        }
        self.beforeId = [NSString stringWithString:firstTweetId];
        for(int i = keepText.count-1; i >= 0;i--){
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [[keepText objectAtIndex:i] stringByReplacingOccurrencesOfString:@"\n"  withString:@" "], @"text",
                                      [keepImageURL objectAtIndex:i], @"imageURL", nil];
            [NSTimer scheduledTimerWithTimeInterval:4.0f*(keepText.count - 1 - i)
                                             target:displayOnDesktop
                                           selector:@selector(doTimerDisplayTweetText:)
                                           userInfo:userInfo
                                            repeats:NO
             ];
            
        }
    }errorBlock:^(NSError *message){
        NSLog(@"error : %@", message);
    }];
}

@end

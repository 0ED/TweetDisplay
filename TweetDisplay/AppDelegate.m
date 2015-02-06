//
//  AppDelegate.m
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/07.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    twitter = [[TwitterController alloc] init];
    DisplayOnDesktop *displayOnDesktop = [[DisplayOnDesktop alloc] init];
    [twitter setDisplayOnDesktop:displayOnDesktop];
}
- (IBAction)longinButton:(id)sender
{
    /* コンシューマキーを取得する */
    NSString *currentDirectoryPath = [[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent];
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:currentDirectoryPath];
    NSString *keyFilePath = [currentDirectoryPath stringByAppendingString:@"/TweetDisplay.app/Contents/Resources/KeyChain.txt"];
    
    NSFileHandle *keyFile = [NSFileHandle fileHandleForReadingAtPath:keyFilePath]; //ファイルオブジェクト
    NSData *char_data;
    /*
    while ((char_data = [keyFile readDataOfLength:1])) {
        NSString *a_str = [[NSString alloc]initWithData:char_data encoding:NSUTF8StringEncoding];
        NSLog(@"Here %@",a_str);
    }
    */
    
    
    
    [twitter loginTwitterConsumerKey:[self.consumerKey stringValue] consumerSecret:[self.consumerSecret stringValue] accsessToken:[self.accessToken stringValue]                                                                                 accessTokenSecret:[self.accessTokenSecret stringValue] ];
    
}




- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
- (void) getTimeLine:(NSTimer*)timer{
    [twitter getTimeLine];
}
- (IBAction)startButton:(id)sender {
    [twitter getTimeLine];
    NSTimer *tm =
    [NSTimer
     scheduledTimerWithTimeInterval:65.0f
     target:self
     selector:@selector(getTimeLine:)
     userInfo:nil
     repeats:YES
     ];
}
@end
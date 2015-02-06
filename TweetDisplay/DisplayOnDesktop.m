//
//  DisplayOnDesktop.m
//  TweetDisplay
//
//  Created by yamamasudaisuke on 2015/01/09.
//  Copyright (c) 2015年 CSE. All rights reserved.
//

#import "DisplayOnDesktop.h"

@implementation DisplayOnDesktop
- (void)doTimerDisplayTweetText:(NSTimer *)timer{
    NSString *text = [(NSDictionary *)timer.userInfo objectForKey:@"text"];
    NSString *imageURL = [(NSDictionary *)timer.userInfo objectForKey:@"imageURL"];
    [self displayTweetText:text imageURL:imageURL];

}
-(void) displayTweetText:(NSString *) str imageURL:(NSString *) url{
    NSRect screenRect = [[NSScreen mainScreen] frame];
    
    NSFont* font = [NSFont fontWithName:@"Hiragino Kaku Gothic Pro W3" size:(rand() % 50 + 30)];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    NSSize       strSize     = [str sizeWithAttributes:attributes];
    double origin_y = ((screenRect.size.height)*2/3 - strSize.height) *  rand() / RAND_MAX;
    CGRect rect     = CGRectMake(screenRect.size.width, (screenRect.size.height)/3 + origin_y,
                                 strSize.width + 20.0 + strSize.height, strSize.height + 10.0);
    
    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSRectFromCGRect(rect)
                                                   styleMask:NSBorderlessWindowMask
                                                     backing:NSBackingStoreRetained
                                                       defer:YES];
    [window setIgnoresMouseEvents:YES];
    [window setBackgroundColor:[NSColor clearColor]];
    [window setOpaque:NO];
    [window setLevel:NSScreenSaverWindowLevel];
    [window orderFront:nil];
    
    NSText  *text   = [[NSText alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0.0 + window.frame.size.height, -20.0, rect.size.width, rect.size.height))];
    NSArray *colors = [NSArray arrayWithObjects:
                       [NSColor redColor],       [NSColor greenColor],    [NSColor blueColor],
                       [NSColor cyanColor],      [NSColor magentaColor],  [NSColor yellowColor],
                       [NSColor brownColor],     [NSColor orangeColor],   [NSColor purpleColor],
                       [NSColor blackColor],     [NSColor whiteColor],    nil];
    [text setTextColor:[colors objectAtIndex:rand() % [colors count]]];
    [text setString:str];
    [text setFont:font];
    [text setBackgroundColor:[NSColor clearColor]];
    [[window contentView] addSubview:text];
    
    NSImage *image = [[NSImage alloc] initByReferencingURL:[[NSURL alloc] initWithString:url]];
    NSImageView *imageView = [[NSImageView alloc] init];
    [imageView setImage:image];
    CGRect imageRect     = CGRectMake(0.0, 0.0, window.frame.size.height, window.frame.size.height);
    [imageView setFrame:imageRect];
    
    [[window contentView] addSubview:imageView];
    
    NSRect srcViewFrame = NSRectFromCGRect(rect);
    NSRect desViewFrame = srcViewFrame;
    desViewFrame.origin.x = - rect.size.width;
    NSDictionary* viewDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              window, NSViewAnimationTargetKey,
                              [NSValue valueWithRect:srcViewFrame], NSViewAnimationStartFrameKey,
                              [NSValue valueWithRect:desViewFrame], NSViewAnimationEndFrameKey,
                              nil];
    NSViewAnimation *animation =
    [[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObjects:viewDict, nil]];
    
    [animation setAnimationBlockingMode:ANIMATION_MODE];
    [animation setAnimationCurve:NSAnimationLinear];
    [animation setDuration:screenRect.size.width / 100.0];
    [animation setDelegate:self];
    [animation startAnimation];
}

@end

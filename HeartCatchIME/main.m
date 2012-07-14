//
//  main.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

IMKServer *server;

int main(int argc, char *argv[])
{
//    return NSApplicationMain(argc, (const char **)argv);
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *connectionID = @"HeartCatchIME_Connection";
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    server = [[IMKServer alloc] initWithName:connectionID bundleIdentifier:bundleID];
    
    [NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
    
    [[NSApplication sharedApplication] run];
    
    [server release];
    [pool release];
    return 0;
    
}

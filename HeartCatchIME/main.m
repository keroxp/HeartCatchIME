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
IMKCandidates *candidates;

int main(int argc, char *argv[])
{
//    return NSApplicationMain(argc, (const char **)argv);
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    // Connection ID と Bundle IDを指定
    NSString *connectionID = @"HeartCatchIME_Connection";
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    
    // IMKserverを構築
    server = [[IMKServer alloc] initWithName:connectionID bundleIdentifier:bundleID];
    
    // Nibを明示的に読み込む
    [NSBundle loadNibNamed:@"MainMenu" owner:[NSApplication sharedApplication]];
    
    candidates = [[IMKCandidates alloc] initWithServer:server panelType:kIMKSingleColumnScrollingCandidatePanel];
    
    // Main Roopへ
    [[NSApplication sharedApplication] run];
    
    [server release];
    [candidates release];
    [pool release];
    return 0;
    
}

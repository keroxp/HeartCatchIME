//
//  HCAppDelegate.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCAppDelegate.h"

@implementation HCAppDelegate
@synthesize convertController;
@synthesize candidatesController;

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (HCConvertController *)convertController
{
    return convertController;
}

- (HCCandidatesController *)candidatesController
{
    return candidatesController;
}

@end

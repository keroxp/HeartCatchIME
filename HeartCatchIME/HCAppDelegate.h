//
//  HCAppDelegate.h
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HCConvertController.h"
#import "HCCandidatesController.h"

@interface HCAppDelegate : NSObject <NSApplicationDelegate>
@property (readonly,assign) IBOutlet HCConvertController *convertController;
@property (readonly,assign) IBOutlet HCCandidatesController *candidatesController;

- (HCConvertController*)convertController;
- (HCCandidatesController *)candidatesController;

@end

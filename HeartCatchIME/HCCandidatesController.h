//
//  HCCandidatesController.h
//  HeartCatchIME
//
//  Created by  on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCandidatesController : NSObject <NSTableViewDelegate, NSTableViewDataSource>

@property (assign) IBOutlet NSPanel *panel;
@property (assign) IBOutlet NSScrollView *scrollView;
@property (assign) IBOutlet NSTableView *tableView;

@property (nonatomic, retain) NSArray *candidates;

@end

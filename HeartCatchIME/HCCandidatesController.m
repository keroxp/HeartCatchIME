//
//  HCCandidatesController.m
//  HeartCatchIME
//
//  Created by  on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCCandidatesController.h"
#define kIndexCellID @"IndexCell"
#define kCandidateCellID @"CandidateCell"
#define kAnnotationCellID @"AnnotationCell"

@implementation HCCandidatesController

@synthesize candidates = _candidates;

@synthesize panel = _panel;
@synthesize scrollView = _scrollView;
@synthesize tableView = _tableView;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [_panel setTitle:@"Candidates"];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 9;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if ([[tableColumn identifier] isEqualToString:kIndexCellID]) {
        return [NSString stringWithFormat:@"%i",row];
    }else if ([[tableColumn identifier] isEqualToString:kCandidateCellID]) {
        return @"ハートキャッチ！";
    }else if ([[tableColumn identifier] isEqualToString:kAnnotationCellID]) {
        return @"anot";
    };
    return nil;
}

- (void)setCandidates:(NSArray *)candidates
{
    if (candidates != _candidates) {
        [_candidates release];
        _candidates = [candidates retain];
    }
    [self.tableView reloadData];
}

- (NSArray *)candidates
{
    return _candidates;
}

@end

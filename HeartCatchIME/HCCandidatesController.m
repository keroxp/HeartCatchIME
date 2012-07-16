//
//  HCCandidatesController.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCCandidatesController.h"
#define kIndexCellID @"IndexColumn"
#define kCandidateCellID @"CandidateColumn"
#define kAnnotationCellID @"AnnotationColumn"

@implementation HCCandidatesController

@synthesize candidates = _candidates;
@synthesize panel = _panel;
@synthesize scrollView = _scrollView;
@synthesize tableView = _tableView;

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [_panel setTitle:@"Candidates"];
    [_panel setFloatingPanel:YES];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
}

- (void)showPanelOnClient:(id)sender
{
    NSRect rect = [sender firstRectForCharacterRange:NSMakeRange(0,0)];
    NSLog(@"origin is : %f , %f , sise is : %f , %f",rect.origin.x, rect.origin.y ,rect.size.width, rect.size.height); 
    NSPoint point = NSMakePoint(rect.origin.x, rect.origin.y - _panel.frame.size.height - 23.0f);
    [_panel setFrameOrigin:point];
    [_panel setIsVisible:YES];
    NSLog(@"showed panel");
}

- (void)hidePanel
{
    [_panel setIsVisible:NO];
}

- (void)selectRowAtIndex:(NSInteger)index
{
    [[_tableView rowViewAtRow:0 makeIfNecessary:NO] setSelected:YES];
}

#pragma mark - TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (_candidates) {
        return [_candidates count];
    }
    return 0;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
//    NSLog(@"reload table");
    if ([[tableColumn identifier] isEqualToString:kIndexCellID]) {
        return [NSString stringWithFormat:@"%i",row];
    }else if ([[tableColumn identifier] isEqualToString:kCandidateCellID]) {
        return [_candidates objectAtIndex:row];
    }else if ([[tableColumn identifier] isEqualToString:kAnnotationCellID]) {
        return @"あのて";
    }
    
    NSLog(@"invalid column id : %@ for table view : %@",[tableColumn identifier], tableView);
    return @"undefined";
}

#pragma mark - Candidates

- (void)setCandidates:(NSArray *)candidates
{
    NSLog(@"setCandidates : %@",candidates);
    if (candidates != _candidates) {
        [_candidates release];
        _candidates = [candidates retain];
    }
    [_tableView reloadData];
}

- (NSArray *)candidates
{
    return _candidates;
}

@end

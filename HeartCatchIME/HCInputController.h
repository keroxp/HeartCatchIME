//
//  HCInputController.h
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>
#import "HCConvertController.h"
#import "HCCandidatesController.h"

@interface HCInputController : IMKInputController
{
    HCConvertController *_convertController;
    HCCandidatesController *_candidatesController;
    NSMutableString *_composedBuffer;
    NSMutableString *_originalBuffer;
    NSMutableString *_hiraRomaBuffer;
    NSInteger _insertionIndex;
    NSInteger _candidatesIndex;
    BOOL _didConvert;
    BOOL _didConvertRomaToHira;
    id _currentClient;    
}

// クライアントからのイベントハンドラ
- (BOOL)inputText:(NSString *)string client:(id)sender;
- (BOOL)didCommandBySelector:(SEL)aSelector client:(id)sender;

// 変換処理
- (void)commitComposition:(id)sender;
- (BOOL)convert:(NSString*)trigger client:(id)sender;

// モードマネジメント
- (void)setValue:(id)value forTag:(long)tag client:(id)sender;

// バッファマネジメント
- (NSMutableString *)composedBuffer;
- (void)setComposedBuffer:(NSString *)composedBuffer;
- (NSMutableString *)originalBuffer;
- (void)appendToOriginalBuffer:(NSString*)string client:(id)sender;
- (void)setOriginalBuffer:(NSString *)originalBuffer;

// NSResponderのアクション
- (void)insertNewLine:(id)sender;
- (void)insertTab:(id)sender;
- (void)deleteBackward:(id)sender;

// 候補マネジメント
- (NSArray *)candidates:(id)sender;
- (void)candidateSelected:(NSAttributedString *)candidateString;
- (void)candidateSelectionChanged:(NSAttributedString *)candidateString;

// コントローラ
- (HCConvertController*)convertController;
- (HCCandidatesController*)candidatesController;

@end

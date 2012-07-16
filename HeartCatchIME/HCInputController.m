//
//  HCInputController.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCInputController.h"

typedef enum{
    HCNumberKeyCode1 = 18,
    HCNumberKeyCode2 = 19,
    HCNumberKeyCode3 = 20,
    HCNumberKeyCode4 = 21,
    HCNumberKeyCode5 = 23,
    HCNumberKeyCode6 = 22,
    HCNumberKeyCode7 = 26,
    HCNumberKeyCode8 = 28,
    HCNumberKeyCode9 = 25
}HCNumberKeyCode;

@implementation HCInputController

#pragma mark- IMKServerInput Informal Protocols

// アクティブなクライアントで文字入力があった場合、その文字を受け取る
- (BOOL)inputText:(NSString *)string client:(id)sender 
{
    // 入力されたのは英字・数字・記号のどれかか？
    NSCharacterSet *alphaNumerics = [NSCharacterSet alphanumericCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    BOOL isAlphaNumeric = [scanner scanCharactersFromSet:alphaNumerics intoString:nil];
    NSLog(@"%@ is AlphaNumeric ? %i",string,isAlphaNumeric);
    if(isAlphaNumeric){
        [self appendToOriginalBuffer:string client:sender];
        return YES;
    }else {
        return [self convert:string client:sender];
    }
    return NO;
}

// NSResponderのアクションがアクティブクライアントで実行された際に呼ばれる
- (BOOL)didCommandBySelector:(SEL)aSelector client:(id)sender
{
    // セレクタがこのクラスに実装されているか
    if ([self respondsToSelector:aSelector]) {
        NSString *bufferedText = [self originalBuffer];
        // オリジナルバッファがあるか <=> 入力セッション中か
        if (bufferedText != nil && bufferedText.length > 0) {
            if (aSelector == @selector(insertNewline:) || 
                aSelector == @selector(deleteBackward:)|| 
                aSelector == @selector(insertTab:)) {
                [self performSelector:aSelector withObject:sender];
                return YES;
            }
        }
    }
    return NO;  
}


#pragma mark - NSResponder

// 改行したら確定
- (void)insertNewLine:(id)sender
{
    [self commitComposition:sender];
}

// デリートキーが押された場合、オリジナルバッファから一文字削除してクライアントの文字列を更新
- (void)deleteBackward:(id)sender
{
    NSMutableString *originalText = [self originalBuffer];
    NSString *convertedString;
    
    if (_insertionIndex > 0 && _insertionIndex <= originalText.length) {
        _insertionIndex--;
        [originalText deleteCharactersInRange:NSMakeRange(_insertionIndex, 1)];
        convertedString = [[[NSApp delegate] converController] convert:originalText];
        [self setComposedBuffer:convertedString];
        [sender setMarkedText:convertedString selectionRange:NSMakeRange(_insertionIndex, 0) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    }
}

-(void)insertTab:(id)sender 
{
    // なんかやる
}

#pragma mark - Others

- (void)awakeFromNib
{
    NSLog(@"awake from nib");
    [super awakeFromNib];
}

- (void)dealloc
{
    [_composedBuffer release];
    [_originalBuffer release];
    [super dealloc];
}

#pragma mark - Conversion

- (BOOL)convert:(NSString*)triggerKey client:(id)sender
{
    NSString *originalText = [self originalBuffer];
    NSString *convertedString = [self composedBuffer];
    
    if (_didConvert && convertedString && convertedString.length > 0) {
        extern IMKCandidates *candidates;
        if (candidates) {
            _currentClient = sender;
//            [candidates updateCandidates];
//            [candidates show:kIMKLocateCandidatesBelowHint];
            [[[NSApp delegate] candidatesController] setCandidates:[self candidates:self]]; 
            
        }else {
            NSString *completeString = [convertedString stringByAppendingString:triggerKey];
            [sender insertText:completeString replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
            [self setComposedBuffer:@""];
            [self setOriginalBuffer:@""];
        }
    }else if (originalText && originalText.length > 0) {
        convertedString = [[[NSApp delegate] convertController] convert:originalText];
        [self setComposedBuffer:convertedString];
        
        if ([triggerKey isEqualToString:@" " ] || [triggerKey isEqualToString:@"　"]) {
            [sender setMarkedText:convertedString selectionRange:NSMakeRange(_insertionIndex, 0) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
            _didConvert = YES;
        }else {
            [self commitComposition:sender];
            [sender insertText:triggerKey replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
        }
        return YES;
    }
    return NO;
}

// 入力のプロセスが終わったときに呼ばれる
- (void)commitComposition:(id)sender
{
    NSString *text = [self composedBuffer];
    
    if (text == nil || text.length == 0) {
        text = [self originalBuffer];
    }
    
    [sender insertText:text replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
    [self setComposedBuffer:@""];
    [self setOriginalBuffer:@""];
    _insertionIndex = 0;
    _didConvert = NO;
}

#pragma mark - Mode

// ユーザが入力メニューから入力モードを変更したときに呼ばれる
- (void)setValue:(id)value forTag:(long)tag client:(id)sender
{
    ;
}

#pragma mark - Candidates

// 候補のデータソース
- (NSArray *)candidates:(id)sender
{
    NSString *originalString = [self originalBuffer];
    return [[[NSApp delegate] convertController] candidates:originalString];
}

// 候補の一つが選択されたときに呼ばれる
- (void)candidateSelected:(NSAttributedString *)candidateString
{
    [self setComposedBuffer:[candidateString string]];
    [self commitComposition:_currentClient];
}

// 候補の選択が変化したときに呼ばれる
- (void)candidateSelectionChanged:(NSAttributedString *)candidateString
{
    NSLog(@"Candidates changesd to : %@",candidateString);
}
#pragma mark - Buffer

- (NSMutableString *)composedBuffer
{
    if ( _composedBuffer == nil) {
        _composedBuffer = [[NSMutableString alloc] init];
    }
    return _composedBuffer;
}

- (void)setComposedBuffer:(NSString *)composedBuffer
{
    [[self composedBuffer] setString:composedBuffer];
}

- (NSMutableString *)originalBuffer
{
    if (_originalBuffer == nil) {
        _originalBuffer = [[NSMutableString alloc] init];
    }
    return  _originalBuffer;
}

// 現在のバッファに文字を追加
- (void)appendToOriginalBuffer:(NSString*)string client:(id)sender
{
    NSMutableString *buffer = [self originalBuffer];
    [buffer appendString:string];
    _insertionIndex++;
    [sender setMarkedText:buffer selectionRange:NSMakeRange(0, buffer.length) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
}

- (void)setOriginalBuffer:(NSString *)originalBuffer
{
    [[self originalBuffer] setString:originalBuffer];
}

#pragma mark - Controller

- (HCConvertController *)convertController
{
    if (_convertController == nil) {
        _convertController = (HCConvertController*)[[NSApp delegate] convertController];
    }
    return _convertController;
}

- (HCCandidatesController*)candiatesController
{
    if (_candidatesController == nil) {
        _candidatesController = (HCCandidatesController*)[[NSApp delegate] candiatesController];
    }
    return _candidatesController;
}

// ↑に加えて、キーコード、モディファイアフラグ（Shiftとか）を受け取る
//- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender
//{
//    NSLog(@"input string : %@, keyCode : %ld, flags : %lu",string,keyCode,flags);
//    BOOL inputHandled = NO;
//    NSScanner *scanner = [NSScanner scannerWithString:string];
//    BOOL isAlphaNumeric = [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:nil];
//    extern IMKCandidates *candidates;
//    
//    NSLog(@"is alphanumeric ? %@",isAlphaNumeric);
//    
//    // 候補ビューが表示されているか
//    if ([candidates isVisible]){
//        if(isAlphaNumeric) {
//            // 確定＆入力処理 
//            [self commitComposition:sender];
//            [self setOriginalBuffer:string];
//        }else if(keyCode == SpaceKeyCode || keyCode == TabKeyCode) {
//            // 候補移動処理
//            // やらなくていいっぽい
//        }else if (keyCode == UpArrowKeyCode || keyCode == DownArrowKeyCode || keyCode == RightArrowKeyCode || keyCode == LeftArrowKeyCode) {
//            // 候補選択処理
//            // やらなくていいっぽい
//        }else if (keyCode == ReturnKeyCode) {
//            // 候補確定処理 
//            //　やらなくていいっぽい
//        }else {
//            NSLog(@"Undefined Key code : %@, string : %@",keyCode,string);
//        }
//        inputHandled = YES;
//    }else{
//        // 変換処理 
//        if (keyCode == SpaceKeyCode) {
//            inputHandled = [self convert:string client:sender];
//        }else {
//            [self originalBufferAppend:string client:sender]; 
//            inputHandled = YES;
//        }
//    }
//    return inputHandled;
//}

@end

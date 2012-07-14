//
//  HCInputController.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/14.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCInputController.h"

@implementation HCInputController

- (BOOL)inputText:(NSString *)string client:(id)sender
{
    // 英字キーの文字セット
    NSCharacterSet *latinCharset = [NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnm"];
    // 文字スキャナ
    NSScanner *scanner = [NSScanner scannerWithString:string];
    // 入力された文字は英字か？
    BOOL isLatinChar = [scanner scanCharactersFromSet:latinCharset intoString:nil];
    if (isLatinChar) {
        [self commitComposition:sender];
        return YES; 
    }
    return NO;
}

- (void)commitComposition:(id)sender
{
    [sender insertText:@"＼ハートキャッチ！／" replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
}

@end

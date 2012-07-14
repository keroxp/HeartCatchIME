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
    NSCharacterSet *latinCharset = [NSCharacterSet characterSetWithCharactersInString:@"qwertyuiopasdfghjklzxcvbnm"];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    BOOL isLatinChar = [scanner scanCharactersFromSet:latinCharset intoString:nil];
    if (isLatinChar) {
        return YES; 
    }
    return NO;
}

- (void)commitComposition:(id)sender
{
    
}

@end

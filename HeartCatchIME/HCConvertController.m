//
//  HCConvertController.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCConvertController.h"

@implementation HCConvertController

- (NSString *)convert:(NSString *)string
{
//    return [NSString stringWithFormat:@"ハートキャッチ %@！",string];
    return [self convert:string transformStyle:HCTransformStyleLatinHira];
}

- (NSString *)convert:(NSString *)string transformStyle:(HCTransformStyle)style
{
    NSMutableString *convertedString = [string mutableCopy];
    if (convertedString) {
        switch (style) {
            case HCTransformStyleFullHalf:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HCTransformStyleLatinHira:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformLatinHiragana, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HCTransformStyleLatinKana:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformLatinKatakana, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HCTransformStyleKanaHira:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformHiraganaKatakana, false)) {
                    return [convertedString autorelease];
                }
                break;
            default:
                break;
        }
    }
    return string;
}

- (NSArray *)candidates:(NSString *)string
{
    NSMutableArray *candidates = [NSMutableArray array];
    [candidates addObject:[self convert:string]];
    for (int i = 0 ; i < 4 ; i++) {
        [candidates addObject:[self convert:string transformStyle:i]];
    }
    return candidates;
}

@end

//
//  HCConvertController.m
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import "HCConvertController.h"

@implementation HCConvertController

+ (NSString *)convert:(NSString *)string
{
    return [NSString stringWithFormat:@"ハートキャッチ %@！",string];
}

+ (NSString *)convert:(NSString *)string transformStyle:(HCTransformStyle)style
{
    NSMutableString *convertedString = [string mutableCopy];
    if (convertedString) {
        switch (style) {
            case HITransformStyleFullHalf:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HITransformStyleLatinHira:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformLatinHiragana, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HITransformStyleLatinKana:
                if (CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformLatinKatakana, false)) {
                    return [convertedString autorelease];
                }
                break;
            case HITransformStyleKanaHira:
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

@end

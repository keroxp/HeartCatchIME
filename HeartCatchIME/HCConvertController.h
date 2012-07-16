//
//  HCConvertController.h
//  HeartCatchIME
//
//  Created by 桜井 雄介 on 12/07/16.
//  Copyright (c) 2012年 Kaeru Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HCTransformStyleFullHalf = 0,
    HCTransformStyleLatinHira,
    HCTransformStyleLatinKana,
    HCTransformStyleKanaHira
}HCTransformStyle;

@interface HCConvertController : NSObject

- (NSString*)convert:(NSString*)string;
- (NSString*)convert:(NSString*)string transformStyle:(HCTransformStyle)style;
- (NSArray*)candidates:(NSString*)string;

@end

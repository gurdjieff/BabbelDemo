//
//  LanguageData.h
//  BabbelCodeTest
//
//  Created by daiyuzhang on 17/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageData : NSObject
@property NSUInteger index;


+(LanguageData *)shareLanguageData;
-(NSString *)getDisplayedContent;
-(BOOL)judgeAnwere:(BOOL)choice;
-(NSString *)getAnRandomAnswer;
-(NSInteger)getCounter;
-(BOOL)isTestFinished;
-(NSMutableArray *)languageArray;


@end

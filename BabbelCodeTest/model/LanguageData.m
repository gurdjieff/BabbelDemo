//
//  LanguageData.m
//  BabbelCodeTest
//
//  Created by daiyuzhang on 17/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "LanguageData.h"
@interface LanguageData()
{
    BOOL _currentAnswer;
    NSMutableArray * _languageArray;
    NSUInteger _counter;
    NSUInteger _index;
}
@end


@implementation LanguageData

#pragma mark -inner method

- (id)init
{
    if ((self = [super init])) {
        _languageArray = [[NSMutableArray alloc] init];
        _counter = 0;
        [self extractData];
    }
    return self;
}

- (void)extractData
{
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"json"];
    if (filePath) {
        NSData * data = [NSData dataWithContentsOfFile:filePath];
        NSError * error;
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        [_languageArray setArray:array];
    }
}

#pragma mark -outer method
+ (LanguageData *)shareLanguageData
{
    static LanguageData * shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

-(NSString *)getDisplayedContent
{
    return [_languageArray objectAtIndex:_index][@"text_eng"];
}

-(NSMutableArray *)languageArray
{
    return _languageArray;
}

-(BOOL)isTestFinished
{
    return _index >= [_languageArray count];
}


-(BOOL)judgeAnwere:(BOOL)choice
{
    _index++;
    if (_currentAnswer == choice) {
        _counter++;
        return YES;
    } else {
        return NO;
    }
}

-(NSInteger)getCounter
{
    return _counter;
}

-(NSString *)getAnRandomAnswer
{
    int random = rand();
    if (random % 2 == 0) {
        _currentAnswer = YES;
        return [[_languageArray objectAtIndex:_index] objectForKey:@"text_spa"];
    } else {
        _currentAnswer = NO;
        random = rand();
        random = random % [_languageArray count];
        return [[_languageArray objectAtIndex:random] objectForKey:@"text_spa"];
    }
}

@end

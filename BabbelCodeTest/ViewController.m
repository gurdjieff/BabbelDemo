//
//  ViewController.m
//  BabbelCodeTest
//
//  Created by daiyuzhang on 17/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "ViewController.h"
#import "LanguageData.h"
#define speed 0.02

@interface ViewController ()
{
    float screenHeight;
    BOOL gameOver;
    CGRect translatedOriginFrame;
}

@end

@implementation ViewController

-(IBAction)clickCorrect:(id)sender
{
    [[LanguageData shareLanguageData] judgeAnwere:YES];
    [self setDisplayedLabelContent];
}

-(IBAction)clickWrong:(id)sender
{
    [[LanguageData shareLanguageData] judgeAnwere:NO];
    [self setDisplayedLabelContent];
}

-(void)wordMovement
{
    if (gameOver) {
        return;
    }
    if (_translatedLabel.alpha == 1.0) {
        CGPoint center = _translatedLabel.center;
        if (center.y + _translatedLabel.frame.size.height/2 >= screenHeight) {
            [LanguageData shareLanguageData].index += 1;
            [self setDisplayedLabelContent];
        } else {
            _translatedLabel.center = CGPointMake(center.x, center.y+2.0);
        }
    }
    [self performSelector:@selector(wordMovement) withObject:nil afterDelay:speed];
}

-(void)resetCounter
{
    NSInteger count = [[LanguageData shareLanguageData] getCounter];
    _counterLabel.text = [NSString stringWithFormat:@"scores:%ld", (long)count];
}

-(void)setDisplayedLabelContent
{
    if ([[LanguageData shareLanguageData] isTestFinished]) {
        int count = (int)[[LanguageData shareLanguageData] getCounter];
        _commentLabel.hidden = NO;
        _commentLabel.text = [NSString stringWithFormat:@"%d answers are right in %lu questions", count, (unsigned long)[[[LanguageData shareLanguageData] languageArray] count]];
        _correctBtn.userInteractionEnabled = NO;
        _wrongBtn.userInteractionEnabled = NO;
        gameOver = YES;
        return;
    }
    _displayedLabel.text = [[LanguageData shareLanguageData] getDisplayedContent];
    [self resetCounter];
    [UIView animateWithDuration:0.12 animations:^{
        _translatedLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self setTranslatedLabelContentAndFrame];
    }];
}

-(void)setTranslatedLabelContentAndFrame
{
    _translatedLabel.frame = translatedOriginFrame;
    _translatedLabel.text = [[LanguageData shareLanguageData] getAnRandomAnswer];
    [UIView animateWithDuration:0.12 animations:^{
        _translatedLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setDisplayedLabelContent];
    [self setTranslatedLabelContentAndFrame];
    [self wordMovement];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = [[UIScreen mainScreen] bounds];
    screenHeight = frame.size.height;
    translatedOriginFrame = _translatedLabel.frame;
    _commentLabel.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

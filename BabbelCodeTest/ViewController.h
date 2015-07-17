//
//  ViewController.h
//  BabbelCodeTest
//
//  Created by daiyuzhang on 17/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong, nonatomic) IBOutlet UILabel * displayedLabel;
@property(strong, nonatomic) IBOutlet UILabel * translatedLabel;
@property(strong, nonatomic) IBOutlet UILabel * counterLabel;
@property(strong, nonatomic) IBOutlet UILabel * commentLabel;
@property(strong, nonatomic) IBOutlet UIButton * correctBtn;
@property(strong, nonatomic) IBOutlet UIButton * wrongBtn;

-(IBAction)clickCorrect:(id)sender;
-(IBAction)clickWrong:(id)sender;

@end


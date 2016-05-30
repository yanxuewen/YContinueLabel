//
//  ViewController.m
//  YContinueLabel
//
//  Created by 颜学文 on 16/5/29.
//  Copyright © 2016年 yxw. All rights reserved.
//

#import "ViewController.h"
#import "YContinueLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonA;

@property (weak, nonatomic) IBOutlet YContinueLabel *continueLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _continueLabel.continueType = YContinueTypeEaseInOut;
    
    [self testNumberFormatter];
    
}

- (void)testNumberFormatter{
    NSNumberFormatter *numberF = [NSNumberFormatter new];
    numberF.locale = [NSLocale localeWithLocaleIdentifier:@"ZH_CN"];
    //    numberF.formatWidth = 15;//15位输出,不足补 *
    NSNumber *number = @12345.6789;
    numberF.numberStyle = NSNumberFormatterDecimalStyle;//12,345.679
    NSLog(@"DecimalStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterCurrencyStyle;//加钱币符号,中国:￥
    NSLog(@"CurrencyStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterPercentStyle;//带百分百
    NSLog(@"PercentStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterScientificStyle;//科学计数
    NSLog(@"ScientificStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterSpellOutStyle;//全拼,中国是 一万两千...
    NSLog(@"SpellOutStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterOrdinalStyle;//序号,第...,四舍五入
    NSLog(@"OrdinalStyle: %@",[numberF stringFromNumber:number]);
    numberF.numberStyle = NSNumberFormatterCurrencyISOCodeStyle;
    NSLog(@"CurrencyISOCodeStyle: %@",[numberF stringFromNumber:number]);
    
    numberF.numberStyle = NSNumberFormatterDecimalStyle;
    
    numberF.minimumIntegerDigits = 1;
    numberF.minimumFractionDigits = 0;
    numberF.maximumFractionDigits = 3;
    numberF.positiveSuffix = @" AA";//正数后缀
    numberF.negativePrefix = @"BB -";//负数前缀,会替换 '-'号
    
    numberF.roundingMode = NSNumberFormatterRoundCeiling;
    NSLog(@"RoundCeiling: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundFloor;
    NSLog(@"RoundFloor: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundDown;
    NSLog(@"RoundDown: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundUp;
    NSLog(@"RoundUp: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundHalfEven;
    NSLog(@"RoundHalfEven: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundHalfDown;
    NSLog(@"RoundHalfDown: %@",[numberF stringFromNumber:number]);
    numberF.roundingMode = NSNumberFormatterRoundHalfUp;
    
    NSLog(@"RoundHalfUp: %@",[numberF stringFromNumber:@-1.0]);
}

- (IBAction)changeNumber:(id)sender {
    
    [_continueLabel updateNumber:_continueLabel.number+12344 completion:^{
        NSLog(@"completion");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

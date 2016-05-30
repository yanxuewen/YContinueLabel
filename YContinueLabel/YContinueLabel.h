//
//  YContinueLabel.h
//  YContinueLabel
//
//  Created by 颜学文 on 16/5/29.
//  Copyright © 2016年 yxw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YContinueType) {
    YContinueTypeLinear,
    YContinueTypeEaseIn,
    YContinueTypeEaseOut,
    YContinueTypeEaseInOut,
};

typedef void(^CompletionBlock)(void);

@interface YContinueLabel : UILabel<NSCoding>
NS_ASSUME_NONNULL_BEGIN
@property (assign,nonatomic)NSUInteger frameInterval;

@property (assign,nonatomic) double number;

@property (assign,nonatomic) YContinueType continueType;    //define:linear

@property (assign,nonatomic) BOOL updateFromZero;   //每次动画从零开始,define:NO,从原数据开始

@property (nonatomic,strong) NSNumberFormatter *numberFormatter;

- (void)updateNumber:(double)number completion:(nullable CompletionBlock)block;

@end
NS_ASSUME_NONNULL_END



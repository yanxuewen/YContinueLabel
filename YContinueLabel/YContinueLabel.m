//
//  YContinueLabel.m
//  YContinueLabel
//
//  Created by yxw on 16/5/29.
//  Copyright © 2016年 yxw. All rights reserved.
//

#import "YContinueLabel.h"

static NSTimeInterval kAnimationTime = 2.0;

@interface YContinueLabel ()

@property (strong,nonatomic) CADisplayLink *displayLink;

@property (assign,nonatomic) NSTimeInterval startMediaTime;
@property (assign,nonatomic) NSTimeInterval endMediaTime;

@property (assign,nonatomic) double startNumber;
@property (assign,nonatomic) double endNumber;

@property (assign,nonatomic) double easeRate;

@property (assign,nonatomic) double progress;

@property (copy,nonatomic) CompletionBlock comletionBlock;

@end

@implementation YContinueLabel



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLabel];
    }
    return self;
}


- (void)initLabel{
    _continueType = YContinueTypeLinear;
    _easeRate = 3.0;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateNumber)];
    _displayLink.frameInterval = 3;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [_displayLink setPaused:YES];
    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    _numberFormatter.maximumFractionDigits = 1;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [super encodeWithCoder:aCoder];
    [aCoder encodeDouble:_number forKey:@"number"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self initLabel];
    _number = [aDecoder decodeDoubleForKey:@"number"];
    return self;
}

- (void)setFrameInterval:(NSUInteger)frameInterval{
    _displayLink.frameInterval = frameInterval;
}

- (NSUInteger)frameInterval{
    return _displayLink.frameInterval;
}

- (void)setNumber:(double)number{
    _number = number;
    self.text = [_numberFormatter stringFromNumber:@(_number)];
}


- (void)updateNumber:(double)number completion:(CompletionBlock)block{
    _comletionBlock = block;
    _startNumber = _updateFromZero ? 0 : _number;
    _endNumber = number;
    if (_startNumber != _endNumber) {
        [_displayLink setPaused:NO];
        _startMediaTime = CACurrentMediaTime();
        _endMediaTime = _startMediaTime+kAnimationTime;
    }
    else{
        self.number = number;
        if (_comletionBlock) {
            _comletionBlock();
        }
    }
}

- (void)updateNumber{
    NSTimeInterval time = CACurrentMediaTime() - _startMediaTime;
    _progress = time/kAnimationTime;
    _number = [self rateWithProgress:_progress] * (_endNumber - _startNumber) + _startNumber;
    if ( _progress >= 1.0 ) {
        _number = _endNumber;
        [_displayLink setPaused:YES];
        if (_comletionBlock) {
            _comletionBlock();
        }
    }
    self.text = [_numberFormatter stringFromNumber:@(_number)];
}


- (double)rateWithProgress:(double)p{
    switch (_continueType) {
        case YContinueTypeLinear:
            return p;
            break;
        case YContinueTypeEaseIn:
            return powf(p, _easeRate);
            break;
        case YContinueTypeEaseOut:
            return 1.0-powf((1.0-p), _easeRate);
            break;
        case YContinueTypeEaseInOut:
        {
            int sign =1;
            int r = (int) _easeRate;
            if (r % 2 == 0)
                sign = -1;
            p *= 2;
            if (p < 1)
                return 0.5f * powf (p, _easeRate);
            else
                return sign*0.5f * (powf (p-2, _easeRate) + sign*2);
            break;
        }
        default:
            break;
    }
    return p;
}

- (void)dealloc{
    [_displayLink invalidate];
}

@end

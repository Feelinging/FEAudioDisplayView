//
//  FEAudioWaveView.m
//  FeelingView
//
//  Created by YamatoKira on 16/1/30.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAudioWaveView.h"

@interface FEAudioWaveView ()

@property (nonatomic, assign) CGFloat lastBeginX;

@end

@implementation FEAudioWaveView

- (instancetype)init {
    if (self = [super init]) {
        // 设置背景色，防止为nil是调用drawRect之后出现奇怪现象
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ref, self.waveColor.CGColor);
    
    CGContextSetLineWidth(ref, self.lineWidth);
    
    CGFloat waveH = self.power * self.bounds.size.height/2.f;
    
    CGFloat waveW = self.bounds.size.width / (3 + 10 * self.power);
    
    // 画正弦图
    self.lastBeginX = self.lastBeginX < 0?self.bounds.size.width:self.lastBeginX - 15.f;
    for(float x = self.lastBeginX; x < self.bounds.size.width + self.lastBeginX ; x++){
        CGFloat y = - sin(x/waveW*3.14)*waveH + self.bounds.size.height/2.f;
        if (x == self.lastBeginX) {
            CGContextMoveToPoint(ref, x - self.lastBeginX, y);
        }
        CGContextAddLineToPoint(ref,x - self.lastBeginX,y);
        CGContextStrokePath(ref);
        CGContextMoveToPoint(ref,x - self.lastBeginX, y);
    }
}

- (void)setPower:(CGFloat)power {
    _power = power;
    [self setNeedsDisplay];
}

@end

//
//  FEAudioWaveView.h
//  FeelingView
//
//  Created by YamatoKira on 16/1/30.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  音量波形图
 */
@interface FEAudioWaveView : UIView

/**
 *  0 ~ 1.0
 */
@property (nonatomic, assign) CGFloat power;

/**
 *  波形颜色
 */
@property (nonatomic, strong) UIColor *waveColor;

/**
 *  波形线条宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

@end

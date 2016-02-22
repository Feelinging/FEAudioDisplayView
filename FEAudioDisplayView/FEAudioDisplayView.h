//
//  FEAudioDisplay.h
//  FeelingView
//
//  Created by YamatoKira on 16/1/30.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEAudioWaveView.h"

@class FEAudioDisplayView;

/**
 *  音频视图的状态
 */
typedef NS_ENUM(NSUInteger, FEAudioDisplayViewState) {
    /**
     *  未播放
     */
    FEAudioDisplayViewStateNone = 0,
    /**
     *  正在播放
     */
    FEAudioDisplayViewStatePlaying = 1,
};

typedef void (^FEAudioDisplayViewTapBlock)(FEAudioDisplayView *, FEAudioDisplayViewState);

@interface FEAudioDisplayView : UIView

/**
 *  点击回调
 */
@property (nonatomic, copy) FEAudioDisplayViewTapBlock tapBlock;

/**
 *  是否适用默认布局
 */
@property (nonatomic, assign) BOOL useDefaultLayout;

#pragma mark initialize

/**
 *  构造方法
 *
 *  @param duration 总的时间
 */
+ (instancetype)audioViewWithDuration:(NSTimeInterval)duration;

#pragma mark getter
/**
 *  播放按钮
 */
- (UIButton *)playButton;

/**
 *  显示时间的Lable
 */
- (UILabel *)timeLabel;

/**
 *  声浪view
 */
- (FEAudioWaveView *)waveView;

/**
 *  判断是否正在播放
 */
- (BOOL)isPlaying;

/**
 *  播放到过了多少时间
 */
- (NSTimeInterval)offsetTimeInterval;

/**
 *  总共的播放时间
 */
- (NSTimeInterval)totalTimeInterval;

#pragma mark control
/**
 *  播放
 */
- (void)play;

/**
 *  设置播放过了的偏移时间
 */
- (void)setOffsetTimeInterval:(NSTimeInterval)offset;

/**
 *  设置播放按钮的图片
 *
 *  @param image 图片
 *  @param state 状态
 */
- (void)setPlayImage:(UIImage *)image forState:(FEAudioDisplayViewState)state;

/**
 *  停止播放
 */
- (void)stop;

/**
 *  设置播放总时长
 */
- (void)setTotalTimeInterval:(NSTimeInterval)totalTimeInterval;

@end

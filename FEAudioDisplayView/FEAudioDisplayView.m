//
//  FEAudioDisplay.m
//  FeelingView
//
//  Created by YamatoKira on 16/1/30.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "FEAudioDisplayView.h"

@interface FEAudioDisplayView ()

// data
@property (nonatomic, assign) FEAudioDisplayViewState state;

@property (nonatomic, assign) NSTimeInterval offsetTimeInterval;

@property (nonatomic, assign) NSTimeInterval totalTimeInterval;

// subViews
@property (nonatomic, strong) FEAudioWaveView *waveView;

@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation FEAudioDisplayView

#pragma mark initialize
+ (instancetype)audioViewWithDuration:(NSTimeInterval)duration {
    FEAudioDisplayView *obj = [[self alloc] initWithDuration:duration];
    return obj;
}

- (instancetype)initWithDuration:(NSTimeInterval)duration {
    if (self = [super init]) {
        [self baseInit];
        _totalTimeInterval = duration;
    }
    return self;
}

- (void)baseInit {
    // clipsToBounds
    self.clipsToBounds = YES;
    
    _useDefaultLayout = YES;
    
    // waveView
    _waveView = [[FEAudioWaveView alloc] init];
    _waveView.waveColor = [UIColor whiteColor];
    _waveView.lineWidth = 1.5f;
    _waveView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_waveView];
    
    // palyButton
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_playButton];
    
    // timeLabel
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.font = [UIFont systemFontOfSize:13.f];
    _timeLabel.backgroundColor = [UIColor whiteColor];

    [self addSubview:_timeLabel];
}

#pragma mark public method
- (void)play {
    // state
    self.state = FEAudioDisplayViewStatePlaying;
}

- (BOOL)isPlaying {
    if (self.state == FEAudioDisplayViewStatePlaying) {
        return YES;
    }
    return NO;
}

- (void)stop {
    // state
    self.state = FEAudioDisplayViewStateNone;
}

- (void)setOffsetTimeInterval:(NSTimeInterval)offset power:(CGFloat)power {
    // update UI
    self.waveView.power = power;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.f",self.totalTimeInterval - offset];
}

- (void)setPlayImage:(UIImage *)image forState:(FEAudioDisplayViewState)state {
    switch (state) {
        case FEAudioDisplayViewStateNone:
            [self.playButton setImage:image forState:UIControlStateNormal];
            break;
        case FEAudioDisplayViewStatePlaying:
            [self.playButton setImage:image forState:UIControlStateSelected];
            break;
        default:
            break;
    }
}

#pragma mark setter&getter
- (void)setState:(FEAudioDisplayViewState)state {
    if (_state != state) {
        switch (state) {
            case FEAudioDisplayViewStateNone:
                self.playButton.selected = NO;
                break;
            case FEAudioDisplayViewStatePlaying:
                self.playButton.selected = YES;
                break;
            default:
                break;
        }
    }
    _state = state;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setNeedsLayout];
}

- (void)setUseDefaultLayout:(BOOL)useDefaultLayout {
    BOOL shouldRefreshLayout = NO;
    if (_useDefaultLayout != useDefaultLayout) {
        shouldRefreshLayout = YES;
    }
    _useDefaultLayout = useDefaultLayout;
    
    if (shouldRefreshLayout) {
        [self setNeedsLayout];
    }
}

#pragma mark override
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.tapBlock) {
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.tapBlock) {
        [self.nextResponder touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.tapBlock) {
        self.tapBlock(self, self.state);
    }
    else {
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.useDefaultLayout) {
        CGSize size = self.bounds.size;
        CGFloat boarder = 8.f;
        // 播放按钮
        CGFloat playY = (size.height - 44)/2.0;
        self.playButton.frame = CGRectMake(boarder, playY, 44, 44);
        
        // 时间
        CGFloat timeW = 60.f;
        CGFloat timeH = 20.f;
        CGFloat timeY = (size.height - timeH)/2.0;
        CGFloat timeX = size.width - boarder - timeW;
        self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
        
        // 波浪
        CGFloat waveX = CGRectGetMaxX(self.playButton.frame) - 1;
        CGFloat waveY = playY;
        CGFloat waveH = self.playButton.bounds.size.height;
        CGFloat waveW = MAX((size.width - 2*boarder - self.playButton.bounds.size.width - timeW + 2), 0);
        self.waveView.frame = CGRectMake(waveX, waveY, waveW, waveH);
    }
}

#pragma mark private method
- (void)playButtonClick {
    if (self.tapBlock) {
        self.tapBlock(self, self.state);
    }
}


@end

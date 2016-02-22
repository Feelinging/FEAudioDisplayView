//
//  ViewController.m
//  FEAudioDisplayView
//
//  Created by YamatoKira on 16/1/30.
//  Copyright © 2016年 feeling. All rights reserved.
//

#import "ViewController.h"
#import "FEAudioDisplayView.h"

@interface ViewController ()

@property (nonatomic, strong) FEAudioDisplayView *audioView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FEAudioDisplayView *audio = [FEAudioDisplayView audioViewWithDuration:10];
    audio.backgroundColor = [UIColor grayColor];
    audio.frame = CGRectMake(20, 20, 260, 60);
    [audio setPlayImage:[UIImage imageNamed:@"playvioce"] forState:FEAudioDisplayViewStateNone];
    [audio setPlayImage:[UIImage imageNamed:@"stopvioce"] forState:FEAudioDisplayViewStatePlaying];
    
    audio.tapBlock = ^(FEAudioDisplayView *audio, FEAudioDisplayViewState state) {
        switch (state) {
            case FEAudioDisplayViewStateNone:
                [audio play];
                break;
            case FEAudioDisplayViewStatePlaying:
                [audio stop];
            default:
                break;
        }
    };
    
    [self.view addSubview:audio];
    
    self.audioView = audio;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/20 target:self selector:@selector(updateWave) userInfo:nil repeats:YES];
}

- (void)updateWave {
    CGFloat power = arc4random_uniform(10)/10.0;
    self.audioView.waveView.power = power;
    [self.audioView setOffsetTimeInterval:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

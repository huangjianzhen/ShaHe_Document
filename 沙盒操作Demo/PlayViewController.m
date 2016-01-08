
//
//  PlayViewController.m
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import "PlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define VideoY 44          //视频Y值
#define VideoWidth  320    //视频宽度
#define VideoHeight 200    //视频高度

@interface PlayViewController()
{
    MPMoviePlayerViewController *playerViewController;
    MPMoviePlayerController *player;
    
    UIButton                *_playBtn; //播放按钮
    UIImageView             *_image;   //播放按钮图片
    UIImageView             *_thumbImgView; //抓取视频的图片
}

@end

@implementation PlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //重新初始化MPMoviePlayerController，否则获取视频的第一帧图片，会引起无法播放的bug。
    NSString *path = NSHomeDirectory();
    
    
    NSString *fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/2/%@",self.videoUrl]];
    
    NSLog(@"fileDirectory:%@",fileDirectory);
    
    MPMoviePlayerController *pc = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:fileDirectory]];
    
    //获取视频的第一帧图片
    UIImage *videoThumbImg = [pc thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    _thumbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, VideoY, VideoWidth, VideoHeight)];
    [_thumbImgView setImage:videoThumbImg];
    [self.view addSubview:_thumbImgView];
    
    //设置播放按钮
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.backgroundColor = [UIColor clearColor];
    [_playBtn setFrame:CGRectMake(0.0f, VideoY, VideoWidth, VideoHeight)];
    [_playBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playBtn];
    
    //设置播放按钮的图片
    _image = [[UIImageView alloc]init];
    _image.frame = CGRectMake(140,120, 50, 50);
    [_image setImage:[UIImage imageNamed:@"2.png"]];
    [self.view addSubview:_image];
    
}


//播放视频
- (void) playVideo
{
    //根据视频播放状态，点击视频，出现播放按钮图片或者隐藏
    if (player && player.playbackState == MPMoviePlaybackStatePlaying ) {
        [player pause];
        _image.hidden = NO;
        return;
    }else if (player && player.playbackState == MPMoviePlaybackStatePaused) {
        _image.hidden = YES;
        [player play];
        return;
    }
    
    //界面刚显示播放按钮应显示，所以调用时播放图片应为隐藏
    _image.hidden = YES;
    
    //播放视频
    NSString *path = NSHomeDirectory();
    
    
    NSString *fileDirectory = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/2/%@",self.videoUrl]];
    
    NSLog(@"fileDirectory:%@",fileDirectory);
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:fileDirectory]];
    player.view.frame = CGRectMake(0, VideoY, VideoWidth,VideoHeight);
    player.controlStyle = MPMovieControlStyleNone;
    player.repeatMode = MPMovieRepeatModeNone;
    [player setFullscreen:YES animated:YES];
    player.scalingMode = MPMovieScalingModeAspectFit;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
    [self.view insertSubview:player.view belowSubview:_playBtn];
    [player play];
}


//播放视频结束的回调
-(void)myMovieFinishedCallback:(NSNotification*)notify
{
    //视频播放对象
    MPMoviePlayerController* theMovie = [notify object];
    //销毁播放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    [theMovie stop];
    [theMovie.view removeFromSuperview];
    
    //如果视频播放停止了,显示播放按钮图片
    if (player && player.playbackState == MPMoviePlaybackStateStopped){
        _image.hidden = NO;
        [player stop];
        
        return;
    }
    
}

//支持屏幕的旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}


- (BOOL)shouldAutorotate
{
    return NO;
}

@end

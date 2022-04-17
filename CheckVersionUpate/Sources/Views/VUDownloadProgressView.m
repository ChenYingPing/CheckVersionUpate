//
//  VUDownloadProgressView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUDownloadProgressView.h"

@interface VUDownloadProgressView ()

@property (nonatomic, strong) UIProgressView *pv;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *continueButton;

@end

@implementation VUDownloadProgressView

- (instancetype)init
{
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:227/255.0 alpha:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 240, 20)];
    [self addSubview:label];
    label.text = @"当前下载进度";
    label.textAlignment = NSTextAlignmentCenter;
    
    self.pv = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 120, 220, 0)];
    //设置类型
    //[pv setProgressViewStyle:UIProgressViewStyleBar];
    //设置颜色
    [self.pv setTrackTintColor:[UIColor blueColor]];
    [self.pv setProgressTintColor:[UIColor redColor]];
    //设置图片
    //[pv setTrackImage:];
    //[pv setProgressImage:];
    [self addSubview:self.pv];
    
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 100, 40)];
    [self addSubview:self.stopButton];
    self.stopButton.layer.borderWidth = 0.5;
    self.stopButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.stopButton setTitle:@"暂停下载" forState:UIControlStateNormal];
    [self.stopButton addTarget:self action:@selector(stopDownloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.continueButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 100, 40)];
    [self addSubview:self.continueButton];
    self.continueButton.layer.borderWidth = 0.5;
    self.continueButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.continueButton setTitle:@"继续下载" forState:UIControlStateNormal];
    [self.continueButton addTarget:self action:@selector(continueDownloadAction) forControlEvents:UIControlEventTouchUpInside];
    [self.continueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setProgress:(CGFloat)progress
{
    [self.pv setProgress:progress animated:NO];
}

- (void)stopDownloadAction
{
    if (self.stopDownload) {
        self.stopDownload();
    }
}

- (void)continueDownloadAction
{
    if (self.continueDownload) {
        self.continueDownload();
    }
}

@end

//
//  VUUpdateView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUUpdateView.h"
#import "VUUITools.h"

@interface VUUpdateView ()

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation VUUpdateView

- (instancetype)initWithModel:(VUVersionCheckModel *)model
{
    if (self = [super init]) {
        self.model = model;
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5;
    
    // 这里的图片应该是服务端返回的imageUrl，网络图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 162)];
    imageView.image = [UIImage imageNamed:@"newversion"];
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 260, 80)];
    [self addSubview:label];
    label.numberOfLines = 0;
    label.text = self.model.alertText;
    label.textAlignment = NSTextAlignmentCenter;
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 100, 40)];
    [self addSubview:self.cancelButton];
    self.cancelButton.layer.borderWidth = 0.5;
    self.cancelButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.cancelButton setTitle:@"下次再说" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(nextTime) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 300, 100, 40)];
    [self addSubview:self.downloadButton];
    self.downloadButton.layer.borderWidth = 0.5;
    self.downloadButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.downloadButton setTitle:@"立即更新" forState:UIControlStateNormal];
    [self.downloadButton addTarget:self action:@selector(updateNow) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)updateNow
{
    [self removeFromSuperview];
}

- (void)nextTime
{
    [self removeFromSuperview];
}

@end

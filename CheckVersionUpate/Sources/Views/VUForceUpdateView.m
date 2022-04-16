//
//  VUForceUpdateView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUForceUpdateView.h"
#import "VUNetworkHelper.h"

@implementation VUForceUpdateView

+ (void)show:(VUVersionCheckModel *)model
{
    VUForceUpdateView *view = [[VUForceUpdateView alloc] initWithModel:model];
    UIWindow *keyWindow = [self getKeyWindow];
    view.frame = CGRectMake(0, 0, 270, 400);
    view.center = keyWindow.center;
    [keyWindow addSubview:view];
}

- (void)updateNow
{
    [super updateNow];
    // 去下载对应的资源
    [VUNetworkHelper downloadNewVersion];
}

- (void)nextTime
{
    [super nextTime];
    exit(0);
}

@end

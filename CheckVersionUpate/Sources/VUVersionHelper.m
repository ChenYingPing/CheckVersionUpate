//
//  VUVersionHelper.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/15.
//

#import "VUVersionHelper.h"
#import "Reachability.h"
#import "VUNetworkHelper.h"
#import "VUForceUpdateView.h"
#import "VUFreeUpdateView.h"

@implementation VUVersionHelper

+ (void)checkNewVersion
{
    if ([self netWorkConnected]) {
        [self sendVersionCheckRequest];
    }
}

// 判断网络状态
+ (BOOL)netWorkConnected
{
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reachability currentReachabilityStatus];
    switch (status) {
        case ReachableViaWiFi:
        case ReachableViaWWAN:
            return YES;
            break;
            
        default:
            break;
    }
    return NO;
}

// 发送版本对比网络请求
+ (void)sendVersionCheckRequest
{
    [VUNetworkHelper versionCheckRequest:^(VUVersionCheckModel * _Nonnull model) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if ([app_Version integerValue] < model.serverVersion) {
            [self alertUpdateRemind:model];
        }
    }];
}

+ (void)alertUpdateRemind:(VUVersionCheckModel *)model
{
    if (model.forceUpdate) {
        [VUForceUpdateView show:model];
    } else {
        [VUFreeUpdateView show:model];
    }
}

@end

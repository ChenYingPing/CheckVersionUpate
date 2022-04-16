//
//  VUNetworkHelper.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUNetworkHelper.h"

@implementation VUNetworkHelper

+ (void)versionCheckRequest:(void(^)(VUVersionCheckModel *))completed
{
    // 发送网络请求，这里就简单mock下数据
    VUVersionCheckModel *model = [VUVersionCheckModel new];
    model.serverVersion = 100;
    model.forceUpdate = NO;
    model.alertText = @"请立即更新您的app，否则将可能影响您的正常使用";
    if (completed) {
        completed(model);
    }
}

@end

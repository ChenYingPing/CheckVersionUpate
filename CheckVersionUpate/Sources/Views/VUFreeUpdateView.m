//
//  VUFreeUpdateView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUFreeUpdateView.h"
#import "VUNetworkHelper.h"
#import "VUUITools.h"

static NSString *const LastUpdateTime = @"LastUpdateTime";
static NSString *const ServerVersion = @"ServerVersion";

@implementation VUFreeUpdateView

+ (void)show:(VUVersionCheckModel *)model
{
    if ([self validateTime:model]) {
        VUFreeUpdateView *view = [[VUFreeUpdateView alloc] initWithModel:model];
        UIWindow *keyWindow = [VUUITools getKeyWindow];
        view.frame = CGRectMake(0, 0, 270, 400);
        view.center = keyWindow.center;
        [keyWindow addSubview:view];
    }
}

+ (BOOL)validateTime:(VUVersionCheckModel *)model
{
    // 暂时去掉7天内没有新版本不弹窗判断，方便调试
//    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
//    double value = [[[NSUserDefaults standardUserDefaults] objectForKey:LastUpdateTime] doubleValue];
//    NSInteger version = [[[NSUserDefaults standardUserDefaults] objectForKey:ServerVersion] integerValue];
//    if (value > 0 && (time - value) < 7 * 24 * 3600 && version >= model.serverVersion) { // 7 天内, 且没有新版本，不弹窗
//        return NO;
//    }
    return YES;
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
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    [[NSUserDefaults standardUserDefaults] setObject:@(time) forKey:LastUpdateTime];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.model.serverVersion) forKey:ServerVersion];
}

@end

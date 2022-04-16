//
//  VUFreeUpdateView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUFreeUpdateView.h"

@implementation VUFreeUpdateView

+ (void)show:(VUVersionCheckModel *)model
{
    VUFreeUpdateView *view = [[VUFreeUpdateView alloc] initWithModel:model];
    UIWindow *keyWindow = [self getKeyWindow];
    view.frame = CGRectMake(0, 0, 270, 400);
    view.center = keyWindow.center;
    [keyWindow addSubview:view];
}

- (void)updateNow
{
    [super updateNow];
}

- (void)nextTime
{
    [super nextTime];
}

@end

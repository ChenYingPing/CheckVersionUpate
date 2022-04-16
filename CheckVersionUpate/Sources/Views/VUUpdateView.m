//
//  VUUpdateView.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUUpdateView.h"

@implementation VUUpdateView

+ (UIWindow *)getKeyWindow
{
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
            if (windowScene.activationState == UISceneActivationStateForegroundActive) {
                window = windowScene.windows.firstObject;
                break;
            }
        }
    }
    else {
        window = [UIApplication sharedApplication].keyWindow;
    }
    return window;
}

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
    // 这里可以通过UI图搭建对应的提示更新View，model中有背景图，提示文案等
    // 节省时间，先用alert代替
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:self.model.alertText message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateNow];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self nextTime];
    }];
    [actionSheetController addAction:commentAction];
    [actionSheetController addAction:cancelAction];
    [[VUUpdateView getKeyWindow].rootViewController presentViewController:actionSheetController animated:YES completion:nil];
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

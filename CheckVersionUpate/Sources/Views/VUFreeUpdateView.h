//
//  VUFreeUpdateView.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//  用户自由选择是否升级

#import <UIKit/UIKit.h>
#import "VUUpdateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VUFreeUpdateView : VUUpdateView

+ (void)show:(VUVersionCheckModel *)model;

@end

NS_ASSUME_NONNULL_END

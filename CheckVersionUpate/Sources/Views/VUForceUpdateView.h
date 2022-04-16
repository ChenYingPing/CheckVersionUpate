//
//  VUForceUpdateView.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//  强制升级View

#import <UIKit/UIKit.h>
#import "VUUpdateView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VUForceUpdateView : VUUpdateView

+ (void)show:(VUVersionCheckModel *)model;

@end

NS_ASSUME_NONNULL_END

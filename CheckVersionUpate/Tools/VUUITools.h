//
//  VUUITools.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VUUITools : NSObject

+ (UIWindow *)getKeyWindow;

+ (void)showToast:(NSString *)text;

@end

NS_ASSUME_NONNULL_END

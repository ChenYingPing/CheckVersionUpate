//
//  VUVersionCheckModel.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VUVersionCheckModel : NSObject

// 服务端最新版本
@property (nonatomic, assign) NSInteger serverVersion;
// 是否强制升级
@property (nonatomic, assign) BOOL forceUpdate;
// 提示文案
@property (nonatomic, copy) NSString *alertText;
// 背景图
@property (nonatomic, copy) NSString *imageUrl;
// 底部升级按钮文案
@property (nonatomic, copy) NSString *leftButtonText;
@property (nonatomic, copy) NSString *rightButtonText;

@end

NS_ASSUME_NONNULL_END

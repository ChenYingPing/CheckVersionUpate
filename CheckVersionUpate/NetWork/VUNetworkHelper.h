//
//  VUNetworkHelper.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <Foundation/Foundation.h>
#import "VUVersionCheckModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VUNetworkHelper : NSObject

+ (void)versionCheckRequest:(void(^)(VUVersionCheckModel *))completed;

+ (void)downloadNewVersion;

@end

NS_ASSUME_NONNULL_END

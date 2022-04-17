//
//  VNDownloadDataTools.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VNDownloadDataTools : NSObject

+ (instancetype)sharedTool;

- (void)downloadAppDataWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END

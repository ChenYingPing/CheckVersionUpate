//
//  VUDownloadModel.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VUDownloadModel : NSObject

// 数据包下载地址
@property (nonatomic, copy) NSString *downloadUrl;
// 数据包的 md5 值
@property (nonatomic, copy) NSString *md5String;



@end

NS_ASSUME_NONNULL_END

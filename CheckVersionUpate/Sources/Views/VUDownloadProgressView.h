//
//  VUDownloadProgressView.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VUDownloadProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) void(^stopDownload)(void);
@property (nonatomic, copy) void(^continueDownload)(void);

@end

NS_ASSUME_NONNULL_END

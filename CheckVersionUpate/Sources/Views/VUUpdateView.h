//
//  VUUpdateView.h
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import <UIKit/UIKit.h>
#import "VUVersionCheckModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VUUpdateView : UIView

@property (nonatomic, strong) VUVersionCheckModel *model;

- (instancetype)initWithModel:(VUVersionCheckModel *)model;
- (void)updateNow;
- (void)nextTime;

@end

NS_ASSUME_NONNULL_END

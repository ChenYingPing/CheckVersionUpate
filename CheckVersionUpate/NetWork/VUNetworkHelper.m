//
//  VUNetworkHelper.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VUNetworkHelper.h"
#import "RSAObjC.h"
#import "VUDownloadModel.h"
#import "VNDownloadDataTools.h"
#import "constant.h"

@implementation VUNetworkHelper

+ (void)versionCheckRequest:(void(^)(VUVersionCheckModel *))completed
{
    // 发送网络请求，这里就简单mock下数据
    VUVersionCheckModel *model = [VUVersionCheckModel new];
    model.serverVersion = 100;
    model.forceUpdate = NO;
    if (model.forceUpdate) {
        model.alertText = @"请立即更新您的app，\n否则将影响您的正常使用";
    }
    else {
        model.alertText = @"请更新您的app，\n去使用我们的新功能";
    }
    if (completed) {
        completed(model);
    }
}

+ (void)downloadNewVersion
{
    // 正常来说 iOS 应该跳转到AppStore去更新app，这里我们写下 android 的流程，使用RSA加密下载数据包
    // 1.获取下载地址
    NSString *url = [self checkRSAPublicKey];
    if (url.length <= 0) {
        return;
    }
    
    // 2. 下载数据
    [self downloadAppData:url];
}

#pragma mark - 密钥验证，加获取下载地址

+ (NSString *)checkRSAPublicKey
{
    NSString *downloadurl;
    // 1. 发送网络请求获取服务端返回的公钥，假设下面就是服务端返回的数据
    NSString *serverPublicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd%2FB70%2FExMgMBpEwkAAdyUqIjIdVGh1FQK%2F4acwS39YXwbS%2BIlHsPSQIDAQAB%2Ba1a2a3";
    
    // 2. 验证公钥一致性，除数字字母外的符号都进行 URLEncode
    NSString *urlEncodePublicKey = [[self addSalt:gPubkey] stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet];
    if ([urlEncodePublicKey isEqualToString:serverPublicKey]) {
       
        // 3. 使用本地保存的私钥解析服务端返回的 downloadData 字段
        NSString *data = [RSAObjC decrypt:@"downloadData" PrivateKey:gPrikey];
        
        // 4. 将 data =》JSON =》 model, 这个步骤省略，直接 mock 最终的数据
        VUDownloadModel *model = [[VUDownloadModel alloc] init];
        
        // 5. 对下载url加盐后，与服务端返回的md5 值进行对比，一致后进行下载
        if ([[self md5String:[self md5AddSalt:model.downloadUrl]] isEqualToString:model.md5String]) {
            downloadurl = model.downloadUrl;
        }
    }
    else {
        NSLog(@"编码后和服务器传过来的不一致");
    }
    return downloadurl;
}

+ (NSString *)addSalt:(NSString *)key
{
   // 和服务端约定好加盐策略
    return [NSString stringWithFormat:@"%@+a1a2a3",key];
}

+ (NSString *)md5AddSalt:(NSString *)key
{
   // 和服务端约定好加盐策略
    return [NSString stringWithFormat:@"md5%@md5",key];
}

// 这里应该进行一次md5加密后返回 string
+ (NSString *)md5String:(NSString *)string
{
    return string;
}

#pragma mark - 下载数据

+ (void)downloadAppData:(NSString *)url
{
    [[VNDownloadDataTools sharedTool] downloadAppDataWithUrl:url];
}

@end

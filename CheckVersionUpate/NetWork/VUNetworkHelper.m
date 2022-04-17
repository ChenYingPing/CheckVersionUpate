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

/*
 * 在线获取任意的公钥私钥字符串http://www.bm8.com.cn/webtool/rsa/
 * 注意：由于公钥私钥里面含有`/+=\n`等特殊字符串
 * 网络传输过程中导致转义，进而导致加密解密不成功，
 * 解决办法是传输前进行 URL 特殊符号编码解码(URLEncode 百分号转义)
 */
NSString *const gPubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
NSString *const gPrikey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";

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

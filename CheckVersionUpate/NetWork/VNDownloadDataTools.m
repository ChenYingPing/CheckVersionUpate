//
//  VNDownloadDataTools.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/16.
//

#import "VNDownloadDataTools.h"
#import "VUDownloadProgressView.h"
#import "VUUITools.h"

@interface VNDownloadDataTools () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, weak) VUDownloadProgressView *progressView;
@property (nonatomic, assign) BOOL isHold;

@end

@implementation VNDownloadDataTools

+ (instancetype)sharedTool
{
    static VNDownloadDataTools *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[VNDownloadDataTools alloc] init];
    });

    return tools;
}

- (void)downloadAppDataWithUrl:(NSString *)url
{
    ///1.创建NSURLSession默认配置
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];

    ///2.创建NSURLSession,设置代理和队列
    self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    ///3.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [self.session downloadTaskWithRequest:request];
    self.downloadTask = downloadTask;
    [downloadTask resume];
    
    // 4.文件存储目录
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataFilePath = [caches stringByAppendingPathComponent:@"sss"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        // 在 Document 目录下创建一个 head 目录
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    self.filePath = [dataFilePath stringByAppendingString:@"/xxx.tmp"];
    
    // 5.显示下载进度view
    VUDownloadProgressView *view = [[VUDownloadProgressView alloc] init];
    UIWindow *keyWindow = [VUUITools getKeyWindow];
    view.frame = CGRectMake(0, 0, 240, 400);
    view.center = keyWindow.center;
    [keyWindow addSubview:view];
    self.progressView = view;
    __weak VNDownloadDataTools *weakObj = self;
    view.stopDownload = ^{
        [weakObj cancel];
    };
    view.continueDownload = ^{
        [weakObj continueDownload];
    };
}

#pragma mark -- clik
- (void)cancel
{
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
        self.isHold = YES;
    }];
}

- (void)continueDownload
{
    if (self.isHold) {
        self.isHold = NO;
        self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
        [self.downloadTask resume];
    }
}

#pragma mark -- NSURLSessionDownloadDelegate
//该方法下载成功和失败都会回调，只是失败的是error是有值的，
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error
{
    //进入后台失去连接,恢复下载
    if (error.code == -1001) {
        if ([error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData]) {
            NSData *resumeData = [error.userInfo objectForKey:NSURLSessionDownloadTaskResumeData];
            NSURLSessionTask *task = [session downloadTaskWithResumeData:resumeData];
            [task resume];
        }
    }
}
/**
 *  下载完毕会调用
 *
 *  @param location     文件临时地址
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    //把文件移动我们指定的路径下
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager moveItemAtPath:location.path toPath:self.filePath error:nil];
    
    [VUUITools showToast:@"下载已完成，自动更新app后即可使用"];
    [self.progressView removeFromSuperview];
}

/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    float progress = (double)totalBytesWritten/totalBytesExpectedToWrite;
    
    // 当前下载进度，可以用作UI进度条更新
    NSLog(@"当前下载进度 = %f",progress);
    self.progressView.progress = progress;
}

/**
 *  恢复下载后调用，
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes
{

}

@end

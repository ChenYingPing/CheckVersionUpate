//
//  ViewController.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/15.
//

#import "ViewController.h"
#import "VUVersionHelper.h"
#import "VUUITools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [VUVersionHelper checkNewVersion];
}

- (IBAction)checkNewVersion:(id)sender
{
    [VUVersionHelper checkNewVersion];
//    [VUUITools showToast:@"下载已完成，自动更新app"];
}

@end

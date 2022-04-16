//
//  ViewController.m
//  CheckVersionUpate
//
//  Created by apiao on 2022/4/15.
//

#import "ViewController.h"
#import "VUVersionHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [VUVersionHelper checkNewVersion];
}

@end

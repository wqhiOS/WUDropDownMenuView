//
//  ViewController.m
//  WUDropDownMenuView
//
//  Created by wuqh on 15/10/20.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "ViewController.h"
#import "WUDropDownMenuView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = [[WUDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, 100, 44) titles:@[@"menu 1",@"menu 2",@"menu 3",@"menu 4"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

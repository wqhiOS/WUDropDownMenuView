//
//  WUDropDownMenuView.m
//  WUDropDownMenuView
//
//  Created by wuqh on 15/10/20.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUDropDownMenuView.h"
#import <Masonry.h>

@interface WUDropDownMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgBlackView;

@end

@implementation WUDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        
        [self addSubview:self.titleButton];
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self addSubview:self.arrowImageView];
        [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleButton.mas_right).offset(5);
            make.centerY.equalTo(self.titleButton.mas_centerY);
        }];
        
        [self setupView];
    }
    return self;
}

- (void)setupView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    [keyWindow addSubview:self.parentView];
    [self.parentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(keyWindow);
        make.top.equalTo(keyWindow.mas_top).offset(64);
    }];
    [self.parentView addSubview:self.bgBlackView];
    [self.bgBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.parentView);
    }];
    [self.parentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.parentView);
    }];
}

#pragma mark - actions
- (void)titleButtonClick:(UIButton *)button {
    
}


#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}



#pragma mark - getter && setter
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_titleButton setTitle:self.titles[0] forState:UIControlStateNormal];
        NSLog(@"%@",self.titles[0]);
        [_titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _titleButton;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        
        //        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[kBundlePath stringByAppendingPathComponent:@"arrow_down_icon.png"]]];
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"open_arrow_down"]];
    }
    return _arrowImageView;
}

- (UIView *)parentView {
    if (!_parentView) {
        _parentView = [[UIView alloc] init];
        
    }
    return _parentView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
    }
    return _tableView;
}

- (UIView *)bgBlackView {
    if (!_bgBlackView) {
        _bgBlackView = [[UIView alloc] init];
    }
    return _bgBlackView;
}

@end

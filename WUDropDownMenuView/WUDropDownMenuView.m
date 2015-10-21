//
//  WUDropDownMenuView.m
//  WUDropDownMenuView
//
//  Created by wuqh on 15/10/20.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import "WUDropDownMenuView.h"
#import <Masonry.h>

#define kTableViewHeight self.cellHeight*self.titles.count

@interface WUDropDownMenuView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *parentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bgBlackView;

@property (nonatomic, assign) NSInteger seletedIndex;
@property (nonatomic, assign) BOOL isShowMenu;

@end

@implementation WUDropDownMenuView

#pragma mark - lify cycle
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

- (void)layoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}




#pragma mark - actions
- (void)titleButtonClick:(UIButton *)button {
    button.enabled = NO;
    self.isShowMenu = !self.isShowMenu;
    
}


#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.seletedIndex == indexPath.row) {
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {

        [cell setSeparatorInset:UIEdgeInsetsZero];

    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {

        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

#pragma mark - private methods
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
        make.top.equalTo(self.parentView).offset(0-kTableViewHeight);
        make.right.left.equalTo(self.parentView);
        make.height.equalTo(@(kTableViewHeight));
    }];
    self.parentView.hidden = YES;
}

- (void)showMenu {
    self.parentView.hidden = NO;
    
    self.bgBlackView.alpha = 0;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parentView).offset(0);
    }];
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
        self.bgBlackView.alpha = self.bgBlackViewAlpha;
    }];
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.tableView layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.titleButton.enabled = YES;
    }];
}

- (void)hideMenu {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parentView).offset(0-kTableViewHeight);
    }];
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
        self.bgBlackView.alpha = 0;
    }];
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.tableView layoutIfNeeded];

    } completion:^(BOOL finished) {
        self.parentView.hidden = YES;
        self.titleButton.enabled = YES;
    }];
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
        
        _arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"open_arrow_down"]];
    }
    return _arrowImageView;
}

- (UIView *)parentView {
    if (!_parentView) {
        _parentView = [[UIView alloc] init];
        _parentView.clipsToBounds = YES;
    }
    return _parentView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _tableView.separatorInset = UIEdgeInsetsMake(0, -200, 0, 50);
    }
    return _tableView;
}

- (UIView *)bgBlackView {
    if (!_bgBlackView) {
        _bgBlackView = [[UIView alloc] init];
        _bgBlackView.backgroundColor = [UIColor blackColor];
        _bgBlackView.alpha = 0;
    }
    return _bgBlackView;
}

- (CGFloat)cellHeight {
    return 44.f;
}

- (CGFloat)animationDuration {
    return 0.7;
}

- (CGFloat)bgBlackViewAlpha {
    return 0.3;
}

- (void)setIsShowMenu:(BOOL)isShowMenu {
    if (_isShowMenu != isShowMenu) {
        _isShowMenu = isShowMenu;
        if (_isShowMenu) {
            [self showMenu];
        }else {
            [self hideMenu];
        }
    }
    
}

@end

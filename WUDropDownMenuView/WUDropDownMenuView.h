//
//  WUDropDownMenuView.h
//  WUDropDownMenuView
//
//  Created by wuqh on 15/10/20.
//  Copyright © 2015年 吴启晗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WUDropDownMenuView : UIView

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat bgBlackViewAlpha;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

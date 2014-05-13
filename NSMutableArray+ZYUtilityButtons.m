//
//  NSMutableArray+ZYUtilityButtons.m
//  SlideTableCellDemo
//
//  Created by SMIT on 14-5-13.
//  Copyright (c) 2014年 LazyYang. All rights reserved.
//

#import "NSMutableArray+ZYUtilityButtons.h"

@implementation NSMutableArray (ZYUtilityButtons)

- (void)zy_addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addObject:button];
}

@end

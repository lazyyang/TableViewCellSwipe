//
//  ZYMaskVIew.m
//  SlideTableCellDemo
//
//  Created by 杨争 on 5/13/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYMaskVIew.h"

@implementation ZYMaskVIew

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self.delegate maskView:self didHitPoint:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

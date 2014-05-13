//
//  ZYMaskVIew.h
//  SlideTableCellDemo
//
//  Created by 杨争 on 5/13/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYMaskVIew;

@protocol ZYMaskViewDelegate<NSObject>

- (UIView *)maskView:(ZYMaskVIew *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)event;

@end

@interface ZYMaskVIew : UIView

@property (nonatomic,assign) id<ZYMaskViewDelegate> delegate;

@end

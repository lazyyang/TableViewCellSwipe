//
//  ZYMyTableViewCellDemo.m
//  SlideTableCellDemo
//
//  Created by 杨争 on 5/13/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYMyTableViewCellDemo.h"

@interface ZYMyTableViewCellDemo ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZYMyTableViewCellDemo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self theConfigureView];
        
    }
    return self;
}

- (void)theConfigureView
{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    _titleLabel.text = @"哈哈，我都不知道怎么去表达我的好心情了，哈哈哈哈";
    [self.cellView addSubview:self.titleLabel];
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

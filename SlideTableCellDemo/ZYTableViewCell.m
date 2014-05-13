//
//  ZYTableViewCell.m
//  SlideTableViewCell
//
//  Created by 杨争 on 5/12/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYTableViewCell.h"

@interface ZYTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIView *cellView;//用来显示cell上得内容
@property (nonatomic,assign) CGFloat startX;
@property (nonatomic,assign) CGFloat cellX;
@property (nonatomic,strong) NSIndexPath *myIndexPath;
@property (nonatomic,assign) BOOL isMenuViewHidden;
@property (nonatomic,assign) NSInteger btnCnt;
@property (nonatomic,assign) CGRect btnFrame;

@end

@implementation ZYTableViewCell

- (void)setIsMenuViewHidden:(BOOL)isMenuViewHidden
{
    _isMenuViewHidden = isMenuViewHidden;
    self.menuView.hidden = isMenuViewHidden;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _menuView = [[UIView alloc]initWithFrame:CGRectZero];
        self.menuView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.menuView];
        
        _cellView = [[UIView alloc]initWithFrame:CGRectZero];
        self.cellView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.cellView];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(cellPanGes:)];
        panGes.delegate = self;
        panGes.delaysTouchesBegan = YES;
        panGes.cancelsTouchesInView = NO;
        [self addGestureRecognizer:panGes];
        
    }
    return self;
}

-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame
{
    self.myIndexPath = indexPath;
    self.btnCnt = menuData.count;
    self.btnFrame = cellFrame;
    self.cellView.frame = self.bounds;
    self.menuView.frame = CGRectMake(320 - cellFrame.size.width*[menuData count], 0, cellFrame.size.width*[menuData count], cellFrame.size.height);
    self.isMenuViewHidden = YES;
    for (int i = 0; i < menuData.count; i++) {
        UIButton *menuBtn = menuData[i];
        menuBtn.frame = CGRectMake(cellFrame.size.width * i, 0, cellFrame.size.width, cellFrame.size.height);
        menuBtn.tag = i;
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuView addSubview:menuBtn];
    }
}

- (void)menuBtnClick:(UIButton *)button
{
    [self setMenuHidden:YES animated:YES completionHandler:^{
        NSLog(@"隐藏");
    }];
    [self.menuActionDelegate menuChooseIndex:button.tag menuIndexNum:self.myIndexPath.row];
}

-(void)cellPanGes:(UIPanGestureRecognizer *)panGes{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGPoint pointer = [panGes locationInView:self.contentView];
    NSLog(@"----%f",pointer.x);
    if (panGes.state == UIGestureRecognizerStateBegan) {
        [self.menuActionDelegate tableMenuWillShowInCell:self];
        self.isMenuViewHidden = NO;
        self.startX = pointer.x;
        self.cellX = self.cellView.frame.origin.x;

    }else if (panGes.state == UIGestureRecognizerStateChanged){
        self.isMenuViewHidden = NO;
    }else if (panGes.state == UIGestureRecognizerStateEnded){
        [self cellReset:pointer.x - self.startX];
        return;
    }else if (panGes.state == UIGestureRecognizerStateCancelled){
        [self cellReset:pointer.x - self.startX];
        return;
    }
}

-(void)cellReset:(float)moveX{
    if (self.cellX <= -self.btnFrame.size.width*self.btnCnt) {//cellX为起始位置
        NSLog(@"XXXXX%f",self.cellX);
        if (moveX <= 0) {
            return;
        }
        else{
            [UIView animateWithDuration:0.5 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.isMenuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
            }];
            
        }
    }else{
        if (moveX >= 0) {
            return;
        }
        else{
            [UIView animateWithDuration:0.5 animations:^{
                [self initCellFrame:-self.btnFrame.size.width*self.btnCnt];
            } completion:^(BOOL finished) {
                self.isMenuViewHidden = NO;
                [self.menuActionDelegate tableMenuDidShowInCell:self];
            }];
        }
    }
}


- (void)initCellFrame:(float)x{
    CGRect frame = self.cellView.frame;
    frame.origin.x = x;
    
    self.cellView.frame = frame;
}

#pragma mark * UIPanGestureRecognizer delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return fabs(translation.x) > fabs(translation.y);
    }
    return YES;
}

- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    if (hidden) {
        CGRect frame = self.cellView.frame;
        if (frame.origin.x != 0) {
            [UIView animateWithDuration:0.5 animations:^{
                [self initCellFrame:0];
            } completion:^(BOOL finished) {
                self.isMenuViewHidden = YES;
                [self.menuActionDelegate tableMenuDidHideInCell:self];
                if (completionHandler) {
                    completionHandler();
                }
            }];
        }
    }
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    NSLog(@"===highlighted====%d",highlighted);
    if (self.isMenuViewHidden) {
        self.menuView.hidden = YES;
        [super setHighlighted:highlighted animated:animated];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    NSLog(@"====selected===%d",selected);
    if (self.isMenuViewHidden) {
        self.menuView.hidden = YES;
        [super setSelected:selected animated:animated];
    }
}
@end

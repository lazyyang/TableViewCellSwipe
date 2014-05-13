//
//  ZYTableMenu.m
//  SlideTableCellDemo
//
//  Created by 杨争 on 5/13/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYTableMenu.h"

@interface ZYTableMenu ()

@property (nonatomic,assign) BOOL isEditing;
@property (nonatomic,strong) ZYMaskVIew *maskView;
@property (nonatomic,strong) ZYTableViewCell *activeCell;
@end

@implementation ZYTableMenu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setIsEditing:(BOOL)isEditing
{
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
    }
    
    if (_isEditing) {
        if (!_maskView) {
            _maskView = [[ZYMaskVIew alloc]initWithFrame:self.view.bounds];
            _maskView.backgroundColor = [UIColor redColor];
            _maskView.alpha = 0.5f;
            _maskView.delegate = self;
            [self.view addSubview:_maskView];
        }
    }
    else{
        [_maskView removeFromSuperview];
        _maskView = nil;
    }
}

- (UIView *)maskView:(ZYMaskVIew *)view didHitPoint:(CGPoint)didHitPoint withEvent:(UIEvent *)event
{
    BOOL shoudReceivePointTouch = YES;
    
    CGPoint location = [self.view convertPoint:didHitPoint fromView:view];
    CGRect rect = [self.view  convertRect:self.activeCell.menuView.frame toView:self.view];
    shoudReceivePointTouch = CGRectContainsPoint(rect, location);//location是否在rect里面
    if (!shoudReceivePointTouch) {
        [self hideMenuActive];
        return view;
    }
    else{
        return [self.activeCell hitTest:didHitPoint withEvent:event];
    }
}

- (void)hideMenuActive{
    __block ZYTableMenu *tableViewMenu = self;
    [self.activeCell setMenuHidden:YES animated:YES completionHandler:^{
        tableViewMenu.isEditing = NO;
    }];
}

#pragma mark - menuActionDelegate
- (void)tableMenuDidShowInCell:(ZYTableViewCell *)cell
{
    NSLog(@"已经显示");
    self.isEditing = YES;
    self.activeCell = cell;
}

- (void)tableMenuWillShowInCell:(ZYTableViewCell *)cell
{
    NSLog(@"即将显示");
    self.isEditing = YES;
    self.activeCell = cell;
}

- (void)tableMenuDidHideInCell:(ZYTableViewCell *)cell
{
    NSLog(@"已经隐藏");
    self.isEditing = NO;
    self.activeCell = nil;
}

- (void)tableMenuWillHideInCell:(ZYTableViewCell *)cell
{
    NSLog(@"即将隐藏");
    self.isEditing = NO;
    self.activeCell = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

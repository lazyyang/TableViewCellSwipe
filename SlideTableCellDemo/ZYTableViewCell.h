//
//  ZYTableViewCell.h
//  SlideTableViewCell
//
//  Created by 杨争 on 5/12/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYTableViewCell;

@protocol menuActionDelegate <NSObject>
- (void)tableMenuDidShowInCell:(ZYTableViewCell *)cell;
- (void)tableMenuWillShowInCell:(ZYTableViewCell *)cell;
- (void)tableMenuDidHideInCell:(ZYTableViewCell *)cell;
- (void)tableMenuWillHideInCell:(ZYTableViewCell *)cell;
- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum;
@required

@end

@interface ZYTableViewCell : UITableViewCell
@property (nonatomic,assign) id<menuActionDelegate>menuActionDelegate;
@property (nonatomic,strong) UIView *menuView;
@property (nonatomic,strong) UIView *cellView;//用来显示cell上得内容


-(void)configWithData:(NSIndexPath *)indexPath menuData:(NSArray *)menuData cellFrame:(CGRect)cellFrame;
- (void)setMenuHidden:(BOOL)hidden animated:(BOOL)animated completionHandler:(void (^)(void))completionHandler;

@end

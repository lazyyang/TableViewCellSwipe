//
//  ZYViewController.m
//  SlideTableViewCell
//
//  Created by 杨争 on 5/12/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYMyTableViewCellDemo.h"
#import "NSMutableArray+ZYUtilityButtons.h"

static NSString *const cellIdentifier = @"cellID";
#define CELLFRAME CGRectMake(0, 0, 80, 80)


@interface ZYViewController ()

@property (strong,nonatomic) NSArray *itemsArray;
@property (strong,nonatomic) UITableView *myTableView;

@end

@implementation ZYViewController

#pragma mark -UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEditing) {
        return;
    }
    NSLog(@"选择了");
}

#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYMyTableViewCellDemo *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.menuActionDelegate = self;
    NSMutableArray *menuArr = [[NSMutableArray alloc] init];
    [menuArr zy_addUtilityButtonWithColor:[UIColor lightGrayColor] title:@"更多"];
    [menuArr zy_addUtilityButtonWithColor:[UIColor redColor] title:@"删除"];
    [cell configWithData:indexPath menuData:menuArr cellFrame:CELLFRAME];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    // Do any additional setup after loading the view, typically from a nib.
    self.itemsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    
    //createTableView
    _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.myTableView registerClass:[ZYMyTableViewCellDemo class] forCellReuseIdentifier:cellIdentifier];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
}

- (void)menuChooseIndex:(NSInteger)cellIndexNum menuIndexNum:(NSInteger)menuIndexNum
{
    NSLog(@"cellIndexNum ==== %d,menuIndexNum = %d",cellIndexNum,menuIndexNum);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ShowSubViewController.m
//  大麦
//
//  Created by 洪欣 on 16/12/20.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ShowSubViewController.h"
#import "ShowSubViewCell.h"
#import "ShowViewCellModel.h"
#import "ShowViewModel.h"
#import "IntroductionViewController.h"
#import "ShowViewController.h"
@interface ShowSubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *list;
@property (strong, nonatomic) ShowRequestModel *Md;
@property (assign, nonatomic) BOOL Refreshing;
@property (strong, nonatomic) ErrorView *errorView;
@end

@implementation ShowSubViewController

- (ErrorView *)errorView
{
    if (!_errorView) {
        _errorView = [[ErrorView alloc] initWithFrame:self.view.bounds ImageName:@"moren_noproject" Title:@"暂时还没有项目吆~"];
        _errorView.height -= 49;
    }
    return _errorView;
}

- (ShowRequestModel *)Md
{
    if (!_Md) {
        _Md = [[ShowRequestModel alloc] init];
    }
    return _Md;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)loadData:(ShowRequestModel *)model Complete:(void(^)())complete
{
    if (model.p.integerValue == 1 && !self.Refreshing) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    self.Md = model;
    HXWeakSelf
    [ShowViewModel getAllTypeModel:self.Md List:^(NSArray *array, NSInteger total) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.Md.p.intValue == 1) {
            weakSelf.list = [NSMutableArray arrayWithArray:array];
        }else {
            [weakSelf.list addObjectsFromArray:array];
        }
        [weakSelf.tableView reloadData];
        if (total == weakSelf.list.count) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }else {
            weakSelf.tableView.mj_footer.hidden = NO;
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        weakSelf.Refreshing = NO;
        if (total == 0) {
            [weakSelf.view addSubview:weakSelf.errorView];
        }else {
            [weakSelf.errorView removeFromSuperview];
        }
        
        if (complete) {
            complete();
        }
    } Failure:^(NSError *error) {
        weakSelf.Refreshing = NO;
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        if (weakSelf.Md.p.intValue > 1) {
            weakSelf.Md.p = [NSString stringWithFormat:@"%d",weakSelf.Md.p.intValue - 1];
        }
        if (complete) {
            complete();
        }
    }];
}

- (void)setup
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 104) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ShowSubViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.height = 10;
    tableView.tableFooterView = footerView;
    
    MJWeakSelf
    tableView.mj_header = [HXRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.Refreshing = YES;
        weakSelf.Md.p = @"1";
        [weakSelf loadData:weakSelf.Md Complete:nil];
    }];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.Refreshing = YES;
        weakSelf.Md.p = [NSString stringWithFormat:@"%d",weakSelf.Md.p.intValue + 1];
        [weakSelf loadData:weakSelf.Md Complete:nil];
    }];
    footer.stateLabel.hidden = YES;
    tableView.mj_footer = footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowSubViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.model = self.list[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 9.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ShowViewCellModel *model = self.list[indexPath.section];
    IntroductionViewController *vc = [[IntroductionViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.dataId = model.i;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

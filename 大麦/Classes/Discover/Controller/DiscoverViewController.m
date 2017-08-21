//
//  DiscoverViewController.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverHeaderView.h"
#import "DiscoverViewModel.h"
#import "DiscoverViewCell.h"
#import "WebViewController.h"
@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) DiscoverHeaderView *headerView;
@property (strong, nonatomic) NSMutableArray *list;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) BOOL isheaderComplete;
@property (assign, nonatomic) BOOL isCelComplete;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
    
    [self setup];
    
    self.loadingView.y = 64;
    self.loadingView.height -= 64 + 49;
    self.loadingView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loadingView];
    [self refreshList];
}

- (void)refreshList
{
    self.page = 1;
    HXWeakSelf
    [DiscoverViewModel getHeaderDataModel:^(DiscoverHeaderModel *model) {
        weakSelf.headerView.model = model;
        weakSelf.isheaderComplete = YES;
        if (weakSelf.isCelComplete) {
            [weakSelf.loadingView removeFromSuperview];
        }
    } Failure:^(NSError *error) {
        weakSelf.isheaderComplete = YES;
        if (weakSelf.isCelComplete) {
            [weakSelf.loadingView removeFromSuperview];
        }
    }];
    
    [DiscoverViewModel getCellDataPage:[NSString stringWithFormat:@"%ld",self.page] ModelList:^(NSArray *array, NSInteger tatol) {
        weakSelf.list = [NSMutableArray arrayWithArray:array];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        if (tatol == weakSelf.list.count) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        weakSelf.isCelComplete = YES;
        if (weakSelf.isheaderComplete) {
            [weakSelf.loadingView removeFromSuperview];
        }
    } Failure:^(NSError *error) {
        weakSelf.isCelComplete = YES;
        [weakSelf.tableView.mj_header endRefreshing];
        if (weakSelf.isheaderComplete) {
            [weakSelf.loadingView removeFromSuperview];
        }
    }];
}

- (void)loadMoreData
{
    HXWeakSelf
    [DiscoverViewModel getCellDataPage:[NSString stringWithFormat:@"%ld",self.page + 1] ModelList:^(NSArray *array, NSInteger tatol) {
        weakSelf.page++;
        [weakSelf.list addObjectsFromArray:array];
        [weakSelf.tableView reloadData];
        if (tatol == weakSelf.list.count) {
            weakSelf.tableView.mj_footer.hidden = YES;
        }
        [weakSelf.tableView.mj_footer endRefreshing];
    } Failure:^(NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}

- (void)setup
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[DiscoverViewCell class] forCellReuseIdentifier:@"cellId"];
    tableView.mj_header = [HXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshList)];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.hidden = YES;
    tableView.mj_footer = footer;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    DiscoverHeaderView *headerView = [[DiscoverHeaderView alloc] init];
    headerView.height = 350;
    tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.model = self.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 235;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverCellModel *model = self.list[indexPath.row];
    
    if (model.templateType.integerValue == 5) {
        WebViewController *vc = [[WebViewController alloc] init];
        vc.url = model.url;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F4153D"] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#ffffff"]}];
}

@end

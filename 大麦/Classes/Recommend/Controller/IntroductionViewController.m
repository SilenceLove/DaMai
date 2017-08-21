//
//  IntroductionViewController.m
//  大麦
//
//  Created by 洪欣 on 16/12/16.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroductionViewModel.h"
#import "IntroductionHeaderView.h"
#import "IntroductionOneView.h"
#import "IntroductionTwoView.h"
#import "IntroductionThreeView.h"
#import "IntroductionTypeView.h"
#import "IntroductionBottomView.h"
#import "IntroductionScrollView.h"
@interface IntroductionViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IntroductionHeaderView *headerView;;
@property (weak, nonatomic) IntroductionScrollView *scrollView;
@property (weak, nonatomic) IntroductionOneView *oneView;
@property (weak, nonatomic) IntroductionTwoView *twoView;
@property (weak, nonatomic) IntroductionThreeView *threeView;
@property (weak, nonatomic) IntroductionTypeView *commentView;
@property (weak, nonatomic) IntroductionTypeView *answerView;
@property (weak, nonatomic) IntroductionBottomView *bottomView;
@property (assign, nonatomic) BOOL modelLoadComplete;
@property (assign, nonatomic) BOOL subModelLoadComplete;
@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self setup];
    [self.view addSubview:self.loadingView];
    [self setupNavBar];
    HXWeakSelf
    [IntroductionViewModel getIntroductionDataId:self.dataId Succeed:^(IntroductionModel *model) {
        weakSelf.headerView.model = model;
        weakSelf.bottomView.model = model;
        weakSelf.scrollView.model = model;
        weakSelf.modelLoadComplete = YES;
        if (weakSelf.subModelLoadComplete) {
            [weakSelf.scrollView showAllView];
            weakSelf.bottomView.hidden = NO;
            [weakSelf.loadingView removeFromSuperview];
        }
    } Failure:^(NSError *error) {
        [weakSelf.loadingView removeFromSuperview];
    }];
    
    [IntroductionViewModel getIntroductionSubDataId:self.dataId Succeed:^(IntroductionSubModel *model) {
        weakSelf.scrollView.subModel = model;
        weakSelf.subModelLoadComplete = YES;
        if (weakSelf.modelLoadComplete) {
            [weakSelf.scrollView showAllView];
            weakSelf.bottomView.hidden = NO;
            [weakSelf.loadingView removeFromSuperview];
        }
    } Failure:^(NSError *error) {
        [weakSelf.loadingView removeFromSuperview];
    }];
}

- (void)setupNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [navBar setTintColor:[UIColor whiteColor]];
    [self.view addSubview:navBar];
    [navBar setShadowImage:[[UIImage alloc] init]];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = @"项目介绍";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item0 = [UIBarButtonItem itemWithImageName:@"icon_share_normal" highImageName:@"my" target:self action:@selector(didItemClick:)];
    item0.customView.tag = 0;
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"icon_collection_normal" selectedImageName:@"icon_collection_normal_add" target:self action:@selector(didItemClick:)];
    item1.customView.tag = 1;
    navItem.rightBarButtonItems = @[item0,item1];
    navItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_back_normal" highImageName:@"my" target:self action:@selector(back)];
    [(UIButton *)navItem.leftBarButtonItem.customView setImage:[[UIImage imageNamed:@"icon_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didItemClick:(UIButton *)button
{
    if (button.tag == 0) {
    
    }else {
        button.selected = !button.selected;
    }
}

- (void)setup
{
    IntroductionScrollView *scrollView = [[IntroductionScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.contentInset = UIEdgeInsetsMake(265, 0 , 50, 0);
    [scrollView setContentOffset:CGPointMake(0, -265)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    IntroductionHeaderView *headerView = [[IntroductionHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 265)];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    
    IntroductionBottomView *bottomView = [[IntroductionBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50)];
    bottomView.hidden = YES;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView updateSubViewsWithScrollOffsetY:scrollView.contentOffset.y];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end

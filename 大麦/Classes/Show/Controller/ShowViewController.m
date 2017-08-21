//
//  ShowViewController.m
//  大麦
//
//  Created by 洪欣 on 16/12/13.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ShowViewController.h"
#import "HorizontalButton.h"
#import "SelectCityViewController.h"
#import "TypeScrollView.h"
#import "ShowChildScrollView.h"
#import "ShowSubViewController.h"
#import "ShowSelectTypeView.h"
@interface ShowViewController ()<SelectCityViewControllerDelegate,TypeScrollViewDelegate,ShowChildScrollViewDelegate>
@property (weak, nonatomic) HorizontalButton *cityBtn;
@property (weak, nonatomic) TypeScrollView *typeView;
@property (weak, nonatomic) ShowChildScrollView *scrollView;
@property (copy, nonatomic) NSArray *titles;
@property (strong, nonatomic) ShowSelectTypeView *timeTypeView;
@property (strong, nonatomic) UIView *bgView;
@property (weak, nonatomic) UIButton *rightBtn;
@end

@implementation ShowViewController

- (ShowSelectTypeView *)timeTypeView
{
    if (!_timeTypeView) {
        _timeTypeView = [[ShowSelectTypeView alloc] initWithFrame:CGRectMake(0, 64 - 250, ScreenWidth, 250)];
    }
    return _timeTypeView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didBgViewClick)]];
    }
    return _bgView;
}

- (void)didBgViewClick
{
    [self didRightClick:self.rightBtn];
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"全部分类",@"演唱会",@"音乐会",@"话剧歌剧",@"舞蹈芭蕾",@"曲苑杂坛",@"体育比赛",@"度假休闲",@"周边商品",@"儿童亲子",@"动漫"];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViewController];
    [self setupUI];
    [self setupNavBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedCityNotification:) name:@"SelectCityNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTypeNotification:) name:@"ShowSelectTypeNotification" object:nil];
}

- (void)selectedCityNotification:(NSNotification *)notification
{
    SelectCityModel *model = notification.userInfo[@"model"];
    [self.cityBtn setTitle:model.n forState:UIControlStateNormal];
}

- (void)selectTypeNotification:(NSNotification *)notification
{
    [self didRightClick:self.rightBtn];
}

- (void)addSubViewController
{
    ShowSubViewController *one = [[ShowSubViewController alloc] init];
    [self addChildViewController:one];
    
    ShowSubViewController *two = [[ShowSubViewController alloc] init];
    [self addChildViewController:two];
}

- (void)setupNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F4153D"] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = @"演出";
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    HorizontalButton *cityBtn = [HorizontalButton buttonWithType:UIButtonTypeCustom];
    SingleClass *single = [SingleClass sharedInstance];
    [cityBtn setTitle:(single.cityName ? single.cityName : @"武汉") forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"btn_cityArrow"] forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(didCityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    self.cityBtn = cityBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[[UIImage imageNamed:@"icon_screening_bottom_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didRightClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.size = rightBtn.currentImage.size;
    self.rightBtn = rightBtn;
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [navBar setTintColor:[UIColor whiteColor]];
    
    [self.view insertSubview:self.timeTypeView belowSubview:navBar];
}

- (void)didCityBtnClick
{
    SelectCityViewController *vc = [[SelectCityViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didSelectCityClick:(SelectCityModel *)model
{
    [self.cityBtn setTitle:model.n forState:UIControlStateNormal];
}

- (void)didRightClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        [self.view insertSubview:self.bgView belowSubview:self.timeTypeView];
        [UIView animateWithDuration:0.25 animations:^{
            button.transform = CGAffineTransformMakeRotation(M_PI);
            self.timeTypeView.y += 250;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            button.transform = CGAffineTransformIdentity;
            self.timeTypeView.y -= 250;
            self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        } completion:^(BOOL finished) {
            [self.bgView removeFromSuperview];
        }];
    }
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
    TypeScrollView *typeView = [[TypeScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40) Titles:self.titles];
    typeView.myDelegate = self;
    typeView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:typeView];
    self.typeView = typeView;
    
    ShowChildScrollView *scrollView = [[ShowChildScrollView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 104) ChildViewControllers:self.childViewControllers MaxCount:self.titles.count];
    scrollView.myDelegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)didTypeWithIndex:(NSInteger)index
{
    [self.scrollView scrollViewWithIndex:index];
}

- (void)scrollViewEndSlideWithIndex:(NSInteger)index
{
    [self.typeView selectedButtonForIndex:index];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

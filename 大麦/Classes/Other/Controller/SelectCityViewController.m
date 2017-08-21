//
//  SelectCityViewController.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "SelectCityViewController.h"
#import "SelectCityViewModel.h"
#import "SelectCityHeaderView.h"
#import <CoreLocation/CoreLocation.h>
@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (copy, nonatomic) NSArray *sectionAy;
@property (copy, nonatomic) NSArray *hotCityAy;
@property (copy, nonatomic) NSArray *cityAy;
@property (copy, nonatomic) NSArray *locationAy;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

static NSString *selectCityHeaderViewId = @"selectCityHeaderViewId";
@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市选择";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(ScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"close_red" highImageName:@"my" target:self action:@selector(closeClick)];
    self.sectionAy = @[@"GPS定位到的城市"];
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.n = @"定位中";
    self.locationAy = @[model];
    [self addLocation];
    [self setup];
    
    [self.view addSubview:self.loadingView];
}

- (void)closeClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

#pragma mark - < 定位失败 >
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        [self errorLocation];
    }else if ([error code] == kCLErrorLocationUnknown) {
        [self errorLocation];
    }
}

- (void)errorLocation
{
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.n = @"武汉市";
    self.locationAy = [NSArray arrayWithObject:model];
    HXWeakSelf
    [SelectCityViewModel getCityList:^(NSArray *hotList, NSArray *sectionList, NSArray *cityList) {
        weakSelf.hotCityAy = hotList;
        NSMutableArray *array = [NSMutableArray arrayWithArray:sectionList];
        [array insertObject:@"热门城市" atIndex:0];
        [array insertObject:@"CPS定位到的城市" atIndex:0];
        weakSelf.sectionAy = array;
        weakSelf.cityAy = cityList;
        [weakSelf.tableView reloadData];
    }];
    [self.loadingView removeFromSuperview];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    SelectCityModel *model = [[SelectCityModel alloc] init];
    model.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    model.lng = [NSString stringWithFormat:@"%f",coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            if (!placemark.locality) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                model.n = placemark.administrativeArea;
            }else{
                model.n = placemark.locality;
            }
            model.i = [Tools queryCityId:model.n];
            self.locationAy = [NSArray arrayWithObject:model];
            HXWeakSelf
            [SelectCityViewModel getCityList:^(NSArray *hotList, NSArray *sectionList, NSArray *cityList) {
                weakSelf.hotCityAy = hotList;
                NSMutableArray *array = [NSMutableArray arrayWithArray:sectionList];
                [array insertObject:@"热门城市" atIndex:0];
                [array insertObject:@"CPS定位到的城市" atIndex:0];
                weakSelf.sectionAy = array;
                weakSelf.cityAy = cityList;
                [weakSelf.tableView reloadData];
                [weakSelf.loadingView removeFromSuperview];
            }];
        }
    }];
    [self.locationManager stopUpdatingLocation];
}

- (void)setup
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[SelectCityHeaderView class] forHeaderFooterViewReuseIdentifier:selectCityHeaderViewId];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionAy.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.locationAy.count;
    }else if (section == 1) {
        return self.hotCityAy.count;
    }else {
        return [self.cityAy[section - 2] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *selectCityViewCellId = @"selectCityViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectCityViewCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectCityViewCellId];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    }

    if (indexPath.section == 0) {
        SelectCityModel *model = self.locationAy.firstObject;
        cell.textLabel.text = model.n;
    }else if (indexPath.section == 1){
        SelectCityModel *model = self.hotCityAy[indexPath.row];
        cell.textLabel.text = model.n;
    }else {
        SelectCityModel *model = self.cityAy[indexPath.section - 2][indexPath.row];
        cell.textLabel.text = model.n;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SelectCityHeaderView *headerView = [[SelectCityHeaderView alloc] initWithReuseIdentifier:selectCityHeaderViewId];
    
    headerView.title = [self.sectionAy[section] uppercaseString];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SelectCityModel *model;
    if (indexPath.section == 0) {
        model = self.locationAy[indexPath.row];
        if ([model.n isEqualToString:@"定位失败"]) {
            return;
        }
        model.n = [model.n substringToIndex:model.n.length-1];
    }else if (indexPath.section == 1) {
        model = self.hotCityAy[indexPath.row];
    }else {
        model = self.cityAy[indexPath.section - 2][indexPath.row];
    }
    
//    if ([self.delegate respondsToSelector:@selector(didSelectCityClick:)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self.delegate didSelectCityClick:model];
//    }
    SingleClass *single = [SingleClass sharedInstance];
    single.cityName = model.n;
    single.cityId = model.i;
    single.latitude = model.lat;
    single.longitude = model.lng;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectCityNotification" object:nil userInfo:@{@"model" : model}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

@end

//
//  YGCommonCityController.m
//  WeatherForecast
//
//  Created by 阳光 on 2016/10/25.
//  Copyright © 2016年 北京邮电大学世纪学院. All rights reserved.
//

#import "CommonCityController.h"
#import "SearchCityController.h"
#import "YGUserDefaults.h"
#import "YGLocationTool.h"
#import "YGWeatherDataTool.h"

@interface CommonCityController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, SearchCityControllerDelegate>

@property (nonatomic, strong) NSMutableArray *commonCities;

@property (nonatomic, weak  ) UISwitch       *autoLocationSwitch;

@property (nonatomic, strong) UITableView    *tableView;

@end

@implementation CommonCityController

#pragma mark - Lazy load

- (NSMutableArray *)commonCities {
    
    if (!_commonCities) {
        _commonCities = [NSMutableArray arrayWithArray:[YGWeatherDataTool commonCities]];
    }
    return _commonCities;
}

#pragma mark - Life circle(生命周期方法)

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BACKGROUND_GRAY;
    
    [self setupNavBar];
    
    [self setupTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationServicesDisabled)
                                                 name:YGLocationServicesDisabled
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(locationServicesAuthorizationStatusDenied)
                                                 name:YGLocationServicesAuthorizationStatusDenied
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    NSMutableArray *commonCities = [NSMutableArray arrayWithArray:[YGWeatherDataTool commonCities]];
    if (_commonCities.count != commonCities.count) {
        _commonCities = commonCities;
        [self.tableView reloadData];
    }
}

#pragma mark - Init setting

- (void)setupTableView
{
    
    _tableView                = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource     = self;
    _tableView.delegate       = self;
    _tableView.rowHeight      = 54;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)setupNavBar
{
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItems = @[editItem, searchItem];
}

#pragma mark - Monitor method

- (void)editAction
{
    
    if (self.commonCities.count == 0) {
        return;
    }
    self.tableView.editing = !self.tableView.editing;
    if (self.tableView.editing) {
        UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editAction)];
        UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
        self.navigationItem.rightBarButtonItems = @[editItem, searchItem];
    } else {
        [self setupNavBar];
    }
}

- (void)popAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchAction
{
    
    SearchCityController *searchCityController = [[SearchCityController alloc] init];
    searchCityController.delegate = self;
    [self.navigationController pushViewController:searchCityController animated:YES];
}

- (void)switchViewAction:(UISwitch *)sender
{
    
    if (sender.isOn) {
        if ([self.delegate respondsToSelector:@selector(commonCityControllerDidOpenAutoLocation)]) {
            [self.delegate commonCityControllerDidOpenAutoLocation];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(commonCityControllerDidCloseAutoLocation)]) {
            [self.delegate commonCityControllerDidCloseAutoLocation];
        }
    }
}

#pragma mark - UITableViewDataSource(TableView数据源方法)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if ([YGLocationTool sharedInstance].isAutoLocation) {
            if ([YGLocationTool sharedInstance].currentLocationCity) {
                return 2;
            }
        }
        return 1;
    }
    return self.commonCities.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"自动定位";
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
            
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0 , 0, 60, 30)];
            [switchView setOnTintColor:[UIColor grayColor]];
            [switchView setTintColor:COLOR_BACKGROUND_GRAY];
            [switchView addTarget:self action:@selector(switchViewAction:) forControlEvents:UIControlEventValueChanged];
            switchView.on = [[YGLocationTool sharedInstance] isAutoLocation];
            cell.accessoryView = switchView;
            self.autoLocationSwitch = switchView;
        } else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = [[YGLocationTool sharedInstance] currentLocationCity];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_location_dark"]];
        }
        UIView *divider= [[UIView alloc] initWithFrame:CGRectMake(0, 54 - 1, SCREEN_WIDTH, 1)];
        divider.backgroundColor = COLOR_DIVIDERLIN;
        [cell addSubview:divider];
    } else {
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_ADJUST(16)];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.text = @"常用城市";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            static NSString * const cellID = @"cellID";
            cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_ADJUST(15)];
            }
            cell.textLabel.text = self.commonCities[indexPath.row - 1];
        }
        UIView *divider= [[UIView alloc] initWithFrame:CGRectMake(0, 54 - 1, SCREEN_WIDTH, 1)];
        divider.backgroundColor = COLOR_DIVIDERLIN;
        [cell addSubview:divider];
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 || indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.commonCities removeObjectAtIndex:indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [YGWeatherDataTool saveCommonCities:[self.commonCities copy]];
        if ([self.delegate respondsToSelector:@selector(commonCityControllerDidDeleteCity)]) {
            [self.delegate commonCityControllerDidDeleteCity];
        }
        
        if (self.commonCities.count == 0) {
            [self setupNavBar];
            [self editAction];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    NSString *city = self.commonCities[fromIndexPath.row - 1];
    [self.commonCities removeObject:city];
    
    if (toIndexPath.section == 0 || toIndexPath.row == 0) {
        [self.commonCities insertObject:city atIndex:0];
        [YGWeatherDataTool saveCommonCities:[self.commonCities copy]];
        [self.tableView reloadData];
    } else {
        [self.commonCities insertObject:city atIndex:toIndexPath.row - 1];
        [YGWeatherDataTool saveCommonCities:[self.commonCities copy]];
    }
    if ([self.delegate respondsToSelector:@selector(commonCityControllerDidReorderCity)]) {
        [self.delegate commonCityControllerDidReorderCity];
    }
}

#pragma mark - UITableViewDelegate(TableView代理协议)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if (section == 1) {
        return 0.1;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        if ([self.delegate respondsToSelector:@selector(commonCityControllerDidSelectCity:isLocationCity:)]) {
            [self.delegate commonCityControllerDidSelectCity:[[YGLocationTool sharedInstance] currentLocationCity] isLocationCity:YES];
        }
        [self popAction];
        return;
    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *city = cell.textLabel.text;
    if ([self.delegate respondsToSelector:@selector(commonCityControllerDidSelectCity:isLocationCity:)]) {
        [self.delegate commonCityControllerDidSelectCity:city isLocationCity:NO];
    }
    [self popAction];
}

#pragma mark - Public method （公共方法）

- (void)showAlertController:(NSString *)message
{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style: UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.autoLocationSwitch.on = NO;
    }];
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)locationServicesDisabled {
    
    [self showAlertController:@"请打开系统定位服务"];
}

- (void)locationServicesAuthorizationStatusDenied {
    
    [self showAlertController:@"请允许APP使用定位功能\n设置->隐私->定位服务->幻视"];
}

#pragma mark - SearchCityControllerDelegate

- (void)searchCityControllerDidAddCity {
    
    if ([self.delegate respondsToSelector:@selector(commonCityControllerDidAddCity)]) {
        [self.delegate commonCityControllerDidAddCity];
    }
}

- (void)searchCityControllerCityHasAdded {
    
    [MBProgressHUD sr_showInfoWithMessage:@"该城市已添加" onView:self.view];
}

- (void)searchCityControllerDidAddMoreThan12Cities {
    
    [MBProgressHUD sr_showInfoWithMessage:@"最多只能添加12个常用城市" onView:self.view];
}

@end



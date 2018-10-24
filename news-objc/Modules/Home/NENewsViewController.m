//
//  NENewsViewController.m
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NENewsViewController.h"
#import "NENewsViewModel.h"
#import "NESearchView.h"
#import "UIView+NEAdd.h"
#import "NSObject+STListener.h"

// h不引用Cell
@interface NENewsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NESearchView *searchView;
@property (nonatomic, strong) NENewsViewModel *viewModel;
@end

@implementation NENewsViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [[NENewsViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subviewsLayout];
    [self.searchButton setTitle:@"看一看" forState:UIControlStateNormal];
    // 把搜索框Keyword绑定到ViewModel, 把Keywordb绑定到title
    RAC(_viewModel, keyword) = self.searchView.searchSignal;
    RAC(self.navigationItem, title) = RACObserve(_viewModel, keyword);
    
    // 不产生副作用的写法
    RAC(_searchButton, backgroundColor) = [RACObserve(_searchButton, enabled) map:^id(NSNumber *value) {
        return value.boolValue ? kMainColor : kColor(0x999999);
    }];
    /*
     [RACObserve(_signInButton, enabled) subscribeNext:^(NSNumber *value) {
     self.signInButton.backgroundColor = value.boolValue ? kMainColor : kMainDisableColor;
     }];
     */
    @weakify(self);
    self.searchButton.rac_command = [_viewModel searchCommand];
    [[[self.searchButton.rac_command executionSignals] switchToLatest] subscribeNext:^(RACSignal<id> * _Nullable x) {
        @strongify(self);
        [self.searchView endEditing:true];
        [[[self.viewModel newsSignal] deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            [self.tableView reloadData];
        } error:^(NSError * _Nullable error) {
            
        }];
    }];
}

- (void)subviewsLayout {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.searchButton];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).inset(kNavigationControllerHeight);
        make.left.equalTo(self.view);
        make.right.equalTo(self.searchButton.mas_left);
        make.height.mas_equalTo(50.f);
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).inset(kNavigationControllerHeight);
        make.left.equalTo(self.searchView.mas_right);
        make.height.mas_equalTo(50.f);
        make.width.mas_equalTo(80.f);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [_viewModel bindIndexPath:indexPath];
    @weakify(self);
    [[[_viewModel.deleteCommand executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_viewModel.cellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kPlaceholderColor;
    [cell performSelector:@selector(bindViewModel:) withObject:_viewModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (NESearchView *)searchView {
    if (!_searchView) {
        _searchView = [[NESearchView alloc] init];
        _searchView.backgroundColor = [UIColor whiteColor];
        [_searchView ne_setLayerCornerRadius:2.f borderWidth:1 borderColor:kLineColor];
    }
    return _searchView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = kPlaceholderColor;
        _tableView.estimatedRowHeight = 150.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[NSClassFromString(NENewsPlainTextCellIdentifer) class] forCellReuseIdentifier:NENewsPlainTextCellIdentifer];
        [_tableView registerClass:[NSClassFromString(NENewsTreblePictureCellIdentifer) class] forCellReuseIdentifier:NENewsTreblePictureCellIdentifer];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _tableView;
}


- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] init];
    }
    return _searchButton;
}
@end

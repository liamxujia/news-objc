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

// h不引用Cell
@interface NENewsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
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
}

- (void)subviewsLayout {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(30.f);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_viewModel.cellIdentifier forIndexPath:indexPath];
    [cell performSelector:@selector(bindViewModel:)];
    return cell;
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
        _tableView.estimatedRowHeight = 80.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[NSClassFromString(NENewsPlainTextCell) class] forCellReuseIdentifier:NENewsPlainTextCell];
        [_tableView registerClass:[NSClassFromString(NENewsFirstPictureCell) class] forCellReuseIdentifier:NENewsFirstPictureCell];
        [_tableView registerClass:[NSClassFromString(NENewsTreblePictureCell) class] forCellReuseIdentifier:NENewsTreblePictureCell];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _tableView;
}

@end

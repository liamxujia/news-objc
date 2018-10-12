//
//  NESearchView.m
//  LaniOSApp
//
//  Created by stlndm on 2018/6/22.
//  Copyright © 2018年 stlndm. All rights reserved.
//

#import "NESearchView.h"
@interface NESearchView () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextField *searchTextField;
@end

@implementation NESearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = true;
        self.backgroundColor = [UIColor whiteColor];
        [self subviewsLayout];
    }
    return self;
}

- (void)subviewsLayout {
    [self addSubview:self.containerView];
    [self addSubview:self.searchTextField];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.mas_equalTo(30.f);
        make.width.mas_equalTo(kDeviceWidth - 75.f);
    }];
    [_searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.containerView);
        make.right.equalTo(self.containerView).offset(-10.f);
        make.left.equalTo(self.containerView).inset(10.f);
    }];
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.borderStyle = UITextBorderStyleNone;
        _searchTextField.placeholder = @"请输入搜索关键字";
        _searchTextField.textColor = [UIColor blackColor];
        _searchTextField.tintColor = kMainColor;
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.delegate = self;
        _searchSignal = _searchTextField.rac_textSignal;
    }
    return _searchTextField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    !_searchViewBlock ?: _searchViewBlock(textField.text);
    [textField resignFirstResponder];
    return YES;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _searchTextField.placeholder = placeHolder;
}
@end

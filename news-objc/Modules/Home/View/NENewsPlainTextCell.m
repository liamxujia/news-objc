//
//  NENewsPlainTextCell.m
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NENewsPlainTextCell.h"
#import "NENewsViewModel.h"

@interface NENewsPlainTextCell ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *posterLabel;
@property (nonatomic, strong) UILabel *timelineLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation NENewsPlainTextCell
- (void)subviewsLayout {
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.contentLabel];
    [self.containerView addSubview:self.posterLabel];
    [self.containerView addSubview:self.timelineLabel];
    [self.containerView addSubview:self.deleteButton];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10.f, 10.f, 0, 10.f);
        make.edges.equalTo(self.contentView).insets(insets);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).inset(15);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).inset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    [self.posterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.containerView);
    }];
    [self.timelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posterLabel.mas_right).offset(15);
        make.top.equalTo(self.posterLabel);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(15);
        make.top.equalTo(self.posterLabel);
    }];
}

- (void)bindViewModel:(NENewsViewModel *)viewModel {
    [self subviewsLayout];
    self.titleLabel.text = viewModel.title;
    self.contentLabel.text = viewModel.content;
    self.timelineLabel.text = viewModel.timeline;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:@"x" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:kColor(0x999999) forState:UIControlStateNormal];
    }
    return _deleteButton;
}

- (UILabel *)timelineLabel {
    if (!_timelineLabel) {
        _timelineLabel = [[UILabel alloc] init];
    }
    return _timelineLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UILabel *)posterLabel {
    if (!_posterLabel) {
        _posterLabel = [[UILabel alloc] init];
    }
    return _posterLabel;
}
@end

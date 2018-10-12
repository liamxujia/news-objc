//
//  NENewsTreblePictureCell.m
//  news-objc
//
//  Created by stlndm on 2018/10/11.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NENewsTreblePictureCell.h"
#import "UIView+NEAdd.h"
#import "NENewsViewModel.h"
#import "UIImageView+NEAdd.h"

@interface NENewsTreblePictureCell ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *posterLabel;
@property (nonatomic, strong) UILabel *timelineLabel;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIImageView *tonyImageView;
@property (nonatomic, strong) UIImageView *kevinImageView;
@property (nonatomic, strong) UIImageView *zedImageView;
@end

@implementation NENewsTreblePictureCell
- (void)subviewsLayout {
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.contentLabel];
    [self.containerView addSubview:self.tonyImageView];
    [self.containerView addSubview:self.kevinImageView];
    [self.containerView addSubview:self.zedImageView];
    [self.containerView addSubview:self.posterLabel];
    [self.containerView addSubview:self.timelineLabel];
    [self.containerView addSubview:self.deleteButton];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10.f, 10.f, 0, 10.f);
        make.edges.equalTo(self.contentView).insets(insets);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.containerView).inset(15);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView).inset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    [self.tonyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
        make.left.equalTo(self.containerView).inset(15);
        make.height.mas_equalTo(80.f);
        make.width.mas_equalTo((kDeviceWidth - 10 * 2 - 15 * 2 - 5 * 2) / 3);
    }];
    [self.kevinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tonyImageView);
        make.left.equalTo(self.tonyImageView.mas_right).offset(5);
        make.height.width.equalTo(self.tonyImageView);
    }];
    [self.zedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tonyImageView);
        make.left.equalTo(self.kevinImageView.mas_right).offset(5);
        make.height.width.equalTo(self.tonyImageView);
    }];
    [self.posterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tonyImageView.mas_bottom).offset(15);
        make.left.equalTo(self.containerView).inset(15);
        make.bottom.equalTo(self.containerView).inset(15);
    }];
    [self.timelineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.posterLabel.mas_right).offset(15);
        make.top.equalTo(self.posterLabel);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).inset(15);
        make.centerY.equalTo(self.timelineLabel);
    }];
}

- (void)bindViewModel:(NENewsViewModel *)viewModel {
    [self subviewsLayout];
    self.titleLabel.text = viewModel.title;
    self.contentLabel.text = viewModel.content;
    self.posterLabel.text = viewModel.posterName.length ? viewModel.posterName : @"暂无";
    self.timelineLabel.text = viewModel.timeline;
    self.deleteButton.rac_command = viewModel.deleteCommand;
    [viewModel.pictureUrls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                [self.tonyImageView ne_setImageWithURL:obj placeholderImage:nil completion:nil];
                break;
            case 1:
                [self.kevinImageView ne_setImageWithURL:obj placeholderImage:nil completion:nil];
                break;
            case 2:
                [self.zedImageView ne_setImageWithURL:obj placeholderImage:nil completion:nil];
                break;
            default:
                *stop = true;
                break;
        }
    }];
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setTitle:@"boring" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:kPriceColor forState:UIControlStateNormal];
    }
    return _deleteButton;
}

- (UILabel *)timelineLabel {
    if (!_timelineLabel) {
        _timelineLabel = [[UILabel alloc] init];
        _timelineLabel.textColor = kTextDescriptionColor;
        _timelineLabel.font = kFont(12);
    }
    return _timelineLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = kFont(14);
        _contentLabel.textColor = kTextContentColor;
    }
    return _contentLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = kFont(16);
        _titleLabel.textColor = kTextTitleColor;
    }
    return _titleLabel;
}

- (UILabel *)posterLabel {
    if (!_posterLabel) {
        _posterLabel = [[UILabel alloc] init];
        _posterLabel.font = kFont(12);
        _posterLabel.textColor = kTextDescriptionColor;
    }
    return _posterLabel;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        [_containerView ne_setLayerCornerRadius:10.f borderWidth:0 borderColor:nil];
    }
    return _containerView;
}

- (UIImageView *)zedImageView {
    if (!_zedImageView) {
        _zedImageView = [[UIImageView alloc] init];
        _zedImageView.contentMode = UIViewContentModeScaleAspectFill;
        _zedImageView.clipsToBounds = true;
    }
    return _zedImageView;
}

- (UIImageView *)kevinImageView {
    if (!_kevinImageView) {
        _kevinImageView = [[UIImageView alloc] init];
        _kevinImageView.contentMode = UIViewContentModeScaleAspectFill;
        _kevinImageView.clipsToBounds = true;
    }
    return _kevinImageView;
}

- (UIImageView *)tonyImageView {
    if (!_tonyImageView) {
        _tonyImageView = [[UIImageView alloc] init];
        _tonyImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tonyImageView.clipsToBounds = true;
    }
    return _tonyImageView;
}
@end

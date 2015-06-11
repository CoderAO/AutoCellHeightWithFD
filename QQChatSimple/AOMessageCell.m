//
//  AOMessageCell.m
//  QQChat
//
//  Created by 敖然 on 15/6/5.
//  Copyright (c) 2015年 AT. All rights reserved.
//

#import "AOMessageCell.h"
#import "AOMessage.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface AOMessageCell()

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UIButton *textButton;
@end

@implementation AOMessageCell

- (void)awakeFromNib {
    self.textButton.titleLabel.numberOfLines = 0;
}

- (void)setModel:(AOMessage *)model {
    self.contentView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 9999);
    _model = model;

    self.timeLabel.text = _model.time;

    // 处理timeLabel
    if (model.isTimeHidden) {
        self.timeLabel.hidden = YES;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0);
        }];
    }
    else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = _model.time;
        [self.timeLabel updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(21);
        }];
    }

    // 处理按钮
    [self.textButton setTitle:_model.text forState:UIControlStateNormal];
    [self.textButton layoutIfNeeded];
    [self.textButton updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.textButton.titleLabel.frame.size.height + 30);
    }];
}


@end

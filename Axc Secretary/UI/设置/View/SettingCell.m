//
//  SettingCell.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kViceColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // 设置UI
    self.switchOn.onTintColor = kSelectedColor;
    self.switchOn.tintColor = kUncheckColor;
    [self.switchOn addTarget:self action:@selector(changeSwitchState) forControlEvents:UIControlEventValueChanged];
    
    self.disTitleLabel.textColor = kMarkColor;
    self.titleLabel.textColor = kMainTitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)changeSwitchState{
    [self.model trigger];
}

- (void)setModel:(SettingModel *)model{
    _model = model;
    self.accessoryType = _model.accessoryType;
    self.titleLabel.text = _model.title;
    // 设置状态
    self.switchOn.hidden = YES;
    self.disTitleLabel.hidden = YES;
    switch (_model.settingType) {
        case SettingTypeSwitch:{
            self.switchOn.hidden = NO;
            // 匹配开关状态
            self.switchOn.on = _model.switch_on;
        }break;
        case SettingTypeDisTitle:{
            self.disTitleLabel.hidden = NO;
            self.disTitleLabel.text = _model.disTitle;
        }break;

        default:  break;
    }
}

@end

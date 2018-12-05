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
    self.pickTextField.textColor = kMarkColor;
    self.pickTextField.textAlignment = NSTextAlignmentRight;
    self.pickTextField.dropDownMode = IQDropDownModeTextPicker;
    self.pickTextField.delegate = self;
    self.pickTextField.isOptionalDropDown = NO;
    self.pickTextField.pickerView.backgroundColor = kMainBackColor;
    self.pickTextField.dropDownTextColor = kUncheckColor;
//    UIToolbar *toolBar = [self.pickTextField valueForKeyPath:@"dismissToolbar"];
//    toolBar.translucent = NO;
//    toolBar.backgroundColor = kNavColor;
//    toolBar.tintColor = kSelectedColor;
//    toolBar.barTintColor = kSelectedColor;
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
    self.pickTextField.hidden = YES;
    
    switch (_model.settingType) {
        case SettingTypeSwitch:{
            self.switchOn.hidden = NO;
            // 匹配开关状态
            [self.switchOn setOn:_model.switch_on animated:YES];
        }break;
        case SettingTypeDisTitle:{
            self.disTitleLabel.hidden = NO;
            self.disTitleLabel.text = _model.disTitle;
        }break;
        case SettingTypeDisTitleIQDropDownTextField:{
            self.pickTextField.hidden = NO;
            self.pickTextField.itemList = _model.selectArray;
            self.pickTextField.selectedItem = _model.disTitle;
        }break;

        default:  break;
    }
}
-(void)textField:(nonnull IQDropDownTextField*)textField didSelectItem:(nullable NSString*)item{
    self.model.selectRow = textField.selectedRow;
    [self.model trigger];
}

@end


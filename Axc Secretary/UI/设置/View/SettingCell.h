//
//  SettingCell.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/11/23.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : UITableViewCell <IQDropDownTextFieldDelegate>

@property(nonatomic , strong)SettingModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *switchOn;
@property (weak, nonatomic) IBOutlet UILabel *disTitleLabel;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *pickTextField;

@end

NS_ASSUME_NONNULL_END

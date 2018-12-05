//
//  AxcLocation.h
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/5.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//typedef NS_ENUM(NSInteger, AxcLocationPrecision) {
//    AxcLocationPrecisionAccuracyBest,               // 可用最佳准确度
//    AxcLocationPrecisionAccuracyNearestTenMeters,   // 十米
//    AxcLocationPrecisionAccuracyHundredMeters,      // 百米
//    AxcLocationPrecisionAccuracyKilometer,          // 千米
//    AxcLocationPrecisionAccuracyThreeKilometers,    // 三千米
//};

NS_ASSUME_NONNULL_BEGIN


typedef void(^MoLocationSuccess) (double lat, double lng, CLPlacemark *place);
typedef void(^MoLocationFailed) (NSError *error);

@interface AxcLocation : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    MoLocationSuccess successCallBack;
    MoLocationFailed failedCallBack;
}

+ (AxcLocation *) sharedGpsManager;

- (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure;

+ (void) stop;

// 设置页面使用
// 获取当前设置的定位精度
+ (NSString *)getCurrentPositioningAccuracy;

@property(nonatomic , strong , readonly)NSArray *positioningAccuracys;

@end

NS_ASSUME_NONNULL_END

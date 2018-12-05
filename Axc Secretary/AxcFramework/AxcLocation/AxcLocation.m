//
//  AxcLocation.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/12/5.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AxcLocation.h"

@implementation AxcLocation

+ (AxcLocation *) sharedGpsManager {
    static AxcLocation *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[AxcLocation alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if (self) {
        // 打开定位 然后得到数据
        manager = [[CLLocationManager alloc] init];
        manager.delegate = self;
    }
    return self;
}

- (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure {
    successCallBack = [success copy];
    failedCallBack = [failure copy];
    // 停止上一次的
    [manager stopUpdatingLocation];
    
    //控制定位精度,越高耗电量越
    NSDictionary *settingKeys = [self.userDefaults objectForKey:kSettingKeys];
    NSInteger index = [[settingKeys objectForKey:kSetting_PositioningAccuracy] integerValue];
    manager.desiredAccuracy = [self.positioningAccuracys[index] floatValue];
    
    // 兼容iOS8.0版本
    /* Info.plist里面加上2项
     NSLocationAlwaysUsageDescription      Boolean YES
     NSLocationWhenInUseUsageDescription   Boolean YES
     */
    
    // 请求授权 requestWhenInUseAuthorization用在>=iOS8.0上
    // respondsToSelector: 前面manager是否有后面requestWhenInUseAuthorization方法
    // 1. 适配 动态适配
    if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [manager requestWhenInUseAuthorization];
        //            [manager requestAlwaysAuthorization];
    }
    // 2. 另外一种适配 systemVersion 有可能是 8.1.1
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (osVersion >= 8) {
        [manager requestWhenInUseAuthorization];
        //            [manager requestAlwaysAuthorization];
    }
    
    // 开始新的数据定位
    [manager startUpdatingLocation];
}


+ (void) getMoLocationWithSuccess:(MoLocationSuccess)success Failure:(MoLocationFailed)failure {
    [[AxcLocation sharedGpsManager] getMoLocationWithSuccess:success Failure:failure];
}


- (void) stop {
    [manager stopUpdatingLocation];
}

+ (void) stop {
    [[AxcLocation sharedGpsManager] stop];
}

// 每隔一段时间就会调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    CLLocation *newLocation = locations[0];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            for (CLLocation *loc in locations) {
                CLLocationCoordinate2D l = loc.coordinate;
                double lat = l.latitude;
                double lnt = l.longitude;
                self->successCallBack ? self->successCallBack(lat, lnt,place) : nil;
            }
        }
        [manager stopUpdatingLocation];
    }];
    
}

//失败代理方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    failedCallBack ? failedCallBack(error) : nil;
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}



- (NSArray *)positioningAccuracys{
    return @[@(kCLLocationAccuracyBestForNavigation),
             @(kCLLocationAccuracyBest),
             @(kCLLocationAccuracyNearestTenMeters),
             @(kCLLocationAccuracyHundredMeters),
             @(kCLLocationAccuracyKilometer),
             @(kCLLocationAccuracyThreeKilometers)];
}


// 获取当前设置的定位精度
+ (NSString *)getCurrentPositioningAccuracy{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *settingKeys = [NSMutableDictionary dictionaryWithDictionary:[user objectForKey:kSettingKeys]];
    if (![settingKeys objectForKey:kSetting_PositioningAccuracy]) {
        [settingKeys setObject:@(0) forKey:kSetting_PositioningAccuracy];
        [user setObject:settingKeys forKey:kSettingKeys];
    }
    NSInteger index = [[settingKeys objectForKey:kSetting_PositioningAccuracy] integerValue];
    return POSITIONING_ACCURACYS[index];
}


@end

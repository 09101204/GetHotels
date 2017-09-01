//
//  HotelModel.m
//  GetHotels
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HotelModel.h"

@implementation HotelModel
- (instancetype)initWithDictForHotelCell: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.HotelName = [Utilities nullAndNilCheck:dict[@"hotel_name"] replaceBy:@"暂无"];
        self.HotelAdress = [Utilities nullAndNilCheck:dict[@"hotel_address"] replaceBy:@"未知距离"];
        self.Distance = [Utilities nullAndNilCheck:dict[@"distance"] replaceBy:@"未知"];
        self.HotelPrice = [[Utilities nullAndNilCheck:dict[@"price"] replaceBy:0] integerValue];
        self.HotelImage = [Utilities nullAndNilCheck:dict[@"hotel_img"] replaceBy:@""];
        self.adImage = [Utilities nullAndNilCheck:dict[@"ad_img"] replaceBy:@""];
        self.startTime = [Utilities nullAndNilCheck:dict[@"start_time"] replaceBy:@"未知"];
        
    }
    return self;
}
@end

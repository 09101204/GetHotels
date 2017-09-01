//
//  HotelModel.h
//  GetHotels
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelModel : NSObject
@property(strong,nonatomic) NSString *HotelName;
@property(strong,nonatomic) NSString *HotelAdress;
@property(nonatomic) NSInteger HotelPrice;
@property(strong,nonatomic) NSString *Distance;
@property(strong,nonatomic) NSString *HotelImage;
@property(strong,nonatomic) NSString *adImage;
@property(strong,nonatomic) NSString *startTime;
- (instancetype)initWithDictForHotelCell: (NSDictionary *)dict;
@end

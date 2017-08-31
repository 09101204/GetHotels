//
//  CityModel.h
//  GetHotels
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject
@property (strong, nonatomic) NSString *Cityat;
@property (strong, nonatomic) NSMutableArray *Cityarr;
- (instancetype)initWithDictionary: (NSDictionary *)dict;
@end

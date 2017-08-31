//
//  CityModel.m
//  GetHotels
//
//  Created by admin on 2017/8/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
- (instancetype)initWithDictionary: (NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.Cityat = [Utilities nullAndNilCheck:dict[@"at"] replaceBy:@"热门城市"];
        self.Cityarr = [NSMutableArray new];
        if([self.Cityat isEqualToString:@"热门城市"]){
            for(NSString *City in dict[@"hotCity"]){
                [self.Cityarr addObject:[Utilities nullAndNilCheck:City replaceBy:@""]];
            }
            
        }
        else{
            for(NSString *City in dict[@"city"]){
                [self.Cityarr addObject:[Utilities nullAndNilCheck:City replaceBy:@""]];

        }
        
        }
    }
    return self;
}



@end

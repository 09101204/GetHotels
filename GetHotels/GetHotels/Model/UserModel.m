//
//  UserModel.m
//  GetHotels
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _userId = [Utilities nullAndNilCheck:dict[@"userId"] replaceBy:@""];
        _headImage=[Utilities nullAndNilCheck:dict[@"head_img"] replaceBy:@""];
        _idCard=[Utilities nullAndNilCheck:dict[@"id_card"] replaceBy:@"未设置"];
        _nickName=[Utilities nullAndNilCheck:dict[@"nick_name"] replaceBy:@"未命名"];
        _openId=[Utilities nullAndNilCheck:dict[@"openid"] replaceBy:@""];
        _realName=[Utilities nullAndNilCheck:dict[@"reak_name"] replaceBy:@"未知"];
        _startTime=[Utilities nullAndNilCheck:dict[@"start_time"] replaceBy:@""];
        _startTimeStr=[Utilities nullAndNilCheck:dict[@"start_time_str"] replaceBy:@""];
        _state=[[Utilities nullAndNilCheck:dict[@"state"] replaceBy:0] integerValue];
        if([dict[@"gender"] isKindOfClass:[NSNull class]]){
            _gender=@"";
        }
        else{
            switch ([dict[@"gender"] integerValue]) {
                case 1:
                    _gender=@"男";
                    break;
                case 2:
                    _gender=@"女";
                    break;
                default:
                    _gender=@"未设置";
                    break;
            }
        }
    }
    return self;
}


@end

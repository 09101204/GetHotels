//
//  UserModel.h
//  GetHotels
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (strong, nonatomic) NSString *memberId;
@property (strong, nonatomic) NSString *userId;
@property(strong,nonatomic) NSString  *headImage;
@property(strong,nonatomic) NSString *Tel;
@property(strong,nonatomic) NSString *gender;
@property(strong,nonatomic) NSString *idCard;
@property(strong,nonatomic) NSString *nickName;
@property(strong,nonatomic) NSString *startTime;
@property(strong,nonatomic) NSString *startTimeStr;
@property(strong,nonatomic) NSString *realName;
@property(strong,nonatomic) NSString *openId;

@property(nonatomic) NSInteger state;
@property(nonatomic) NSInteger grade;

-(id)initWithDictionary:(NSDictionary *)dict;
@end

//
//  HotelTableViewCell.h
//  GetHotels
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HotelImage;
@property (weak, nonatomic) IBOutlet UILabel *HotelLabel;
@property (weak, nonatomic) IBOutlet UILabel *HotelAdressLabel;
@property (weak, nonatomic) IBOutlet UILabel *HotelDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *SheepLabel;
@property (weak, nonatomic) IBOutlet UILabel *MoneyLabel;

@end

//
//  CityViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/26.
//  Copyright © 2017年 admin. All rights reserved.
//
#import "HotelViewController.h"
#import "CityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityModel.h"
@interface CityViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{
    BOOL firstVisit;
}

@property(strong,nonatomic) CLLocation *location;
@property (weak, nonatomic) IBOutlet UITableView *CityTableView;
@property(strong,nonatomic) NSMutableArray *citiesarr;
@property(strong,nonatomic) NSMutableArray *arr;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _citiesarr = [NSMutableArray new];
    _arr = [NSMutableArray new];
    [self CityRequest];
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _citiesarr.count;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据组的名称作为键，来查询到对应的值（这个值就是这一组城市对应城市数组）
    CityModel *cityModel = _citiesarr[section];
    return cityModel.Cityarr.count;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    //
 CityModel *cityModel = _citiesarr[indexPath.section];
    cell.textLabel.text = cityModel.Cityarr[indexPath.row];
    return cell;
}
//设置组的头标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //根据组的名称作为键，来查询到对应的值（这个值就是这一组城市对应城市数组）
    CityModel *cityModel = _citiesarr[section];
    return cityModel.Cityat;
    
}
//按住细胞以后（取消选择）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //根据组的名称作为键，来查询到对应的值（这个值就是这一组城市对应城市数组）
    CityModel *cityModel = _citiesarr[indexPath.section];
    
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:[NSNotification notificationWithName:@"ResetHome" object:cityModel.Cityarr[indexPath.row]] waitUntilDone:YES];
    //跳转
    [self dismissViewControllerAnimated:YES completion:nil];
     //[self performSegueWithIdentifier:@"cellToHotel" sender:self];
}
    //设置右侧快捷键的栏
    - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
        return _arr;
    }

#pragma mark - Cityrequest
-(void)CityRequest{
    NSDictionary *para = @{@"id":@0};
    [RequestAPI requestURL:@"/findCity"withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
       // NSLog(@"%@", responseObject);
        if ([responseObject[@"result"] integerValue] == 1) {
            NSArray *content = responseObject[@"content"];
            for(NSDictionary *dict in content){
                CityModel *city = [[CityModel alloc]initWithDictionary:dict];
                [_citiesarr addObject:city];
                [_arr addObject:city.Cityat];
               //NSLog(@"%@",_citiesarr);
               // NSLog(@"%@",city);
            }
            [_CityTableView reloadData];
        }
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}*/
  
@end

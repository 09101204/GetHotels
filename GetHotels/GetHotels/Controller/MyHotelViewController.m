//
//  MyHotelViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MyHotelViewController.h"
#import "MineHotelTableViewCell.h"
@interface MyHotelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *MyHotelTableView;
@property (strong, nonatomic) NSArray *MyHotelArr;
@end

@implementation MyHotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
    _MyHotelArr = @[@{@"HotelNameLabel":@"希尔顿酒店套房",@"Image1":@"map_adress",@"Image2":@"my",@"Image3":@"calendar",@"Image4":@"my_hotel",@"AdressLabel":@"厦门市集美区",@"PeopleNumLabel":@"一人入住",@"TimeLabel1":@"2017-2-23",@"TimeLabel2":@"2017-2-25"},@{@"HotelNameLabel":@"希尔顿酒店套房",@"Image1":@"map_adress",@"Image2":@"我的",@"Image3":@"calendar",@"Image4":@"my_hotel",@"AdressLabel":@"厦门市集美区",@"PeopleNumLabel":@"一人入住",@"TimeLabel1":@"2017-2-23",@"TimeLabel2":@"2017-2-25"},@{@"HotelNameLabel":@"希尔顿酒店套房",@"Image1":@"map_adress",@"Image2":@"我的",@"Image3":@"calendar",@"Image4":@"my_hotel",@"AdressLabel":@"厦门市集美区",@"PeopleNumLabel":@"一人入住",@"TimeLabel1":@"2017-2-23",@"TimeLabel2":@"2017-2-25"}];
    //去掉tableview底部多余的线
    _MyHotelTableView.tableFooterView = [UIView new ];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"我的酒店";
    //设置导航条颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    //设置导航条标题颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏.
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}

#pragma mark - table view
//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _MyHotelArr.count;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineHotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHotelcell" forIndexPath:indexPath];
    //根据行号拿到数组中对应的数据
    NSDictionary *dict = _MyHotelArr[indexPath.section];
    cell.HotelNameLabel.text = dict[@"HotelNameLabel"];
    cell.Image1.image = [UIImage imageNamed:dict[@"Image1"]];
    cell.Image2.image = [UIImage imageNamed:dict[@"Image2"]];
    cell.Image3.image = [UIImage imageNamed:dict[@"Image3"]];
    cell.Image4.image = [UIImage imageNamed:dict[@"Image4"]];
    cell.AdressLabel.text = dict[@"AdressLabel"];
    cell.PeopleNumLabel.text = dict[@"PeopleNumLabel"];
    cell.TimeLabel1.text = dict[@"TimeLabel1"];
    cell.TimeLabel2.text = dict[@"TimeLabel2"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  HotelViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HotelViewController.h"
#import "HotelTableViewCell.h"
#import "HotelModel.h"
@interface HotelViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    BOOL firstVisit;
}
@property (strong,nonatomic) NSDictionary *cities;
@property (weak, nonatomic) IBOutlet UIButton *SecectAdressBtn;
@property (strong,nonatomic) NSArray *keys;
@property (weak, nonatomic) IBOutlet UITableView *HotelTableView;
- (IBAction)WeatherBtn:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UIToolbar *Toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *CancelAction;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ConfirmAction;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CityBtn;
@property (strong, nonatomic) NSString *date1;
@property (strong, nonatomic) NSString *date2;

@property (strong, nonatomic) NSMutableArray *HotelArr;


@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _HotelArr = [NSMutableArray new];
   [self naviConfig];
   [self netwodkRequest];
    // Do any additional setup after loading the view.
    /*_HotelArr = @[@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"},@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"},@{@"HotelImage":@"hotels",@"HotelLabel":@"无锡万达喜来登酒店",@"HotelAdressLabel":@"无锡",@"HotelDistanceLabel":@"距离我3.5公里"}];
     */
    //去掉tableview底部多余的线
    _HotelTableView.tableFooterView = [UIView new ];

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
    self.navigationItem.title = @"GetHotels";
    //设置导航条颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
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
    return 1;
}
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _HotelArr.count;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    //根据行号拿到数组中对应的数据
    //NSDictionary *dict = _HotelArr[indexPath.section];
    HotelModel *hotelmodel = _HotelArr[indexPath.row];
    cell.MoneyLabel.text = [NSString stringWithFormat:@"%ld",hotelmodel.HotelPrice];
    //cell.HotelImage.image = [UIImage imageNamed:dict[@"HotelImage"]];
    //NSLog(@"1357%ld",hotelmodel.HotelPrice);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:hotelmodel.HotelImage] placeholderImage:[UIImage imageNamed:@"hotels"]];
    cell.HotelLabel.text = hotelmodel.HotelName;
    cell.HotelAdressLabel.text = hotelmodel.HotelAdress;
    cell.HotelDistanceLabel.text = hotelmodel.Distance;
    return cell;

}
-(void)setDefaultTime{
    //初始化一个日期格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //初始化一个日期格式器
    NSDateFormatter *formatter2 =[[NSDateFormatter alloc] init];
    NSDate *today = [NSDate date];
     //明天的日期
    NSDate *tomorrow = [NSDate dateTomorrow];
    //定义日期的格式为yyyy-MM-dd
    formatter2.dateFormat = @"yyyy-MM-ddTHH:mm:ss.SSSZ";
    formatter.dateFormat = @"yyyy-MM-dd";
    _date1 = [formatter2 stringFromDate:today];
    _date2 = [formatter2 stringFromDate:tomorrow];
    
  

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



  #pragma mark - request

-(void)netwodkRequest{
    //NSDictionary *para = @{@"city_name":@,@"pageNum":@6,@":startId":@1,@"priceId":@2,@"sortingId":@3,@"inTime":_date1,@"outTime":_date2,};
    NSDictionary *para = @{@"id":@1};
    [RequestAPI requestURL:@"/findHotelById"  withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
       //NSLog(@"responseObject: %@", responseObject);
        NSDictionary *dict = responseObject[@"content"];
        HotelModel *model = [[HotelModel alloc] initWithDictForHotelCell:dict];
        [_HotelArr addObject:model];
        NSLog(@"%ld",model.HotelPrice);
        [_HotelTableView reloadData];
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];
}
   - (IBAction)WeatherBtn:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end

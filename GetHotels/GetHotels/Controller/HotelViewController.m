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
#import <CoreLocation/CoreLocation.h>
@interface HotelViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>{
    BOOL firstVisit;
}
@property(strong,nonatomic) CLLocationManager *locMgr;
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
@property (strong, nonatomic) CLLocation *location;



@end

@implementation HotelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _HotelArr = [NSMutableArray new];
   [self naviConfig];
   [self networkRequest];
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
    //NSLog(@"fuck:%@,%@,%@",cell.HotelLabel.text,cell.HotelAdressLabel.text,cell.HotelDistanceLabel.text);
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
- (void)dataInitialize {
    //_avi = [Utilities getCoverOnView:self.view];
    BOOL appInit = NO;
    if ([[Utilities getUserDefaults:@"UserCity"] isKindOfClass:[NSNull class]]) {
        //是第一次打开APP
        appInit = YES;
    } else {
        if ([Utilities getUserDefaults:@"UserCity"] == nil) {
            //第一次打开APP
            appInit = YES;
        }
    }
    if (appInit) {
        //第一次来到页面将默认城市与记忆城市同步
        NSString *userCity = _SecectAdressBtn.titleLabel.text;
        [Utilities setUserDefaults:@"UserCity" content:userCity];
    } else {
        //不是第一次来到APP则将记忆城市与按钮上的城市名反向同步
        NSString *userCity = [Utilities getUserDefaults:@"UserCity"];
        [_SecectAdressBtn setTitle:userCity forState:UIControlStateNormal];
        
    }
    
    firstVisit = YES;
    
    
}

  #pragma mark - request

-(void)networkRequest{
    //NSDictionary *para = @{@"city_name":@,@"pageNum":@6,@":startId":@1,@"priceId":@2,@"sortingId":@3,@"inTime":_date1,@"outTime":_date2,};
    NSDictionary *para = @{@"id":@2};
    [RequestAPI requestURL:@"/findHotelById"  withParameters:para andHeader:nil byMethod:kGet andSerializer:kForm success:^(id responseObject) {
      // NSLog(@"responseObject: %@", responseObject);
        NSDictionary *dict = responseObject[@"content"];
        HotelModel *model = [[HotelModel alloc] initWithDictForHotelCell:dict];
        [_HotelArr addObject:model];
        //NSLog(@"%ld",model.HotelPrice);
        [_HotelTableView reloadData];
    } failure:^(NSInteger statusCode, NSError *error) {
        
    }];
}
   - (IBAction)WeatherBtn:(UIButton *)sender forEvent:(UIEvent *)event {
}
#pragma mark - location

//这个方法专门处理定位的基本设置
- (void)locationConfig {
    //初始化
    _locMgr = [CLLocationManager new];
    //签协议
    _locMgr.delegate = self;
    //识别定位到的设备位移多少距离进行一次识别
    _locMgr.distanceFilter = kCLDistanceFilterNone;
    //设置地球分割成边长多少精度的方块
    _locMgr.desiredAccuracy = kCLLocationAccuracyBest;
}

//这个方法处理开始定位
- (void)locationStart {
    //判断用户有没有选择过是否使用定位
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //询问用户是否愿意使用定位
#ifdef __IPHONE_8_0
        if ([_locMgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            //使用“使用中打开定位”这个策略去运用定位功能
            [_locMgr requestWhenInUseAuthorization];
        }
#endif
    }
    //打开定位服务的开关（开始定位）
    [_locMgr startUpdatingLocation];
    
}
//定位失败时
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error) {
        switch (error.code) {
            case kCLErrorNetwork:
                [Utilities popUpAlertViewWithMsg:@"网络错误" andTitle:nil onView:self onCompletion:^{
                    
                }];
                break;
            case kCLErrorDenied:
                [Utilities popUpAlertViewWithMsg:@"未打开定位" andTitle:nil onView:self onCompletion:^{
                    
                }];
                break;
            case kCLErrorLocationUnknown:
                [Utilities popUpAlertViewWithMsg:@"未知地址" andTitle:nil onView:self onCompletion:^{
                    
                }];
                break;
            default:
                [Utilities popUpAlertViewWithMsg:@"未知错误" andTitle:nil onView:self onCompletion:^{
                    
                }];
                break;
        }
    }
}


//定位成功时
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    //NSLog(@"维度 ：%f",newLocation.coordinate.latitude);
    //NSLog(@"经度 ：%f",newLocation.coordinate.longitude);
    _location = newLocation;
    //用flag思想判断是否可以去根据定位拿到城市
    
    //根据定位拿到城市
    [self getRegeoViaCoordinate];
    
}
- (void)getRegeoViaCoordinate {
    //duration表示从NOW开始过三个SEC
    dispatch_time_t duration = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    //用duration这个设置好的策略去做某件事  GCD = dispatch
    dispatch_after(duration, dispatch_get_main_queue(), ^{
        //正式做事
        CLGeocoder *geo = [CLGeocoder new];
        //反向地理编码
        [geo reverseGeocodeLocation:_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error) {
                //从placemarks中拿到地址信息
                //CLPlacemark *first = placemarks[0];
                CLPlacemark *first = placemarks.firstObject;
                NSDictionary *locDict = first.addressDictionary;
                
                //NSLog(@"locDict = %@",locDict);
                NSString *cityStr = locDict[@"City"];
                cityStr = [cityStr substringToIndex:cityStr.length - 1];
                [[StorageMgr singletonStorageMgr] removeObjectForKey:@"locDict"];
                //将定位到的城市保存进单例化全局变量
                [[StorageMgr singletonStorageMgr] addKey:@"locDict" andValue:cityStr];
                //NSLog(@"city = %@",cityStr);
                if (firstVisit) {
                    firstVisit = !firstVisit;
                    if (![_SecectAdressBtn.titleLabel.text isEqualToString:cityStr]) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"当前定位到的城市为%@,是否切换？",cityStr] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            //修改城市按钮标题
                            [_SelectAdressBtn setTitle:cityStr forState:UIControlStateNormal];
                            //删除记忆体
                            [Utilities removeUserDefaults:@"MemoryCity"];
                            //添加记忆体
                            [Utilities setUserDefaults:@"MemoryCity" content:cityStr];
                            //网络请求
                            [self networkRequest];
                            
                        }];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        [alert addAction:confirm];
                        [alert addAction:cancel];
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }
            }
        }];
        //三秒后关掉开关
        [_locMgr stopUpdatingLocation];
    });
    
}
- (void)checkCityState: (NSNotification *)note {
    NSString *cityStr = note.object;
    if (![_SelectAdressBtn.titleLabel.text isEqualToString:cityStr]) {
        //修改城市按钮标题
        [_SelectAdressBtn setTitle:cityStr forState:UIControlStateNormal];
        //删除记忆体
        [Utilities removeUserDefaults:@"MemoryCity"];
        //添加记忆体
        [Utilities setUserDefaults:@"MemoryCity" content:cityStr];
        //重新执行网络请求
        [self networkRequest];
    }
}

@end

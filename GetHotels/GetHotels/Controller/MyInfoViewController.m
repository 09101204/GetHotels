//
//  MyInfoViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyHotelTableViewCell.h"
@interface MyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *GradeLabel;
@property (weak, nonatomic) IBOutlet UITableView *MyInfoTableView;
@property (strong, nonatomic) NSArray *myInfoArr;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    // Do any additional setup after loading the view.
    _myInfoArr = @[@{@"MyHotelImageView":@"hotel",@"title":@"我的酒店",},@{@"MyHotelImageView":@"plane",@"title":@"我的航空"},@{@"MyHotelImageView":@"我的消息",@"title":@"news"},@{@"MyHotelImageView":@"setting",@"title":@"账户设置"},@{@"MyHotelImageView":@"protocol",@"title":@"使用协议"},@{@"MyHotelImageView":@"contact",@"title":@"联系客服"}];
     //去掉tableview底部多余的线
    _MyInfoTableView.tableFooterView = [UIView new ];
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
    self.navigationItem.title = @"我的";
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
    return _myInfoArr.count;
}

//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//细胞长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyHotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myInfoCell" forIndexPath:indexPath];
    //根据行号拿到数组中对应的数据
    NSDictionary *dict = _myInfoArr[indexPath.section];
    cell.MyHotelImageView.image = [UIImage imageNamed:dict[@"MyHotelImageView"]];
    cell.MyHotelLabel.text = dict[@"title"];
    return cell;
}

//设置组的底部视图高度
/*- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5.f;
    }
    return 1.f;
}*/
//设置细胞高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

//细胞选中后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([Utilities loginCheck])
    switch (indexPath.section) {
        case 0:
            [self performSegueWithIdentifier:@"MyInfotoHotel" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"MyInfotoAnation" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"MyInfotoMessage" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"MyInfotoSet" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"MyInfotoAgreement" sender:self];
            break;
        
        default:
            [self performSegueWithIdentifier:@"MyInfotoCall" sender:self];
            break;
    }
else{
    
    [self performSegueWithIdentifier:@"MyInfotologin" sender:self];
    

}
}
@end

//
//  PayViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PayViewController.h"
#import "PayTableViewCell.h"
#import "HotelDetailViewController.h"

@interface PayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hotelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel1;
@property (weak, nonatomic) IBOutlet UILabel *applyFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMetLabel;
@property (weak, nonatomic) IBOutlet UITableView *tabelView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payAction:(UIButton *)sender forEvent:(UIEvent *)event;
@property(strong,nonatomic)NSArray *arr;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    [self dataInitialize];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)naviConfig{
    //设置导航条标题文字
    self.navigationItem.title = @"支付";
    //设置导航条的颜色（风格颜色）
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    //设置导航条标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    //设置导航条是否隐藏
    self.navigationController.navigationBar.hidden = NO;
    //设置导航条上按钮的风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //设置是否需要毛玻璃效果
    self.navigationController.navigationBar.translucent = YES;
}

//自定的返回按钮的事件
- (void)leftButtonAction: (UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dataInitialize
{
    _arr=@[@"支付宝支付",@"微信支付",@"银联支付"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)uiLayout{
    _hotelLabel.text = _payModel.HotelName;
    _applyFeeLabel.text = [NSString stringWithFormat:@"%@元",_payModel.price];
    self.tabelView.tableFooterView = [UIView new];
    //将表格视图设置为“编辑”
    self.tabelView.editing = YES;
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    //用代码表示视图中的某个cell
    [self.tabelView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paycell" forIndexPath:indexPath];
    cell.textLabel.text=_arr[indexPath.row];
    
    
    return cell;
}
//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}
//设置组的标题文字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"支付方式";
    
}

//设置每一组中每一行的细胞被点击以后要做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //遍历表格试图中所有选中的状态下的细胞
    for (NSIndexPath *eachIP in tableView.indexPathsForVisibleRows)
        //当选中的细胞不是当前正在按的这个细胞的情况下
    {
        if (eachIP!=indexPath) {
            //将细胞从选中状态变为未选中状态
            [tableView deselectRowAtIndexPath:eachIP animated:YES];
        }
        
    }
    
}

- (IBAction)payAction:(UIButton *)sender forEvent:(UIEvent *)event {
    [Utilities popUpAlertViewWithMsg:@"支付超时，请稍后再试" andTitle:@"提示"  onView:self onCompletion:^{
        
    }];
}







@end

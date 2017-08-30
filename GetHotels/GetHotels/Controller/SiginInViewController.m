//
//  SiginInViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SiginInViewController.h"

@interface SiginInViewController ()<UITabBarDelegate>
@property (strong,nonatomic)UIActivityIndicatorView *avi;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *siginBtn;
- (IBAction)siginAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation SiginInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiLayout];
    [self naviConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uiLayout{
    _headImageView.layer.borderColor = [UIColor blueColor].CGColor;
    //判断是否存在记忆体
    if (![[Utilities  getUserDefaults:@"PhoneNum"] isKindOfClass:[NSNull class]]) {
        if ([Utilities  getUserDefaults:@"PhoneNum"] != nil) {
            //将它显示在用户名输入框中
            _phoneNumTextField.text = [Utilities getUserDefaults:@"PhoneNum"];
        }
    }

}

//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"注册会员";
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

//自定的返回按钮的事件
- (void)leftButtonAction: (UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _phoneNumTextField || textField == _pwdTextField || textField == _againPwdTextField) {
        if (_phoneNumTextField.text.length != 0 && _pwdTextField.text.length != 0 && _againPwdTextField.text.length != 0) {
            _siginBtn.enabled =YES;
        }
    }
}
//按键盘的return收回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _phoneNumTextField || textField == _pwdTextField || textField == _againPwdTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

//让根视图结束编辑状态，到达收起键盘的目的
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)siginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if ([_pwdTextField.text isEqualToString:_againPwdTextField.text]) {
        [self signUpRequest];
    }else{
        [Utilities popUpAlertViewWithMsg:@"密码输入不一致，请重新输入" andTitle:@"提示" onView:self onCompletion:^{
            _pwdTextField.text = @"";
            _againPwdTextField.text = @"";
        }];
    }
}

- (void)signUpRequest{
    // 创建菊花膜
    _avi = [Utilities getCoverOnView:self.view];
    NSDictionary *para=@{@"tel":_phoneNumTextField.text,@"pwd":_pwdTextField.text};
    //开始请求
    [RequestAPI requestURL:@"/register" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        NSLog(@"注册：%@", responseObject);
        if([responseObject[@"result"] integerValue] == 1){
            [Utilities popUpAlertViewWithMsg:@"注册成功" andTitle:nil onView:self onCompletion:^{
                [self performSegueWithIdentifier:@"signUpToLogin" sender:self];
            }];
        }else{
            //业务逻辑失败的情况下
            NSString *errorMsg = [ErrorHandler getProperErrorString:[responseObject[@"result"] integerValue]];
            [Utilities popUpAlertViewWithMsg:errorMsg andTitle:nil onView:self onCompletion:^{
                
            }];
        }
        
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        NSLog(@"%ld",(long)statusCode);
        [Utilities popUpAlertViewWithMsg:@"请保持网络连接畅" andTitle:nil onView:self onCompletion:^{
            
        }];
        
    }];
    
}










@end

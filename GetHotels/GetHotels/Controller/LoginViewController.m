//
//  LoginViewController.m
//  GetHotels
//
//  Created by admin on 2017/8/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "UserModel.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)UIActivityIndicatorView *avi;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self naviConfig];
    _loginBtn.enabled = NO;
    _loginBtn.backgroundColor = UIColorFromRGB(200, 200, 200);
    //添加事件，监听当输入框的内容改变时调用textChange的方法
    [_phoneNumTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [_pwdTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//当textField结束编辑的时候调用
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField == _phoneNumTextField || textField == _pwdTextField){
        //当用户名和密码都输入后，按钮才能被点击
        if(_phoneNumTextField.text.length != 0 && _pwdTextField.text.length !=0){
            _loginBtn.enabled = YES;
        }
    }
    
}

//输入框内容改变的监听事件
- (void)textChange:(UITextField *)textField{
    //当文本框中的内容改变时判断内容长度是否为0，是：启用按钮，否：禁用按钮
    if(_phoneNumTextField.text.length != 0 && _pwdTextField.text.length != 0){
        _loginBtn.enabled = YES;
        _loginBtn.backgroundColor = UIColorFromRGB(99, 163, 210);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor = UIColorFromRGB(153, 153, 153);
    }
}


//当前页面将要显示的时候，显示导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)naviConfig {
    //设置导航条标题文字
    self.navigationItem.title = @"会员登录";
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

//用model的方式返回上一页
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//键盘收回
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //让根视图结束编辑状态达到收起键盘的目的
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _phoneNumTextField || textField == _pwdTextField){
        [textField resignFirstResponder];
    }
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(UIButton *)sender forEvent:(UIEvent *)event {
    if(_phoneNumTextField.text.length==0 ||_phoneNumTextField.text.length<11){
        [Utilities popUpAlertViewWithMsg:@"请输入有效的手机号" andTitle:nil onView:self onCompletion:^{
            
        }];
        return;
    }
    if(_pwdTextField.text.length==0)
    {
        [Utilities popUpAlertViewWithMsg:@"请输入密码" andTitle:nil onView:self onCompletion:^{
            
        }];
        return;
    }
    if(_pwdTextField.text.length<6||_pwdTextField.text.length>18){
        [Utilities popUpAlertViewWithMsg:@"您输入的密码必须在6到18位之间" andTitle:nil onView:self onCompletion:^{
            
        }];
        return;
    }
    //判断电话号码是否都是数字
    NSCharacterSet *notDigits=[[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    if(_phoneNumTextField.text.length<11||[_phoneNumTextField.text rangeOfCharacterFromSet:notDigits].location!=NSNotFound){
        [Utilities popUpAlertViewWithMsg:@"请输入有效手机号" andTitle:nil onView:self onCompletion:^{
            
        }];
    }
    //确认无误后，执行网络请求
    [self signInRequest];

    
}

#pragma mark - request
-(void)signInRequest{
    _avi=[Utilities getCoverOnView:self.view];
    NSDictionary *para=@{@"tel":_phoneNumTextField.text,@"pwd":_pwdTextField.text};
    [RequestAPI requestURL:@"/login" withParameters:para andHeader:nil byMethod:kPost andSerializer:kForm success:^(id responseObject) {
        [_avi stopAnimating];
        if([responseObject[@"result"] integerValue]==1){
            NSLog(@"登录：%@",responseObject[@"content"]);
            NSDictionary *result=responseObject[@"content"];
            UserModel *user= [[UserModel alloc]initWithDictionary:result];
            [[StorageMgr singletonStorageMgr]addKey:@"UserInfo" andValue:user];
            [[StorageMgr singletonStorageMgr]addKey:@"MemberId" andValue:user.userId];
            [self.view endEditing:YES];
            _pwdTextField.text=@"";
            [Utilities setUserDefaults:@"UserTel" content:_phoneNumTextField.text];
            [self performSegueWithIdentifier:@"loginToMy" sender:self];
        }
        else{
            NSString *errorMsg=[ErrorHandler getProperErrorString:[responseObject[@"resultFlag"]integerValue]];
            [Utilities popUpAlertViewWithMsg:@"密码错误！" andTitle:errorMsg onView:self onCompletion:^{
                
            }];
        }
        
    } failure:^(NSInteger statusCode, NSError *error) {
        [_avi stopAnimating];
        NSLog(@"%ld",(long)statusCode);
        [Utilities popUpAlertViewWithMsg:@"网络错误，请稍后再试!" andTitle:@"提示" onView:self onCompletion:^{
            
        }];
        
    }];
}









@end

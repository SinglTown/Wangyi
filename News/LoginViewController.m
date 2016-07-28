//
//  LoginViewController.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "LoginViewController.h"
#import "LineView.h"
#import "RegisterViewController.h"
#import "CoreDataHandle.h"
#import "User.h"
@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;

@end

@implementation LoginViewController
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        LineView *firstLineView = [[LineView alloc] init];
//        firstLineView.backgroundColor = [UIColor whiteColor];
//        firstLineView.frame = self.view.frame;
//        [self.view addSubview:firstLineView];
//        [firstLineView setNeedsDisplay];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.view.alpha = 1;

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)backAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButtonAction:(id)sender {
    
    NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"User"];
    NSLog(@"%@",array);
    NSMutableArray *nameArray = [NSMutableArray array];
    NSMutableArray *passWordArray = [NSMutableArray array];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    for (User *user in array) {
        [userDic setValue:user.pass_word forKey:user.name];
        [nameArray addObject:user.name];
        [passWordArray addObject:user.pass_word];
    }
    NSLog(@"%@",userDic);
    if (![nameArray containsObject:self.nameTextField.text] || self.passWordTextField.text != [userDic valueForKey:self.nameTextField.text]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名不存在或者密码错误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeValue" object:nil];
    }
}

- (IBAction)registerButtonAction:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  RegisterViewController.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "CoreDataHandle.h"
@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassWordTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *mailTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
}
- (IBAction)clickRegisterButtonAction:(id)sender {
    
    NSArray *userArray = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"User"];
    NSLog(@"%@",userArray);
    NSMutableArray *nameArray = [NSMutableArray array];
    for (User *user in userArray) {
        [nameArray addObject:user.name];
    }
    NSLog(@"=======%@",nameArray);
    if ([self.nameTextField.text isEqualToString:@""] || [self.passWordTextField.text isEqualToString:@""]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"姓名或者密码为空,注册失败" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else if (self.passWordTextField.text != self.confirmPassWordTextField.text){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入密码不一致,注册失败" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else if ([nameArray containsObject:self.nameTextField.text]){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名已存在.请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }else{
        [[CoreDataHandle sharedCoreDataHandle] insertUserInforDataWithName:self.nameTextField.text withPassWord:self.passWordTextField.text withNumber:self.phoneNumberTextField.text withMail:self.mailTextField.text];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

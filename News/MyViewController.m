//
//  MyViewController.m
//  WangYi
//
//  Created by lanou3g on 15/12/17.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "MyViewController.h"
#import "LoginView.h"
#import "MyDetailViewController.h"
#import "LoginViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isLogin;
}
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong)NSArray *myDataArray;

@property (nonatomic,strong)LoginView *loginView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    self.myDataArray = @[@"收藏",@"离线",@"浏览历史",@"清除缓存"];
    
    //注册一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValueAction:) name:@"changeValue" object:nil];
    
    _isLogin = NO;
}
#pragma mark - 实现通知方法
-(void)changeValueAction:(NSNotification *)sender
{
    [self.loginView.loginButton setTitle:@"注销" forState:UIControlStateNormal];
    _isLogin = YES;
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.myDataArray[indexPath.row];
    return cell;
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        MyDetailViewController *myDetailVC = [[MyDetailViewController alloc] init];
        myDetailVC.title = self.myDataArray[indexPath.row];
        [self.navigationController pushViewController:myDetailVC animated:YES];
    }else if (indexPath.row == 3){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:confirmAction];
        [self presentViewController:alertVC animated:YES completion:nil];

    }
}
#pragma mark - header的View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];
    self.loginView.backgroundColor = [UIColor redColor];
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return self.loginView;
}
-(void)loginButtonAction:(UIButton *)sender
{
    if (_isLogin == NO) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *loginNC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        loginVC.title = @"登录";
        loginNC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:loginNC animated:YES completion:nil];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _isLogin = NO;
            [self.loginView.loginButton setTitle:@"立即登陆" forState:UIControlStateNormal];
        }];
        [alertVC addAction:cancelAction];
        [alertVC addAction:confirmAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
#pragma mark - header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
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

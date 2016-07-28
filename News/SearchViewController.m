//
//  SearchViewController.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "SearchViewController.h"
#import "News.h"
#import "CoreDataHandle.h"
#import "DetailViewController.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *searchTableView;

@property (nonatomic,strong)NSMutableArray *searchDataArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-return.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    
    self.searchBar.delegate = self;
    
}
#pragma mark - UISearchBarDelegate 代理方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchDataArray removeAllObjects];
    NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"News"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[cd] %@",searchBar.text];
    self.searchDataArray = [[array filteredArrayUsingPredicate:predicate] mutableCopy];
    [self.searchTableView reloadData];
    [self.searchBar resignFirstResponder];
}
#pragma mark - 返回事件
-(void)backAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.searchBar endEditing:YES];
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchDataArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    News *news = self.searchDataArray[indexPath.row];
    cell.textLabel.text = news.title;
    return cell;
}
#pragma mark - cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    News *news = self.searchDataArray[indexPath.row];
    detailVC.urlString = news.url;
    [self.navigationController pushViewController:detailVC animated:YES];
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

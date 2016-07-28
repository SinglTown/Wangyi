//
//  MyDetailViewController.m
//  News
//
//  Created by lanou3g on 15/12/22.
//  Copyright © 2015年 chuanbao. All rights reserved.
//

#import "MyDetailViewController.h"
#import "CoreDataHandle.h"
#import "History.h"
#import "DetailViewController.h"
#import "DetailPictureViewController.h"
#import "NewsDataManager.h"
#import "NewsModel.h"
@interface MyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *historyTitleArray;

@property (nonatomic,strong)NSMutableDictionary *historyDic;
@property (strong, nonatomic) IBOutlet UITableView *myDetailTableView;

@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"History"];
    NSMutableArray *titleArray = [NSMutableArray array];
    self.historyDic = [NSMutableDictionary dictionary];
    for (History *history in array) {
        [titleArray addObject:history.title];
        [self.historyDic setValue:history.url forKey:history.title];
    }
    NSSet *titleSet = [NSSet setWithArray:titleArray];
    self.historyTitleArray = [titleSet allObjects];
    
    self.myDetailTableView.dataSource = self;
    self.myDetailTableView.delegate = self;
    
    //删除所有
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"删除所有" style:UIBarButtonItemStylePlain target:self action:@selector(deleteAllHistory:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark - 执行方法deleteAllHistory
-(void)deleteAllHistory:(UIBarButtonItem *)sender
{
    self.historyTitleArray = nil;
    [self.myDetailTableView reloadData];
    [[CoreDataHandle sharedCoreDataHandle] deleteAllNewsDataWithString:@"History"];
}
#pragma mark - 设置row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyTitleArray.count;
}
#pragma mark - 设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.historyTitleArray[indexPath.row];
    
    return cell;
}
#pragma mark - 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *allNewsArray = [NewsDataManager sharedNewsDataManager].headerNewsDataArray;
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSArray *historyArray = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"History"];
//    NSString *title = self.historyTitleArray[indexPath.row];
//    for (History *history in historyArray) {
//        if ([title isEqualToString:history.title]) {
//            if (history.image != nil) {
//                DetailPictureViewController *pictureVC = [[DetailPictureViewController alloc] init];
//                pictureVC.imageTitle = title;
//                [self.navigationController pushViewController:pictureVC animated:YES];
//                
//            }else{
//                DetailViewController *detailVC = [[DetailViewController alloc] init];
//                
//                detailVC.urlString = [self.historyDic valueForKey:title];
//                [self.navigationController pushViewController:detailVC animated:YES];
//            }
//        }
//    }
    
    
    NSArray *allNewsArray = [NewsDataManager sharedNewsDataManager].headerNewsDataArray;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *historyArray = [[CoreDataHandle sharedCoreDataHandle] searchAllNewsDataWithString:@"History"];
    NSString *title = self.historyTitleArray[indexPath.row];
    for (History *history in historyArray) {
        if ([title isEqualToString:history.title]) {
            for (NewsModel *model in allNewsArray) {
                if ([title isEqualToString:model.title]) {
                    if (model.imgextra != nil) {
                        DetailPictureViewController *pictureVC = [[DetailPictureViewController alloc] init];
                        pictureVC.imageTitle = title;
                        NSMutableArray *picArray = [NSMutableArray array];
                        for (NSDictionary *dic in picArray) {
                            [picArray addObject:[dic valueForKey:@"imgsrc"]];
                        }
                        NSLog(@"===========%@",model.title);
                        pictureVC.picArray = picArray;
                        [self.navigationController pushViewController:pictureVC animated:YES];
                    }else{
                        DetailViewController *detailVC = [[DetailViewController alloc] init];
                        
                        detailVC.urlString = [self.historyDic valueForKey:title];
                        [self.navigationController pushViewController:detailVC animated:YES];
                    }
                }
            }
         }
    }

    
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

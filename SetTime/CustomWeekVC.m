//
//  CustomWeekVC.m
//  FarbenSmartHome
//
//  Created by 唐林 on 2018/10/24.
//  Copyright © 2018年 唐林. All rights reserved.
//

#import "CustomWeekVC.h"


#define kTableViewCellReuseID @"customCell"
@interface CustomWeekVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *titleArr1;
   
    
}
@property (nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *selectIndexs;

@end

@implementation CustomWeekVC
-(instancetype)init
{
    if (self=[super init]) {
    
        
        _selectIndexs = [NSMutableArray new];
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"user_defined", nil);
    self.view.backgroundColor = fistColor;
    titleArr1 = @[NSLocalizedString(@"sunday", nil),NSLocalizedString(@"monday", nil),NSLocalizedString(@"tuesday", nil),NSLocalizedString(@"wednesday", nil),NSLocalizedString(@"thursday", nil),NSLocalizedString(@"friday", nil),NSLocalizedString(@"saturday", nil)];
    [self customTableView];
    [self BarButtonItem];//保存
    
    
}
-(void)BarButtonItem
{
    UIButton *guizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    guizeBtn.frame = CGRectMake(0, 0, 26, 20);
    [guizeBtn setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
    guizeBtn.tintColor = [UIColor whiteColor];
    guizeBtn.contentMode = UIViewContentModeScaleAspectFit;
    [guizeBtn addTarget:self action:@selector(saveChecked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:guizeBtn];
    
}
-(void)saveChecked:(UIButton *)sender
{
    
    if (_selectIndexs.count == 0) {
        [JRToast showWithText:NSLocalizedString(@"at_least_one_day", nil) bottomOffset:100.f duration:3.0f];
        return;
    }
//    for (NSDictionary *row in _selectIndexs) {
//        NSLog(@"%@",row[@"path"]);
//    }
    NSLog(@"%@",_selectIndexs);
    
   
    
    [self.navigationController popViewControllerAnimated:NO];
      _clickDateBack(_selectIndexs);
    
    
}
- (void)clickDateBack:(void(^)(NSArray *dataArr))block
{
    _clickDateBack = block;
}
-(void)customTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = fistColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return  titleArr1.count;
    
}
#pragma mark ===每一个分组下对应的tableview 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseID];
    
    if (cell == nil) {
        // 如果复用池没有对应的Cell，就去生成一个Cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableViewCellReuseID];
    }
    cell.backgroundColor = thirdColor;
    cell.textLabel.text = [titleArr1 objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, SCREEN_WIDTH , 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:lineView];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置勾
    cell.accessoryType = UITableViewCellAccessoryNone;
    for (NSIndexPath *index in _selectIndexs) {
        if (index == indexPath) { //改行在选择的数组里面有记录
            cell.accessoryType = UITableViewCellAccessoryCheckmark; //打勾
            break;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //获取到点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) { //如果为选中状态
        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
        [_selectIndexs removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]]; //数据移除
    }else { //未选中
        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
        [_selectIndexs addObject:[NSString stringWithFormat:@"%ld",indexPath.row]]; //添加索引数据到数组
    }
    
    
}



@end

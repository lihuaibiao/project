//
//  TimeSelectVC.m
//  FarbenSmartHome
//
//  Created by 唐林 on 2018/10/24.
//  Copyright © 2018年 唐林. All rights reserved.
//

#import "TimeSelectVC.h"
#import "CustomWeekVC.h"


#define kTableViewCellReuseID @"chongfuCell"
@interface TimeSelectVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *titleArr1;
    
}


@property (nonatomic,strong) UITableView *tableView;
@end

@implementation TimeSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"repetition", nil);
    self.view.backgroundColor = fistColor;
     titleArr1 = @[NSLocalizedString(@"only_once", nil),NSLocalizedString(@"everyday", nil),NSLocalizedString(@"weekdays", nil),NSLocalizedString(@"user_defined", nil)];
    [self RepeatTableView];
//    [self BarButtonItem];//保存
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
    
    
    
}
-(void)RepeatTableView
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
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        
        CustomWeekVC *custom = [[CustomWeekVC alloc]init];
        
        [custom clickDateBack:^(NSArray *dataArr) {
             [self.navigationController popViewControllerAnimated:NO];
            self->_clickDateBack(dataArr);
        }];
        
        [self.navigationController pushViewController:custom animated:YES];
        
        
    }else{
        
        _block(titleArr1[indexPath.row]);
        [self.navigationController popViewControllerAnimated:NO];

    }
    
}
- (void)clickDateBack:(void(^)(NSArray *dataArr))block
{
    _clickDateBack = block;
}

@end

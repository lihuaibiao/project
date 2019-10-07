//
//  SetTimeVC.m
//  FarbenSmartHome
//
//  Created by 唐林 on 2018/10/23.
//  Copyright © 2018年 唐林. All rights reserved.
///Users/唐林/Documents/smart_home_ios/FarbenSmartHome/Classes/Main

#import "SetTimeVC.h"
#import "YLAlartView.h"
#import "ClockTableViewCell.h"
#import "TimeSelectVC.h"

@interface SetTimeVC ()<YLAlartViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *detailLabelStr;
    
    NSMutableArray *dateRepeat;
}

@property (nonatomic, strong)YLAlartView *alertView;
@property (nonatomic, copy)NSString *clockDate;
@property (nonatomic, copy)NSString *hours;
@property (nonatomic, copy)NSString *minutes;

@property (nonatomic, strong) UITableView *TableView;
//列表Arr
@property(strong,nonatomic)NSArray *array;

@end
static NSString *const clockCellID=@"clockCellID";
@implementation SetTimeVC

-(instancetype)init
{
    if (self=[super init]) {
        
         self.array=@[NSLocalizedString(@"repetition", nil)];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"timing_task", nil);
    self.view.backgroundColor = fistColor;
    
    detailLabelStr = NSLocalizedString(@"only_once", nil);
    [self addAlertView];//闹钟
    [self addTableView];
    [self BarButtonItem];//保存
    
}
-(void)addTableView
{
    self.TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 235, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.TableView.backgroundColor = fistColor;
    self.TableView.dataSource = self;
    self.TableView.delegate = self;
    // 注册的时候，需要换成我们自己的Cell
    [self.TableView registerClass:[ClockTableViewCell class] forCellReuseIdentifier:clockCellID];
    [self.view addSubview:self.TableView];
     self.TableView.tableFooterView = [UIView new];//尾部
    self.TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.TableView.scrollEnabled = NO;
    
}
- (void)addAlertView{
    self.alertView = [[YLAlartView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 215)];
    self.alertView.backgroundColor = thirdColor;
    self.alertView.delegate = self;
    [self.view addSubview:self.alertView];
}

-(void)BarButtonItem
{
    
     [self getCurrentTime];
    
    UIButton *guizeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    guizeBtn.frame = CGRectMake(0, 0, 26, 20);
    [guizeBtn setTitle:NSLocalizedString(@"save", nil) forState:UIControlStateNormal];
    guizeBtn.tintColor = [UIColor whiteColor];
    guizeBtn.contentMode = UIViewContentModeScaleAspectFit;
    [guizeBtn addTarget:self action:@selector(saveChecked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:guizeBtn];
    
}
- (void)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.hours = [dateFormatter stringFromDate:date];
    self.hours = [self.hours substringWithRange:NSMakeRange(11, 2)];
    self.minutes = [dateFormatter stringFromDate:date];
    self.minutes = [self.minutes substringWithRange:NSMakeRange(14, 2)];
    
}
-(void)saveChecked:(UIButton *)sender
{
     [self.navigationController popViewControllerAnimated:NO];
    NSString *scheRepeat;
    if ([detailLabelStr isEqualToString:NSLocalizedString(@"only_once", nil)]) {
        scheRepeat = @"1";
    }else if ([detailLabelStr isEqualToString:NSLocalizedString(@"everyday", nil)]){
        scheRepeat = @"2";
    }else if ([detailLabelStr isEqualToString:NSLocalizedString(@"weekdays", nil)]){
        scheRepeat = @"3";
    }
    
    if (dateRepeat.count != 0) {
        scheRepeat = @"4";
    }

    if (self.clockDate != nil) {
        NSLog(@"%@",self.clockDate);

    }else{
       self.clockDate = [NSString stringWithFormat:@"%d:%d", [self.hours intValue], [self.minutes intValue]];
        
    }
    NSLog(@"%@",self.clockDate);
    

    NSString *timeClockDate = [NSString stringWithFormat:@"%@:00",self.clockDate];
    
    NSLog(@"%@",timeClockDate);
    
    NSDictionary *biSceneScheduleTEntity;
    if (dateRepeat.count != 0) {
        scheRepeat = @"4";
        
      NSString *riqiStr = [dateRepeat componentsJoinedByString:@","];
        
        biSceneScheduleTEntity = @{@"scheRepeat":scheRepeat, @"scheOpTime":timeClockDate,@"scheFavWeekday":riqiStr};
    }else{
        biSceneScheduleTEntity = @{@"scheRepeat":scheRepeat, @"scheOpTime":timeClockDate};
    }

    NSLog(@"%@",biSceneScheduleTEntity);
    
    
//    NSDictionary *biSceneScheduleTEntity = @{@"scheRepeat":scheRepeat, @"scheOpTime":timeClockDate};
    
    _clickDicBack(biSceneScheduleTEntity);
}
- (void)clickDicBack:(void(^)(NSDictionary *biSceneScheduleTEntity))block
{
    _clickDicBack = block;
}

- (void)sendDateWithData:(NSString *)data{
    self.clockDate = data;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    return view;
}
//每个分组上边预留的空白高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//设置每个分组下tableview的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
//设置每行对应的cell（展示的内容）
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clockCellID forIndexPath:indexPath];
     cell.backgroundColor = thirdColor;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     cell.titleLabel.text = self.array[indexPath.row];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
     cell.detailLabel.text = detailLabelStr;
    return cell;
    
}
//每一个分组下对应的tableview 高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TimeSelectVC *repeat = [[TimeSelectVC alloc]init];
    repeat.block = ^(NSString *deliverStr){
        self->detailLabelStr = deliverStr;
        [self.TableView reloadData];
    };
    
    [repeat clickDateBack:^(NSArray *dataArr) {
        NSLog(@"%@",dataArr);
       
        self->dateRepeat = [[NSMutableArray alloc]initWithArray:dataArr];
        self->detailLabelStr =[dateRepeat componentsJoinedByString:@","];
        [self.TableView reloadData];
    }];

    [self.navigationController pushViewController:repeat animated:YES];
    
}


@end

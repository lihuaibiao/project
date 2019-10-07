//
//  YLAlartView.m
//  YLAlarmClock
//
//  Created by Bing on 16/6/30.
//  Copyright © 2016年 Yang. All rights reserved.
//

#import "YLAlartView.h"

@interface YLAlartView()

@property (nonatomic, copy)NSString *hours;
@property (nonatomic, copy)NSString *minutes;
@property (nonatomic, strong)NSArray *dateArray;

@end

@implementation YLAlartView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        [self initWithData];
        [self createPickerView];
    }
    return self;
}

- (void)initWithData{
    self.data1 = [NSMutableArray array];
    self.data2 = [NSMutableArray array];
    
    for (int i = 0; i < 24; i++) {
        [self.data1 addObject:[NSString stringWithFormat:@"%2d", i]];
    }
    for (int i = 0; i < 60; i++) {
        [self.data2 addObject:[NSString stringWithFormat:@"%2d", i]];
    }

    
    self.dateArray = [[NSArray alloc] initWithObjects:self.data1, self.data2, nil];
    [self getCurrentTime];
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

- (void)createPickerView{
    self.pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
//    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
    //显示当前的时间
    [self.pickerView selectRow:[self.hours intValue] inComponent:0 animated:YES];
    [self.pickerView selectRow:[self.minutes intValue] inComponent:1 animated:YES];
}

//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dateArray.count;
}

//每个列的个数 乘100的目的是让它循环滚动
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray *array = self.dateArray[component];
    return array.count;
}

//每个列的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//每列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *array = self.dateArray[component];
    NSString *titleString = array[row];
    return titleString;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:20.f];
        label.textColor = [UIColor whiteColor];
    }
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    //隐藏上下直线
    
//  　[self.pickerView .subviews objectAtIndex:1].backgroundColor = [UIColor whiteColor];
//    
//    [self.pickerView .subviews objectAtIndex:2].backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", label.text);
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *selectSecond = [self.data2 objectAtIndex:[pickerView selectedRowInComponent:1]];
    NSString *selectFirst = [self.data1 objectAtIndex:[pickerView selectedRowInComponent:0]];
    self.titleDate = [NSString stringWithFormat:@"%@:%@", selectFirst, selectSecond];
    NSLog(@"%@***********%@",selectFirst, selectSecond);
    if ([self.delegate respondsToSelector:@selector(sendDateWithData:)]) {
        [self.delegate sendDateWithData:self.titleDate];
    }
}



@end

//
//  CVDatePickerView.m
//  iQBTeacher
//
//  Created by Yuanhai on 12/6/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVDatePickerView.h"

#define ItemHeight 40.0f
#define ToolViewHeight 46.0f
#define pickerViewHeight 216.0f

#define MAXYEAR 2030
#define MINYEAR 1938
#define MAXYEARNOLIMIT 2099
#define MINYEARNOLIMIT 0

#define CVDateFormat @"yyyy年-MM月-dd日"
#define CVDateFormatNoLimit @"yyyy年-MM月-dd日 HH时:mm分"

@interface CVDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSMutableArray *_yearArray;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_minuteArray;
    // 记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSInteger hourIndex;
    NSInteger minuteIndex;
    // 年份约束
    NSInteger minYear;
    NSInteger maxYear;
}

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *toolView;
@property (strong, nonatomic) UILabel *toolTitleLabel;
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation CVDatePickerView

- (id)initWithDateStyle:(CVDateStyle)dateStyle
{
    self = [super init];
    if (self)
    {
        // Frame
        self.frame = MainAppDelegate.window.bounds;
        
        // Back Color
        self.backgroundColor = PopViewBackColor;
        
        // 默认年月日
        self.dateStyle = dateStyle;
        
        // 其他地方点击
        [self addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self layoutMainView];
        
        [self defaultConfig];
    }
    return self;
}

- (void)show
{
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    [UIView animateWithDuration:controller_animate_duration
                     animations:^
     {
         self.backView.frame = CGRectMake(0.0f, self.frame.size.height - pickerViewHeight - ToolViewHeight, self.frame.size.width, pickerViewHeight + ToolViewHeight);
     } completion:nil];
    
    // 滚动到指定位置
    [self getNowDate:self.scrollToDate animated:YES];
}

- (void)defaultConfig
{
    // 设置年月日时分数据
    _yearArray = [self setArray:_yearArray];
    _monthArray = [self setArray:_monthArray];
    _dayArray = [self setArray:_dayArray];
    _hourArray = [self setArray:_hourArray];
    _minuteArray = [self setArray:_minuteArray];
    
    // 年
    minYear = MINYEAR;
    maxYear = MAXYEAR;
    if (self.dateStyle == DateStyleShowYearMonthDayHourMinute)
    {
        minYear = MINYEARNOLIMIT;
        maxYear = MAXYEARNOLIMIT;
    }
    for (NSInteger i = minYear; i <= maxYear; i++)
    {
        NSString *num = [NSString stringWithFormat:@"%ld年",(long)i];
        [_yearArray addObject:num];
    }
    
    // 月
    for (int i = 1; i <= 12; i++)
    {
        NSString *num = [NSString stringWithFormat:@"%02d月", i];
        [_monthArray addObject:num];
    }
    
    // 时
    for (int i = 0; i <= 23; i++)
    {
        NSString *num = [NSString stringWithFormat:@"%02d时", i];
        [_hourArray addObject:num];
    }
    
    // 分
    for (int i = 0; i < 60; i++)
    {
        if (i % 5 == 0)
        {
            NSString *num = [NSString stringWithFormat:@"%02d分", i];
            [_minuteArray addObject:num];
        }
    }
}

#pragma mark - Layout

- (void)layoutMainView
{
    // Back
    self.backView = [[UIView alloc] init];
    self.backView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, pickerViewHeight + ToolViewHeight);
    self.backView.backgroundColor = WhiteColor;
    [self addSubview:self.backView];
    
    float pickerWidth = self.backView.frame.size.width * 0.9;
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = CGRectMake((self.backView.width - pickerWidth) / 2, ToolViewHeight, pickerWidth, pickerViewHeight);
    self.pickerView.backgroundColor = WhiteColor;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.backView addSubview:self.pickerView];
    
    // ToolView
    self.toolView = [[UIView alloc] init];
    self.toolView.frame = CGRectMake(0.0f, 0.0f, self.backView.frame.size.width, ToolViewHeight);
    self.toolView.backgroundColor = PurityColor(239);
    [self.backView addSubview:self.toolView];
    
    // Buttons
    float buttonWidth = getUIValue(80.0f);
    float itemWidthSpacing = 0.0f;
    // 完成
    CVParentButton *okButton = [[CVParentButton alloc] init];
    [okButton addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    okButton.frame = CGRectMake(self.toolView.width - itemWidthSpacing - buttonWidth, 0.0f, buttonWidth, self.toolView.height);
    [okButton setTitle:@"完成" forState:UIControlStateNormal];
    [okButton setTitleColor:MainRoseRedColor forState:UIControlStateNormal];
    [okButton setTitleColor:LightGreyColor forState:UIControlStateHighlighted];
    okButton.titleLabel.font = AppleFont_UltraLight(18);
    [self.toolView addSubview:okButton];
    // 取消
    CVParentButton *cancelButton = [[CVParentButton alloc] init];
    [cancelButton addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(itemWidthSpacing, 0.0f, buttonWidth, self.toolView.height);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:MainRoseRedColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:LightGreyColor forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = AppleFont_UltraLight(18);
    [self.toolView addSubview:cancelButton];
    
    // Title
    self.toolTitleLabel = [[UILabel alloc] init];
    self.toolTitleLabel.frame = CGRectMake(cancelButton.right, 0.0f, okButton.left - cancelButton.right, self.toolView.height);
    self.toolTitleLabel.backgroundColor = [UIColor clearColor];
    self.toolTitleLabel.font = AppleFont_UltraLight(18);
    self.toolTitleLabel.textColor = DarkGreyColor;
    self.toolTitleLabel.numberOfLines = 0;
    self.toolTitleLabel.userInteractionEnabled = NO;
    self.toolTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.toolView addSubview:self.toolTitleLabel];
}

#pragma mark - 按钮点击

- (void)menuItemPressed:(UIControl *)button
{
    [UIView animateWithDuration:controller_animate_duration
                     animations:^
     {
         self.backView.frame = CGRectMake(0.0f, self.frame.size.height + ToolViewHeight, self.frame.size.width, self.backView.height);
         self.toolView.frame = CGRectMake(self.toolView.left, self.pickerView.top - ToolViewHeight, self.toolView.width, self.toolView.height);
         self.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         if ([button isKindOfClass:[CVParentButton class]] && [[(CVParentButton *)button titleForState:UIControlStateNormal] isEqualToString:@"完成"])
         {
             self.hourPickerGetter(self.scrollToDate);
         }
         [self removeFromSuperview];
     }];
}

#pragma mark - tools

// 通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year % 4 == 0 ? (num_year % 100 == 0 ?  (num_year % 400 == 0 ? YES : NO) : YES) : NO;
    
    switch (num_month)
    {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:
        {
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11:
        {
            [self setdayArray:30];
            return 30;
        }
        case 2:
        {
            if (isrunNian)
            {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

#pragma mark - getter / setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.toolTitleLabel.text = title;
}

// 滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) date = [NSDate date];
    
    yearIndex = MIN(date.year, maxYear) - minYear;
    monthIndex = date.month - 1;
    dayIndex = date.day - 1;
    hourIndex = date.hour;
    minuteIndex = date.minute % 5 == 0 ? date.minute / 5 : (date.minute / 5 + 1 >= _minuteArray.count ? date.minute / 5 : (date.minute / 5 + 1));
    
    // 刷新天数
    [self DaysfromYear:yearIndex andMonth:date.month];
    [self updateSelectDate];
    
    // Reload
    [self.pickerView reloadAllComponents];
    
    // 选中
    NSArray *indexArray = @[@(yearIndex), @(monthIndex), @(dayIndex)];
    if (self.dateStyle == DateStyleShowYearMonthDayHourMinute)
    {
        indexArray = @[@(yearIndex), @(monthIndex), @(dayIndex), @(hourIndex), @(minuteIndex)];
    }
    for (int i = 0; i < indexArray.count; i++)
    {
        [self.pickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
    }
}

// 设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++)
    {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d日",i]];
    }
}

- (NSMutableArray *)setArray:(id)mutableArray
{
    if (mutableArray)
        [mutableArray removeAllObjects];
    else
        mutableArray = [NSMutableArray array];
    return mutableArray;
}

- (NSArray *)getNumberOfRowsInComponent
{
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    NSInteger hourNum = _hourArray.count;
    NSInteger minuteNum = _minuteArray.count;
    return @[@(yearNum), @(monthNum), @(dayNum), @(hourNum), @(minuteNum)];
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.dateStyle == DateStyleShowYearMonthDayHourMinute) return 5;
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return ItemHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // 设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = MainRoseRedColor;
        }
    }
    
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel)
    {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        customLabel.font = AppleFont_UltraLight(17);
        customLabel.textColor = BlackColor;
    }
    
    NSString *title;
    if (component == 0)
    {
        title = _yearArray[row];
    }
    if (component == 1)
    {
        title = _monthArray[row];
    }
    if (component == 2)
    {
        title = _dayArray[row];
    }
    if (component == 3)
    {
        title = _hourArray[row];
    }
    if (component == 4)
    {
        title = _minuteArray[row];
    }
    
    customLabel.text = title;
    return customLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) yearIndex = row;
    else if (component == 1) monthIndex = row;
    else if (component == 2) dayIndex = row;
    else if (component == 3) hourIndex = row;
    else if (component == 4) minuteIndex = row;
    
    if (component == 0 || component == 1)
    {
        [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        if (_dayArray.count - 1 < dayIndex)
        {
            dayIndex = _dayArray.count - 1;
        }
    }
    
    [pickerView reloadAllComponents];
    [self updateSelectDate];
}

- (void)updateSelectDate
{
    if (self.dateStyle == DateStyleShowYearMonthDayHourMinute)
    {
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", _yearArray[yearIndex], _monthArray[monthIndex], _dayArray[dayIndex], _hourArray[hourIndex], _minuteArray[minuteIndex]];
        self.scrollToDate = [NSDate date:dateStr WithFormat:CVDateFormatNoLimit];
    }
    else
    {
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", _yearArray[yearIndex], _monthArray[monthIndex], _dayArray[dayIndex]];
        self.scrollToDate = [NSDate date:dateStr WithFormat:CVDateFormat];
    }
}

@end

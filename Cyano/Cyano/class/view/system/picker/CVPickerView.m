//
//  CVPickerView.m
//  Cyano
//
//  Created by Yuanhai on 13/10/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVPickerView.h"

#define ItemHeight 40.0f
#define ToolViewHeight 46.0f
#define forgeCount 1 // 伪造循环Picker

@interface CVPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *toolView;
@property (strong, nonatomic) UILabel *toolTitleLabel;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *customArray;

@end

@implementation CVPickerView

- (void)show
{
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.backView.frame = CGRectMake(0.0f, self.frame.size.height - pickerViewHeight - ToolViewHeight, self.frame.size.width, pickerViewHeight + ToolViewHeight);
     } completion:nil];
}

- (id)initWithTitles:(NSArray *)titles select:(NSString *)select
{
    if (self = [self init])
    {
        self.customArray = titles;
        [self.pickerView reloadAllComponents];
        
        // 选中
        for (int f = 0; f < titles.count; f++)
        {
            if ([titles[f] isEqualToString:select])
            {
                [self.pickerView selectRow:f inComponent:0 animated:NO];
                break;
            }
        }
        
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Frame
        self.frame = MainAppDelegate.window.bounds;
        
        // Back Color
        self.backgroundColor = PopViewBackColor;
        
        // 其他地方点击
        [self addTarget:self action:@selector(menuItemPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self layoutMainView];
    }
    return self;
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

- (void)menuItemPressed:(UIControl *)button
{
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         self.pickerView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, pickerViewHeight);
         self.toolView.frame = CGRectMake(self.toolView.frame.origin.x, self.pickerView.frame.origin.y - ToolViewHeight, self.toolView.frame.size.width, self.toolView.frame.size.height);
         self.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         if ([button isKindOfClass:[CVParentButton class]])
         {
             self.numberPickerGetter([self.customArray objectAtIndex:[self.pickerView selectedRowInComponent:0]]);
         }
         [self removeFromSuperview];
     }];
}

#pragma mark - getter / setter

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.toolTitleLabel.text = title;
}

#pragma
#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.customArray.count * forgeCount;
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
            singleLine.backgroundColor = MainOrangeColor;
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
    customLabel.text = [self.customArray objectAtIndex:row % self.customArray.count];
    return customLabel;
}

@end

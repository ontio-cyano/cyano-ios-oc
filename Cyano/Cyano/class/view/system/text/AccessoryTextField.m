//
//  AccessoryTextField.m
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "AccessoryTextField.h"

@interface AccessoryTextField ()

- (void)buttonDoneClicked:(id)sender;

@end

#define kAccessoryViewHeight    35
#define kButtonWidth            70
#define VAL_MOBILENO_LENGTH     11

@implementation AccessoryTextField

- (id)init
{
    if (self = [super init])
    {
        [self initToolView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initToolView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initToolView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initToolView];
}

- (void)initToolView
{
    UIView *toolView = [[UIView alloc] init];
    toolView.frame = CGRectMake(0.0f, 0.0f, [UIApplication sharedApplication].keyWindow.width, kAccessoryViewHeight);
    toolView.backgroundColor = PurityColor(249);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0.0f, 0.0f, toolView.width, table_line_height);
    lineView.backgroundColor = PurityColor(179);
    [toolView addSubview:lineView];
    
    UIButton *buttonDone = [[UIButton alloc] init];
    buttonDone.frame = CGRectMake(toolView.width - kButtonWidth, 0, kButtonWidth, kAccessoryViewHeight);
    buttonDone.titleLabel.textAlignment = NSTextAlignmentCenter;
    buttonDone.titleLabel.font = AppleFont_Regular(16);
    [buttonDone setTitleColor:PurityColor(150) forState:UIControlStateNormal];
    [buttonDone setTitle:@"完成" forState:UIControlStateNormal];
    [buttonDone addTarget:self action:@selector(buttonDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:buttonDone];
    
    self.inputAccessoryView = toolView;
    
    // 取消表情
    [self addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 取消表情

- (void)textDidChange
{
    if (self.text.length >= 2)
    {
        NSString *lastTwoCharacter = [self.text substringFromIndex:self.text.length - 2];
        //emoji 是2个字符一起的，不能截断
        if ([self containsEmoji:lastTwoCharacter])
        {
            self.text = [self.text substringToIndex:self.text.length - 2];
        }
    }
}

- (BOOL)containsEmoji:(NSString *)text
{
    // emoji表情
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *match = [regex matchesInString:text options:NSMatchingReportCompletion range:NSMakeRange(0, [text length])];
    return (match.count > 0);
}

#pragma mark - 按钮点击

- (void)buttonDoneClicked:(id)sender
{
    [self resignFirstResponder];
}

@end


/*
 限制输入长度
 */

@implementation LimitTextField

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;
    if (self.limitInputLength <= 0) return YES;
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > self.limitInputLength)
    {
        return NO;
    }
    //call customer's delegate
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

@end


/*
 只能输入4位，小数点后只能一位
 */

@implementation OneDecimalsTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.limitInputLength = 4;
    self.numberBeforeDot = 0;
    self.numberAfterDot = 1;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![super textField:textField shouldChangeCharactersInRange:range replacementString:string])
    {
        return NO;
    }
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL getDot = NO;
    for (int f = 0; f < newStr.length; f++)
    {
        if ([[newStr substringWithRange:NSMakeRange(f, 1)] isEqualToString:@"."])
        {
            // 必须在最后或者倒数第几位
            if (newStr.length - f - 1 > self.numberAfterDot)
            {
                return NO;
            }
            // 最多只有一个
            if (getDot)
            {
                return NO;
            }
            getDot = YES;
        }
    }
    //是否限制整数部分
    if (self.numberBeforeDot != 0)
    {
        NSInteger integerLength;
        if (getDot)
        {
            integerLength = [newStr rangeOfString:@"."].location;
        }
        else
        {
            integerLength = newStr.length;
        }
        if (integerLength > self.numberBeforeDot)
        {
            return NO;
        }
    }
    
    return YES;
}

@end


/*
 电话号码输入
 */

@implementation PhoneTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.limitInputLength = VAL_MOBILENO_LENGTH;
}

@end



//
//  PasswordField.m
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "PasswordTextField.h"

@interface PasswordTextField ()

@property (strong, nonatomic) UIColor *foreColor;

- (void)buttonVisibleClicked:(id)sender;

@end

#define kMargin 3 //visible button's margin

@implementation PasswordTextField

- (void)setup
{
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.secureTextEntry = YES;
    UIButton *buttonVisible = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonVisible setImage:[[UIImage imageNamed:@"ic_invisibility"] imageWithColor:self.foreColor] forState:UIControlStateNormal];
    CGFloat height = self.bounds.size.height - 2 * kMargin;
    buttonVisible.frame = CGRectMake(0, 0, height, height);
    [buttonVisible addTarget:self action:@selector(buttonVisibleClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.rightViewMode = UITextFieldViewModeNever;
    self.rightView = buttonVisible;
    self.limitInputLength = 20;
    [self addTarget:self action:@selector(charactersChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (id)initWithFrame:(CGRect)frame foreColor:(UIColor *)foreColor
{
    if (!(self = [super initWithFrame:frame])) return nil;
    self.foreColor = foreColor;
    [self setup];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    self.foreColor = WhiteColor;
    [self setup];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)buttonVisibleClicked:(id)sender
{
    self.secureTextEntry = !self.isSecureTextEntry;
    UIButton *buttonVisible = (UIButton *)sender;
    [buttonVisible setImage:[[UIImage imageNamed:self.isSecureTextEntry ? @"ic_invisibility" : @"ic_visibility"] imageWithColor:self.foreColor] forState:UIControlStateNormal];
}

- (void)charactersChanged:(UITextField *)textField
{
    if (textField.text.length > 0)
    {
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    else
    {
        self.rightViewMode = UITextFieldViewModeNever;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![super textField:textField shouldChangeCharactersInRange:range replacementString:string])
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

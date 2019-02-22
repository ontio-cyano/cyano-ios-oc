//
//  CVCommentsView.m
//  Cyano
//
//  Created by Yuanhai on 14/9/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "CVCommentsView.h"
#import "SXTextView.h"

#define textViewHeight 120.0f

@interface CVCommentsView() <UITextViewDelegate>

@property(strong, nonatomic) UIView *backView;
@property(strong, nonatomic) SXTextView *textView;
@property(strong, nonatomic) UIButton *sendButton;

@end

@implementation CVCommentsView

- (void)dealloc
{
    // 键盘
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithPlaceholder:(NSString *)placeholder
{
    if (self = [super initWithFrame:MainAppDelegate.window.bounds])
    {
        self.backgroundColor = PopViewBackColor;
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        // Back
        self.backView = [self createView:self];
        self.backView.frame = CGRectMake(0.0f, self.height, self.width, textViewHeight);
        self.backView.backgroundColor = WhiteColor;
        
        // Send
        float buttonWidth = 60.0f;
        float buttonHeight = 40.0f;
        self.sendButton = [self createButton:self.backView];
        [self.sendButton addTarget:self action:@selector(sendPress) forControlEvents:UIControlEventTouchUpInside];
        self.sendButton.frame = CGRectMake(self.backView.width - buttonWidth, self.backView.height - buttonHeight, buttonWidth, buttonHeight);
        [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
        self.sendButton.userInteractionEnabled = NO;
        [self.sendButton setTitleColor:LightGreyColor forState:UIControlStateNormal];
        self.sendButton.titleLabel.font = AppleFont_UltraLight(14);
        
        // TextView
        float spacing = frameMove_X;
        self.textView = [[SXTextView alloc] initWithFrame:CGRectMake(spacing, spacing, self.backView.width - spacing * 2, self.sendButton.top - spacing)];
        self.textView.font = AppleFont_UltraLight(14);
        self.textView.placeholder = placeholder;
        self.textView.textColor = BlackColor;
        self.textView.delegate = self;
        self.textView.inputAccessoryView = nil;
        [self.backView addSubview:self.textView];
        self.textView.maxTextLength = 200;
        
        // 键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)show
{
    [MainAppDelegate.window addSubview:self];
    [MainAppDelegate.window bringSubviewToFront:self];
    self.hidden = NO;
    [self.textView becomeFirstResponder];
}

- (void)hide
{
    [self.textView resignFirstResponder];
}

#pragma mark - 按钮点击

- (void)sendPress
{
    [self hide];
    if (self.callBack) self.callBack(self.textView.text);
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        self.sendButton.userInteractionEnabled = YES;
        [self.sendButton setTitleColor:MainGreenColor forState:UIControlStateNormal];
    }
    else
    {
        self.sendButton.userInteractionEnabled = NO;
        [self.sendButton setTitleColor:LightGreyColor forState:UIControlStateNormal];
    }
}

#pragma mark - Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 改变Frame
    [UIView animateWithDuration:animationDuration animations:^{
        self.backView.top = self.height - keyboardRect.size.height - textViewHeight;
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // 改变Frame
    [UIView animateWithDuration:animationDuration animations:^{
        self.backView.top = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

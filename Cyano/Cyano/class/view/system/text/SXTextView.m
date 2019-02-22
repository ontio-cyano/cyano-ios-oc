//
//  SXTextView.m
//  iQBTeacherHD
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "SXTextView.h"
#import "Interceptor.h"

#define kAccessoryViewHeight    32
#define kButtonWidth            50

@interface SXTextView ()

@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) Interceptor *delegate_interceptor;
@property (strong, nonatomic) UILabel *maxLengthLabel;

- (void)buttonDoneClicked:(id)sender;

- (void)initDelegateInterceptor;

@end

@implementation SXTextView

- (id)init
{
    if (self = [super init])
    {
        [self initDelegateInterceptor];
        [self setupPlaceholder];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initDelegateInterceptor];
        [self setupPlaceholder];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initDelegateInterceptor];
        [self setupPlaceholder];
    }
    return self;
}

- (void)setupPlaceholder
{
    if (self.placeholderLabel) return;
    self.backgroundColor = [UIColor clearColor];
    self.placeholderLabel = [[UILabel alloc]init];
    self.placeholderLabel.frame = CGRectMake(5.0f, 8.0f, self.width - 10.0f, 20.0f);
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.font = [UIFont systemFontOfSize:14];
    self.placeholderLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    [self insertSubview:self.placeholderLabel atIndex:0];
    self.placeholderLabel.textColor = PurityColor(180);
    self.font = [UIFont systemFontOfSize:14];
    self.scrollEnabled = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidBeginEditingNotification object:self];
    
    // MaxLength
    float maxLengthHeight = 25.0f;
    self.maxLengthLabel = [[UILabel alloc] init];
    self.maxLengthLabel.frame = CGRectMake(self.left + 5.0f, self.bottom - maxLengthHeight - 5.0f, self.width - 10.0f, maxLengthHeight);
    self.maxLengthLabel.font = self.placeholderLabel.font;
    self.maxLengthLabel.textAlignment = NSTextAlignmentRight;
    self.maxLengthLabel.backgroundColor = [UIColor clearColor];
    self.maxLengthLabel.textColor = self.placeholderLabel.textColor;
    
    // ToolBar
    [self initToolView];
}

- (void)setMaxTextLength:(int)maxTextLength
{
    _maxTextLength = maxTextLength;
    
    if (!self.superview) return;
    BOOL haveAddLengthLabel = NO;
    for (UIView *view in self.superview.subviews)
    {
        if (view == self.maxLengthLabel)
        {
            haveAddLengthLabel = YES;
            break;
        }
    }
    if (!haveAddLengthLabel)
    {
        [self.superview insertSubview:self.maxLengthLabel atIndex:0];
    }
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
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)initDelegateInterceptor
{
    self.delegate_interceptor = [[Interceptor alloc] init];
    // self is automatically a delegate
    [self.delegate_interceptor setMiddleMan:self];
    [super setDelegate:(id)self.delegate_interceptor];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    [super setDelegate:nil];
    [self.delegate_interceptor setReceiver:delegate];
    [super setDelegate:(id)self.delegate_interceptor];
}

- (id<UITextFieldDelegate>)delegate
{
    //customer's delegate forward to receiver
    return self.delegate_interceptor.receiver;
}

- (void)textDidChange
{
    if (self.maxTextLength && self.text.length > self.maxTextLength)
    {
        [CVShowLabelView showTitle:@"超出字符限制!" detail:nil];
    }
    
    // Placeholder
    self.placeholderLabel.hidden = (self.text.length != 0);
    self.placeholderLabel.frame = CGRectMake(5.0f, 8.0f, self.width - 10.0f, 20.0f);
    CGSize size = [self sizeWithString:self.placeholder font:self.font size:CGSizeMake(self.placeholderLabel.width, CGFLOAT_MAX)];
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.height = size.height;
    if (self.mainDelegate) [self.mainDelegate textDidChanged:self];
    
    // 字符限制
    self.maxLengthLabel.hidden = (self.maxTextLength == 0);
    self.maxLengthLabel.font = self.placeholderLabel.font;
    self.maxLengthLabel.text = [NSString stringWithFormat:@"%d/%d", (int)self.text.length, self.maxTextLength];
}

- (void)setPlaceholder:(NSString *)strValue
{
    _placeholder = strValue;
    self.placeholderLabel.text = self.placeholder;
    CGSize size = [self sizeWithString:self.placeholder font:self.font size:CGSizeMake(self.placeholderLabel.width, CGFLOAT_MAX)];
    self.placeholderLabel.height = size.height;
    [self textDidChange];
}

//获取字符窜大小
- (CGSize)sizeWithString:(NSString*) string  font:(UIFont*)font size:(CGSize)size
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize textSize = [string boundingRectWithSize:size
                                           options:\
                       NSStringDrawingTruncatesLastVisibleLine |
                       NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    return textSize;
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



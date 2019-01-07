// 
//  CVActionSheet.m
//  WirelessHome
// 
//  Created by Faney on 13-6-24.
//  ActionSheet

#import "CVActionSheet.h"

#define messageSpacing getUIValue(5.0f)
#define messageHeight getUIValue(50.0f)

#define widthSpacing getUIValue(15.0f)
#define heightLittleSpacing getUIValue(2.0f)
#define heightSpacing getUIValue(20.0f)
#define buttonHeight getUIValue(40.0f)

@implementation CVActionSheet

+ (BOOL)isShowing
{
    UIView *popView = [MainAppDelegate.window viewWithTag:popViewTag];
    return (popView && ![popView isEqual:[NSNull null]]);
}

- (void)show
{
    [MainAppDelegate.window endEditing:NO];
    [MainAppDelegate.window addSubview:self];
    
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         [self viewWithTag:popViewTag].frame = CGRectMake([self viewWithTag:popViewTag].frame.origin.x, self.frame.size.height - [self viewWithTag:popViewTag].frame.size.height, [self viewWithTag:popViewTag].frame.size.width, [self viewWithTag:popViewTag].frame.size.height);
     } completion:nil];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        // Frame
        self.frame = MainAppDelegate.window.bounds;
        
        // Pop View
        UIScrollView *popView = [[UIScrollView alloc] init];
        popView.tag = popViewTag;
        [self addSubview:popView];
        
        // Back Color
        self.backgroundColor = PopViewBackColor;
        
        // 其他地方点击
        [self addTarget:self action:@selector(actionSheetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithTitles:(NSArray *)titles message:(NSString *)message delegate:(id<CVActionSheetDelegate>)delegate highlight:(BOOL)highlight localized:(BOOL)localized
{
    if (self = [self init])
    {
        self.delegate = delegate;
        
        // Pop View
        UIScrollView *popView = (UIScrollView *)[self viewWithTag:popViewTag];
        
        // Message
        float messageH = 0;
        if (message)
        {
            UILabel *messageLabel = [[UILabel alloc] init];
            messageLabel.frame = CGRectMake(widthSpacing, messageSpacing, self.frame.size.width - widthSpacing * 2, messageHeight);
            messageLabel.textColor = BlackColor;
            messageLabel.text = message;
            messageLabel.font = AppleFont_UltraLight(20);
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.numberOfLines = 0;
            [popView addSubview:messageLabel];
            messageH += messageLabel.frame.origin.y + messageLabel.frame.size.height;
        }
        
        // 如果Titles数组是Dictionary数组，则取其中的Title
        NSMutableArray *realTitles = [NSMutableArray array];
        for (NSObject *getTitle in titles)
        {
            NSString *realTitle = nil;
            if ([getTitle isKindOfClass:[NSString class]])
            {
                realTitle = (NSString *)getTitle;
            }
            else if ([getTitle isKindOfClass:[NSDictionary class]])
            {
                realTitle = (NSString *)[(NSDictionary *)getTitle objectForKey:@"title"];
            }
            
            if (localized)
            {
                realTitle = NSLocalizedString(realTitle, nil);
            }
            
            [realTitles addObject:realTitle];
        }
        
        // Titles
        float popHeight = messageH + heightSpacing;
        for (int f = 0; f < realTitles.count; f++)
        {
            CVPressView *titleButton = [[CVPressView alloc] init];
            titleButton.tag = f + 1;
            [titleButton setTitle:[realTitles objectAtIndex:f] forState:UIControlStateNormal];
            [titleButton addTarget:self action:@selector(actionSheetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [titleButton.titleLabel setFont:AppleFont_UltraLight(16)];
            titleButton.backgroundColor = WhiteColor;
            [titleButton setTitleColor:BlackColor forState:UIControlStateNormal];
            titleButton.layer.cornerRadius = buttonHeight / 2;
            [popView addSubview:titleButton];
            
            // Frame
            if (f == realTitles.count - 1 && highlight)
            {
                titleButton.tag = 0;
                
                popHeight = popHeight - heightLittleSpacing + heightSpacing;
                titleButton.frame = CGRectMake(widthSpacing, popHeight, self.frame.size.width - widthSpacing * 2, buttonHeight);
                
                titleButton.backgroundColor = MainRoseRedColor;
                [titleButton setTitleColor:WhiteColor forState:UIControlStateNormal];
                
                // 背景高度
                popHeight += titleButton.frame.size.height;
            }
            else
            {
                titleButton.frame = CGRectMake(widthSpacing, popHeight, self.frame.size.width - widthSpacing * 2, buttonHeight);
                
                // 背景高度
                popHeight += titleButton.frame.size.height;
                if (f < realTitles.count - 1) popHeight += heightLittleSpacing;
            }
            
            // 是否添加"+"
            if ([[realTitles objectAtIndex:f] isEqualToString:@"+"])
            {
                [titleButton setTitle:nil forState:UIControlStateNormal];
                
                // Add Image
                float imageRadius = titleButton.frame.size.height * 0.5;
                UIImageView *addImageView = [[UIImageView alloc] init];
                addImageView.image = [UIImage imageNamed:@"action_sheet_add.png"];
                addImageView.frame = CGRectMake((titleButton.frame.size.width - imageRadius) / 2, (titleButton.frame.size.height - imageRadius) / 2, imageRadius, imageRadius);
                [titleButton addSubview:addImageView];
            }
        }
        
        // 背景高度
        popHeight += heightSpacing * 0.6;
        
        // Set Pop Height
        if (realTitles.count > 5)
        {
            // 大于5就可以滚动
            float popMaxHeight = messageH + buttonHeight * 5.5 + heightSpacing + heightLittleSpacing * 5;
            if (highlight) popMaxHeight = messageH + buttonHeight * 5.5 + heightSpacing * 2 + heightLittleSpacing * 4;
            popView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, popMaxHeight);
            [popView setContentSize:CGSizeMake(self.frame.size.width, popHeight)];
        }
        else
        {
            popView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, popHeight);
        }
    }
    return self;
}

- (void)actionSheetButtonPressed:(UIControl *)button
{
    NSInteger selectIndex = button.tag - 1;
    [UIView animateWithDuration:0.2f
                     animations:^
     {
         [self viewWithTag:popViewTag].frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, [self viewWithTag:popViewTag].frame.size.height);
         self.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         if ([button isKindOfClass:[CVPressView class]])
         {
             [self.delegate CVActionSheet:self clickedButtonAtIndex:selectIndex];
         }
         else
         {
             [self.delegate CVActionSheet:self clickedButtonAtIndex:-1];
         }
         [self removeFromSuperview];
     }];
}

@end

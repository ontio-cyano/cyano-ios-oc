//
//  CVItemsSheet.m
//  GreenHouse
//
//  Created by Yuanhai on 9/3/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

#import "CVItemsSheet.h"

#define heightSpacing getUIValue(20.0f)
#define heightLittleSpacing getUIValue(10.0f)
#define widthSpacing getUIValue(22.5f)

#define messageSpacing getUIValue(5.0f)
#define messageHeight getUIValue(50.0f)

#define itemColumnCount 3

@implementation CVItemsSheet

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
        popView.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:255 / 255.0f blue:255 / 255.0f alpha:1.0f];
        popView.tag = popViewTag;
        [self addSubview:popView];
        
        // Back Color
        self.backgroundColor = PopViewBackColor;
        
        // 其他地方点击
        [self addTarget:self action:@selector(actionSheetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithTitles:(NSArray *)titles message:(NSString *)message delegate:(id<CVItemsSheetDelegate>)delegate highlight:(BOOL)highlight localized:(BOOL)localized
{
    if (self = [self init])
    {
        self.delegate = delegate;
        
        // Pop View
        UIScrollView *popView = (UIScrollView *)[self viewWithTag:popViewTag];
        
        // Message
        float messageH = heightSpacing;
        if (message)
        {
            UILabel *messageLabel = [[UILabel alloc] init];
            messageLabel.frame = CGRectMake(widthSpacing, messageSpacing, self.frame.size.width - widthSpacing * 2, messageHeight);
            messageLabel.textColor = BlackColor;
            messageLabel.text = message;
            messageLabel.font = AppleFont_UltraLight(18);
            messageLabel.textAlignment = NSTextAlignmentCenter;
            messageLabel.numberOfLines = 0;
            [popView addSubview:messageLabel];
            messageH = messageLabel.frame.origin.y + messageLabel.frame.size.height + messageSpacing;
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
        
        // Frame
        float buttonWidthSpacing = frameMove_X;
        float buttonWidth = (MainAppDelegate.window.frame.size.width - buttonWidthSpacing * (itemColumnCount + 1)) / itemColumnCount;
        float buttonHeight = getUIValue(35.0f);
        
        // Titles
        for (int f = 0; f < realTitles.count; f++)
        {
            CVPressView *titleButton = [[CVPressView alloc] init];
            titleButton.tag = f + 1;
            titleButton.frame = CGRectMake((f % itemColumnCount) * (buttonWidth + buttonWidthSpacing) + buttonWidthSpacing, (f / itemColumnCount) * (buttonHeight + heightLittleSpacing) + messageH, buttonWidth, buttonHeight);
            [titleButton addTarget:self action:@selector(actionSheetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [popView addSubview:titleButton];
            
            // title
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = titleButton.bounds;
            titleLabel.font = AppleFont_UltraLight(14);
            titleLabel.textColor = BlackColor;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.numberOfLines = 0;
            titleLabel.adjustsFontSizeToFitWidth = YES;
            titleLabel.layer.borderColor = PurityColor(150).CGColor;
            titleLabel.layer.borderWidth = table_line_height;
            titleLabel.layer.masksToBounds = YES;
            titleLabel.layer.cornerRadius = 2.0f;
            titleLabel.text = realTitles[f];
            [titleButton addSubview:titleLabel];
            
            if (f == 0 && highlight)
            {
                titleLabel.textColor = MainOrangeColor;
            }
        }
        
        NSInteger rowCount = (realTitles.count % itemColumnCount == 0) ? (realTitles.count / itemColumnCount) : (realTitles.count / itemColumnCount + 1);
        float popHeight = heightSpacing + rowCount * buttonHeight + heightLittleSpacing * (rowCount - 1) + messageH;
        
        // Set Pop Height
        popView.frame = CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, popHeight);
    }
    return self;
}

- (void)actionSheetButtonPressed:(UIControl *)button
{
    NSInteger selectIndex = button.tag;
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
             [self.delegate CVItemsSheet:self clickedButtonAtIndex:selectIndex];
         }
         [self removeFromSuperview];
     }];
}

@end

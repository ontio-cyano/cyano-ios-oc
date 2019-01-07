//
//  SXTextView.h
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SXTextViewDelegate;

@interface SXTextView : UITextView <UITextViewDelegate>

@property (nonatomic,   copy) NSString *placeholder;
@property (nonatomic, assign) int maxTextLength;
@property (weak,   nonatomic) id <SXTextViewDelegate> mainDelegate;
;

@end

@protocol SXTextViewDelegate

@required
- (void)textDidChanged:(SXTextView *)textView;

@end


//
//  VerifyCodeTextField.m
//  iQBTeacher
//
//  Created by Yuanhai on 27/5/18.
//  Copyright © 2018年 Yuanhai. All rights reserved.
//

#import "VerifyCodeTextField.h"

#define VAL_VERIFYCODE_LENGTH           6

@interface VerifyCodeTextField ()
@end

@implementation VerifyCodeTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.limitInputLength = VAL_VERIFYCODE_LENGTH;
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

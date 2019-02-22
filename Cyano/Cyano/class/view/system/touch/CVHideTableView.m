//
// CVHideTableView.m
// WirelessHome
//
// Created by Faney on 13-6-4.
// 可点击的TableView

#import "CVHideTableView.h"

@implementation CVHideTableView

#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self endEditing:NO];
}

@end

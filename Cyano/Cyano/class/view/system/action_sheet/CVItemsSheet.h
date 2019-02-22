//
//  CVItemsSheet.h
//  GreenHouse
//
//  Created by Yuanhai on 9/3/17.
//  Copyright © 2017年 Yuanhai. All rights reserved.
//

@protocol CVItemsSheetDelegate;

#import <UIKit/UIKit.h>

@interface CVItemsSheet : UIControl

@property (weak, nonatomic) id <CVItemsSheetDelegate> delegate;

@property (assign, nonatomic) NSInteger type; // 区分哪个控件

+ (BOOL)isShowing;

- (id)initWithTitles:(NSArray *)titles message:(NSString *)message delegate:(id<CVItemsSheetDelegate>)delegate highlight:(BOOL)highlight localized:(BOOL)localized;

- (void)show;

@end

@protocol CVItemsSheetDelegate

@required
- (void)CVItemsSheet:(CVItemsSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

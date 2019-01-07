//
//  CVMenuView.h
//  CUBE
//
//  Created by Faney on 15/8/31.
//  Copyright (c) 2015年 Faney. All rights reserved.
//

@interface CVMenuView : UIControl

@property (strong, nonatomic) void (^callBack) (NSString *title);

- (id)initWithTitles:(NSArray *)titles top:(float)top center:(float)center;
- (void)show;

@end

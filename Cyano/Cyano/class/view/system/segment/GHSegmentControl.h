//
//  GHSegmentControl.h
//  GreenHouse
//
//  Created by Yuanhai on 20/9/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GHSegmentControlDelegate <NSObject>

- (void)selectSegmentIndex:(NSInteger)index;

@end

@interface GHSegmentControl : UIScrollView

@property (nonatomic, strong) NSArray *arrayTitles;
@property (nonatomic,   weak) id <GHSegmentControlDelegate> controlDelegate;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

//更新显示的数字。如果index超过范围，则忽略；如果count=0，则不显示数字。
- (void)updateBadgeAt:(NSInteger)index count:(NSInteger)count;

@end

//
//  CVScrollLabelsView.h
//  CloudStudy
//
//  Created by Yuanhai on 13/7/17.
//  Copyright © 2017年 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVScrollLabelsView : UIView

@property (strong, nonatomic) NSArray *titles;

- (void)startTimer;
- (void)stopTimer;

@end

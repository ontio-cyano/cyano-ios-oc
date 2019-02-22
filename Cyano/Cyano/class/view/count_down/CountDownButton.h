//
//  CountDownButton.h
//  GreenHouse
//
//  Created by Bao, Christine on 25/05/2017.
//  Copyright © 2017 honeywell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton

@property (nonatomic) NSInteger countdownSeconds;

- (void)startCountDown:(NSInteger)seconds;

- (void)startCountDown;
- (void)stopCountDown;

@end

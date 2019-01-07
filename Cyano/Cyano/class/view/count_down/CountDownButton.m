//
//  CountDownButton.m
//  GreenHouse
//
//  Created by Bao, Christine on 25/05/2017.
//  Copyright © 2017 honeywell. All rights reserved.
//

#import "CountDownButton.h"

@interface CountdownButton ()

@property (nonatomic) NSInteger currentSeconds;
@property (nonatomic, strong) NSTimer *timer;

- (void)updateButton;
- (void)stopTimer;

@end

@implementation CountdownButton

#pragma mark - life cycle

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)dealloc
{
    [self stopTimer];
}

- (void)startCountDown:(NSInteger)seconds
{
    self.alpha = DisableButtonAlpha;
    self.enabled = NO;
    self.currentSeconds = seconds;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateButton) userInfo:nil repeats:YES];
    [self updateButton];
}

- (void)startCountDown
{
    [self startCountDown:self.countdownSeconds];
}

- (void)stopCountDown
{
    [self stopTimer];
}

#pragma mark - private functions

- (void)updateButton
{
    self.currentSeconds--;
    NSString *title = [NSString stringWithFormat:@"重新发送（%li）", (long)self.currentSeconds];
    self.titleLabel.text = title;
    [self setTitle:title forState:UIControlStateDisabled];
    
    if (self.currentSeconds <= 0)
    {
        [self stopTimer];
        self.enabled = YES;
        self.alpha = 1.0f;
    }
}

- (void)stopTimer
{
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end

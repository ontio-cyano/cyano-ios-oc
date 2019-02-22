//
//  CVRefreshVIew.h
//  CUBE
//
//  Created by Faney on 16/3/24.
//  Copyright © 2016年 Faney. All rights reserved.
//

@interface CVRefreshVIew : UIView

+ (CVRefreshVIew *)instance;

- (void)startRefresh;

- (void)stopRefresh;

@end

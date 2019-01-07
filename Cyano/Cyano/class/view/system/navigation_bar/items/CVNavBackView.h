//
//  CVNavBackView.h
//  CUBE
//
//  Created by Faney on 15/8/25.
//  Copyright (c) 2015年 Faney. All rights reserved.
//

typedef enum
{
    BackViewColor_White = 1,
    BackViewColor_Black = 2,
}
BackViewColor;

#define BackSpacing getUIValue(3.0f)

@interface CVNavBackView : UIView

@property (assign, nonatomic) BackViewColor viewColor;

@end

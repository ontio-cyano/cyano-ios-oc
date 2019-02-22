// 
// CVNavBarView.h
// WirelessHome
// 
// Created by Faney on 13-8-27.
// 
//

typedef enum
{
    NavigationBarType_None = 1,
    NavigationBarType_Normal,
    NavigationBarType_CurveLine,
    NavigationBarType_Mask,
}
NavigationBarType;

@interface CVNavBarView : UIView

@property (assign, nonatomic) NavigationBarType barType;

// 隐藏状态栏
- (void)hiddenStatusBar;

@end

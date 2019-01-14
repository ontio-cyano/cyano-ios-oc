//
//  ViewTag.h
//  WirelessHome
//
//  Created by Faney on 13-11-1.
//
//  Frame & Color


/*(界面布局)*/

// 状态条高度
#define NavigationStatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)

// 导航条弧度高度
#define navigationCurveHeight 20.0f

// 导航条高度
#define navigationHeight 46.0f

// 搜索条高度
#define searchViewHeight 45.0f

// TabBar高度
#define tabBarHeight 50.0f

// 工具栏高度
#define toolDownViewHeight 48.0f
#define customToolHeight getUIValue(50.0f)
#define customToolMoveHeight 8.0f

// Segment高度
#define segmentViewHeight 45.0f

// Menu宽度
#define home_move_x (MainAppDelegate.window.frame.size.width * 0.4)

// 默认Picker高度
#define pickerViewHeight 216.0f

// 获取多尺寸手机Font
#define getFontSize(font) (font / 375.0 * MainAppDelegate.window.frame.size.width)

// 获取真实值
#define getUIValue(value) ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? (value * MainAppDelegate.window.frame.size.width / 768.0f) : (value * MainAppDelegate.window.frame.size.width / 375.0))

// 表单元格线高度
#define table_line_height 0.5f
#define border_line_height 1.0f

// 界面与边框间距
#define frameMove_X getUIValue(10.0f)
#define loginMove_X getUIValue(35.0f)

// 不能点击的按钮透明度
#define DisableButtonAlpha 0.3f

// 圆角弧度
#define viewBorderRadius 2.0f
#define scrollCornerRadius 8.0f

// ScrollView 边框视图
#define scrollBorderSpacing getUIValue(6.0f)
#define scrollBorderHeight getUIValue(10.0f)
#define scrollBorderColor RGBACOLOR(255, 255, 255, 0.4f)

// 默认单元格高度
#define customCellHeight getUIValue(55.0f)
#define customCellTextFieldHeight getUIValue(45.0f)
#define customSectionHeight getUIValue(10.0f)
#define indicatorHeight getUIValue(20.0f)
#define cellIconHeight getUIValue(25.0f)
#define footerButtonHeight 44.0f
#define footerButtonHeightSpacing 20.0f

// 滚动页面圆点高度
#define pageControlHeight 36.0f
#define page_control_move (pageControlHeight * 0.2)

// 输入框高度
#define cellTextFieldHeight 32.0f
#define cellLabelHeight 20.0f

// 弹出视图背景颜色
#define PopViewBackColor RGBACOLOR(0, 0, 0, 0.3f)
#define PopViewDarkBackColor RGBACOLOR(0, 0, 0, 0.6f)
#define ActivityBackColor RGBACOLOR(0, 0, 0, 0.8f)
#define PopViewBlackBackColor RGBACOLOR(51, 51, 51, 0.99f)

// 定制颜色
#define MainBlueColor RGBCOLOR(84, 162, 187)
#define MainRedColor RGBCOLOR(199, 36, 36)
#define MainOrangeColor RGBCOLOR(239, 127, 56)
#define MainGreenColor RGBCOLOR(108, 151, 102)
#define MainRoseRedColor RGBCOLOR(211, 67, 115)
#define MainImageBackColor RGBCOLOR(232, 231, 232)
#define MainYellowColor RGBCOLOR(255, 177, 22)
#define MainViewsColor RGBCOLOR(91, 177, 206)


/*(Color)*/

#define RGBCOLOR(R, G, B) [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:1.0f]

#define RGBACOLOR(R, G, B, A) [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:A]

#define PurityColor(purity) [UIColor colorWithRed:purity / 255.0f green:purity / 255.0f blue:purity / 255.0f alpha:1.0f]

#define BlackColor PurityColor(30)
#define WhiteColor PurityColor(255)
#define DarkGreyColor PurityColor(60)
#define GreyColor PurityColor(150)
#define LightGreyColor PurityColor(190)
#define LightWhiteColor PurityColor(220)
#define AlphaWhiteColor RGBACOLOR(255, 255, 255, 0.4f)
#define AlphaBlackColor RGBACOLOR(0, 0, 0, 0.4f)

#define MainNavigationColor RGBCOLOR(230, 234, 224)
#define MainAlertTintColor PurityColor(60)

#define tableLineColor RGBCOLOR(224, 223, 226)
#define tableSectionColor [UIColor clearColor]


/*(Font)*/

// 粗体
#define AppleFont_Regular(size) [UIFont boldSystemFontOfSize:size]

// 常规
#define AppleFont_UltraLight(fontsize) [UIFont systemFontOfSize:fontsize]

// 薄
#define AppleFont_Thin(fontsize) [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:fontsize]

// 数字
#define NumberFont(fontsize)[UIFont fontWithName:@"Noteworthy-Bold" size:fontsize]


#define ONG_PRECISION_STR @"1000000000"
#define NEP5_PRECISION_STR @"100000000"
#define ONG_ZERO @"0.000000000"

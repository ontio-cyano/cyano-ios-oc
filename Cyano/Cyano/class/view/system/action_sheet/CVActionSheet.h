// 
//  CVActionSheet.h
//  WirelessHome
// 
//  Created by Faney on 13-6-24.
// 
// 

@protocol CVActionSheetDelegate;

@interface CVActionSheet : UIControl

@property (weak, nonatomic) id <CVActionSheetDelegate> delegate;

@property (assign, nonatomic) NSInteger type; // 区分哪个控件

+ (BOOL)isShowing;

- (id)initWithTitles:(NSArray *)titles message:(NSString *)message delegate:(id<CVActionSheetDelegate>)delegate highlight:(BOOL)highlight localized:(BOOL)localized;

- (void)show;

@end

@protocol CVActionSheetDelegate

@required
- (void)CVActionSheet:(CVActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

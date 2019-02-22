//
//  CVActionSheetShareView.h
//  Tools
//
//  Created by Stephane on 12/12/2014.
//  Copyright (c) 2014 Stephane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CVActionSheetShareView;

@protocol CVActionSheetShareViewDataSource <NSObject>

@required
- (NSInteger)numberOfRowsInActionShareView:(CVActionSheetShareView *)actionShareView;
- (NSString *)actionShareView:(CVActionSheetShareView*)actionShareView buttonTextForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)actionShareView:(CVActionSheetShareView*)actionShareView numberOfCellsInRow:(NSInteger)row;
- (UIImage *)actionShareView:(CVActionSheetShareView*)actionShareView imageForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CVActionSheetShareViewDelegate <NSObject>

@optional
-(void)actionShareView:(CVActionSheetShareView *)actionShareView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CVActionSheetShareView : UIView

@property (strong, nonatomic) id<CVActionSheetShareViewDataSource> dataSource;
@property (strong, nonatomic) id<CVActionSheetShareViewDelegate> delegate;
@property (strong, nonatomic) NSString* buttonText;

-(void)show;

@end

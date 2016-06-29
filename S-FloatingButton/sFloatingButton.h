//
//  sFloatingButton.h
//  S-FloatingButton
//
//  Created by Mine on 6/26/16.
//  Copyright © 2016 Shan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol floatingButtonDelegate <NSObject>

-(void)didSelectMenuIndexPath:(NSInteger)row;

@end

@interface sFloatingButton : UIView <UITableViewDataSource,UITableViewDelegate>

@property NSArray * imageArray, *labelArray;
@property  UIView * fButtonView;
@property BOOL isMenuVisible;
@property UIView * mainWindowView;
@property id <floatingButtonDelegate>fDelegate;

@property (strong,nonatomic) UIView * bgView;
@property (strong,nonatomic) UIImage *plusImage, *crossImage;
@property (strong,nonatomic) UIImageView *normalImageView,*selectedImageView;
@property (strong,nonatomic) UIWindow *mainWindow;
@property (strong,nonatomic) UITableView *fMenuTableView;

-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)plusButtonImage andPressedImage:(UIImage*)crossButtonImage;

@end

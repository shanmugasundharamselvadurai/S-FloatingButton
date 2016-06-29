//
//  sFloatingButton.m
//  S-FloatingButton
//
//  Created by Mine on 6/26/16.
//  Copyright © 2016 Shan. All rights reserved.
//

#import "sFloatingButton.h"

#define  viewWidth [UIScreen mainScreen].bounds.size.width
#define  viewHeight   [UIScreen mainScreen].bounds.size.height

CGFloat animationTime =  0.50;
CGFloat rowHeight = 60.f;
NSInteger noOfRows = 0;
NSInteger tappedRow;
CGFloat previousOffset;
CGFloat buttonToScreenHeight;

@implementation sFloatingButton

@synthesize fDelegate,mainWindow,plusImage,crossImage,selectedImageView,normalImageView,mainWindowView,isMenuVisible,fButtonView,bgView,fMenuTableView,imageArray,labelArray;

    
-(id)initWithFrame:(CGRect)frame normalImage:(UIImage*)plusButtonImage andPressedImage:(UIImage*)crossButtonImage{


    self = [super initWithFrame:frame];
    
    if (self) {
        
        ///Initizaliting View
        mainWindowView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
       // mainWindowView.backgroundColor = [UIColor grayColor];
        mainWindow = [UIApplication sharedApplication].keyWindow;
        
        //Initizaliting Button frame
        fButtonView =[[UIView alloc]initWithFrame:frame];
        
        buttonToScreenHeight = viewHeight-CGRectGetMaxY(self.frame);
        
        fMenuTableView = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth/4,0,0.75*viewHeight,viewHeight-(viewHeight -CGRectGetMaxY(self.frame)))];
        fMenuTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,viewWidth/2,CGRectGetHeight(frame))];
        fMenuTableView.delegate = self;
        fMenuTableView.dataSource = self;
        fMenuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        fMenuTableView.transform = CGAffineTransformMakeRotation(-M_PI);
        fMenuTableView.scrollEnabled = NO;
        fMenuTableView.backgroundColor = [ UIColor clearColor];
        [self addSubview:fMenuTableView];
        
        plusImage = plusButtonImage;
        crossImage = crossButtonImage;
      
        [self buttonMetod];

    }
    return self;
}

-(void)buttonMetod{
    
    isMenuVisible = false;
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *buttonExpand = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonAction:)];
    [self addGestureRecognizer:buttonExpand];
    
    // FloatingButtonAction
    
    UITapGestureRecognizer *buttonClose = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonAction:)];
    [fButtonView addGestureRecognizer:buttonClose];
    
    // Overlay view
    UIBlurEffect *blurOverlay = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *fFloatView = [[UIVisualEffectView alloc]initWithEffect:blurOverlay];
    
    
    bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:10.10];
    bgView.alpha = 0;
    bgView.userInteractionEnabled = YES;
    
    fFloatView.frame = bgView.bounds;
    bgView = fFloatView;
    
    UITapGestureRecognizer *closeOverLlay = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonAction:)];
    closeOverLlay.cancelsTouchesInView = NO;
    [bgView addGestureRecognizer:closeOverLlay];
    
    // ImageView
    normalImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    normalImageView.userInteractionEnabled = YES;
    normalImageView.contentMode = UIViewContentModeScaleAspectFit;
    normalImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    normalImageView.layer.shadowRadius = 5.f;
    normalImageView.layer.shadowOffset = CGSizeMake(-10, -10);
    
    selectedImageView  = [[UIImageView alloc]initWithFrame:self.bounds];
    selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    selectedImageView.userInteractionEnabled = YES;
    
    normalImageView.image = plusImage;
    selectedImageView.image = crossImage;
    
    [bgView addSubview:fMenuTableView];
    
    [fButtonView addSubview:selectedImageView];
    [fButtonView addSubview:normalImageView];
    
    [self addSubview:normalImageView];
}
#pragma - mark ButtonAction
-(void)buttonAction:(id)sender{
    
    if (isMenuVisible){
        
        [self hideMenu:nil];
    }
    
    else {
        
        [mainWindowView addSubview:bgView];
        [mainWindowView addSubview:fButtonView];
        
        [mainWindow addSubview:mainWindowView];
        [self showMenu:nil];
    }
    isMenuVisible  = !isMenuVisible;
    
}
-(void)showMenu:(id)sender{
    selectedImageView.transform = CGAffineTransformMakeRotation(M_PI);
    selectedImageView.alpha = 0.0;
    [UIView animateWithDuration:animationTime/2 animations:^{
        
        bgView.alpha = 1;
        normalImageView.transform = CGAffineTransformMakeRotation(-M_PI);
        normalImageView.alpha = 0.0;
        
        selectedImageView.transform = CGAffineTransformIdentity;
        selectedImageView.alpha =1;
        noOfRows = labelArray.count;
        
        [fMenuTableView reloadData];
    }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(void)hideMenu:(id)sender{
    
    [UIView animateWithDuration:animationTime/2 animations:^{
        bgView.alpha = 0;
        selectedImageView.alpha = 0;
        selectedImageView.transform = CGAffineTransformMakeRotation(-M_PI);
        normalImageView.transform = CGAffineTransformMakeRotation(0);
        normalImageView.alpha = 1.f;
        
    }completion:^(BOOL finished) {
        noOfRows = 0;
        [bgView removeFromSuperview];
        [mainWindowView removeFromSuperview];
        [mainWindow removeFromSuperview];
        
    }];
}

#pragma -mark TableView;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return noOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    double delay = (indexPath.row*indexPath.row) * 0.004;  //Quadratic time function for progressive delay
    
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.95f, 0.95f);
    CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(0,-(indexPath.row+1)*CGRectGetHeight(cell.imageView.frame));
    cell.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    cell.alpha = 0.f;
    
    [UIView animateWithDuration:animationTime/2 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         cell.transform = CGAffineTransformIdentity;
         cell.alpha = 1.f;
         
     } completion:^(BOOL finished)
     {
     }];

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell== nil) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.transform = CGAffineTransformMakeRotation(-M_PI);
    
        UIImageView *iCons = [[UIImageView alloc]initWithFrame:CGRectMake(215, 0,45, 45)];
        iCons.tag = 1;
        iCons.clipsToBounds = YES;
        [iCons.layer setCornerRadius:iCons.frame.size.width/2.0f];
        [iCons.layer setMasksToBounds:YES];
        [cell.contentView addSubview:iCons];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake( 50, 10,150, 20)];
        titleLabel.tag = 2;
        titleLabel.textAlignment= NSTextAlignmentRight;
        [cell.contentView addSubview:titleLabel];
        
        UIView *  overlay = [UIView new];
        overlay.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [titleLabel  addSubview:overlay];
      
    
        }
    
    UIImageView * icon = (UIImageView * )[cell viewWithTag:1];
    UILabel * label = (UILabel *)[cell viewWithTag:2];
    
    icon.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    label.text = [labelArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [fDelegate didSelectMenuIndexPath:indexPath.row];
}

@end

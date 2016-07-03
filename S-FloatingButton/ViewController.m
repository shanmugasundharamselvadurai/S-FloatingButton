//
//  ViewController.m
//  S-FloatingButton
//
//  Created by Mine on 6/24/16.
//  Copyright © 2016 Shan. All rights reserved.
//

#import "ViewController.h"
#import "sFloatingButton.h"

#define  viewWidth [UIScreen mainScreen].bounds.size.width
#define  viewHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<floatingButtonDelegate>


@property(retain,nonatomic)sFloatingButton *floatBustton;


@end

@implementation ViewController
@synthesize floatBustton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     CGRect floatFrame = CGRectMake(viewWidth- 64, viewHeight-64, 50, 50);

    floatBustton = [[sFloatingButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus.png"]  andPressedImage:[UIImage imageNamed:@"cross.png"]];
    
    floatBustton.imageArray = @[@"googlePlus.png",@"instagram.png",@"facebook.png"];
    floatBustton.labelArray = @[@"Google Plus",@"Instagram",@"Facebook"];
    floatBustton.fDelegate = self;
    
    [self.view addSubview:floatBustton];
    
}

-(void)viewWillAppear:(BOOL)animated{
        [self.navigationController.navigationBar setBarTintColor:[UIColor greenColor]];
       // [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)didSelectMenuIndexPath :(NSInteger)row
{
    NSLog(@"Floating action tapped index %tu",row);
}


@end

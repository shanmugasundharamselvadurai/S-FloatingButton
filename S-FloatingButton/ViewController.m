//
//  ViewController.m
//  S-FloatingButton
//
//  Created by Mine on 6/24/16.
//  Copyright © 2016 Shan. All rights reserved.
//

#import "ViewController.h"
#import "sFloatingButton.h"

@interface ViewController ()<floatingButtonDelegate>


@property(retain,nonatomic)sFloatingButton *floatBustton;


@end

@implementation ViewController
@synthesize floatBustton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     CGRect floatFrame = CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 20, [UIScreen mainScreen].bounds.size.height - 44 - 20, 44, 44);

    floatBustton = [[sFloatingButton alloc]initWithFrame:floatFrame normalImage:[UIImage imageNamed:@"plus.png"]  andPressedImage:[UIImage imageNamed:@"cross.png"]];
    
    floatBustton.imageArray = @[@"photo",@"blackberry",@"apple"];
    floatBustton.labelArray = @[@"photo",@"BlackBerry",@"Apple"];
    floatBustton.fDelegate = self;
    
    
    [self.view addSubview:floatBustton];
    
    
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



//
//  BigViewController.m
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import "BigViewController.h"

@interface BigViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = [UIImage imageNamed:self.imageStr];
    
    self.imageView.userInteractionEnabled = YES;
    
    //添加一个手势
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [self.imageView addGestureRecognizer:tapGesture];
}

-(void)dismiss:(UIGestureRecognizer *)gesture{

    [self dismissViewControllerAnimated:YES completion:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

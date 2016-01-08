


//
//  MainViewController.m
//  沙盒操作Demo
//
//  Created by zk on 16/1/4.
//  Copyright © 2016年 zhu. All rights reserved.
//

#import "MainViewController.h"
#import "MainCollectionViewCell.h"
#import "BigViewController.h"
#import "AppDelegate.h"
#import "PlayViewController.h"

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;
@property (weak, nonatomic) IBOutlet UICollectionView *imageColletion;
@property (weak, nonatomic) IBOutlet UICollectionView *videoCollection;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSArray *videoArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置代理
    self.imageColletion.delegate = self;
    self.imageColletion.dataSource = self;
    self.videoCollection.delegate = self;
    self.videoCollection.dataSource = self;
    
    //注册cell
    [self.imageColletion registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    [self.videoCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    
    self.imageArray = [[NSArray alloc]init];
    self.videoArray = [[NSArray alloc]init];
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    self.videoArray = app.app_videoArray;
    self.imageArray = app.app_imageArray;
    
    self.imageColletion.tag = 1;
    self.videoCollection.tag = 2;
    
    //默认情况
    
    self.videoCollection.hidden = NO;
    self.imageColletion.hidden = YES;
    
    
}

#pragma mark - collectionDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(collectionView.tag == 1){
     
        return self.imageArray.count;
        
    }else{
     
        return self.videoArray.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

 
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    
    NSInteger row = (int)indexPath.row;
    
    if (collectionView.tag == 1) {
        
        cell.iconImageview.image = [UIImage imageNamed:self.imageArray[row]];
        
    }else{
     
        cell.iconImageview.image = [UIImage imageNamed:@"about_logo"];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(collectionView.tag == 1){
     
        BigViewController *bigVC = [[BigViewController alloc]init];
        bigVC.imageStr = self.imageArray[indexPath.row];
        [self presentViewController:bigVC animated:YES completion:nil];

    }else{
    
        PlayViewController *playVC = [[PlayViewController alloc]init];
        playVC.videoUrl = self.videoArray[indexPath.row];
        NSLog(@"playvc.urlstring:%@",playVC.videoUrl);
        [self presentViewController:playVC animated:YES completion:nil];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(SCRRENWIDTH/3,SCRRENWIDTH/3);
    
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}
//cell的最小列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


//视频
- (IBAction)onClickVideoBtn:(UIButton *)sender {
    
    [self.videoButton setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.imageButton setBackgroundColor:[UIColor whiteColor]];
    
    self.videoCollection.hidden = NO;
    
    self.imageColletion.hidden = YES;
}

//图片
- (IBAction)onClickPictureBtn:(UIButton *)sender {
    
    [self.videoButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.imageButton setBackgroundColor:[UIColor lightGrayColor]];
    
    self.videoCollection.hidden = YES;
    
    self.imageColletion.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  ViewController.m
//  LLYMedal2Demo
//
//  Created by lly on 2017/6/28.
//  Copyright © 2017年 lly. All rights reserved.
//

#import "ViewController.h"
#import "LLYMedalCell.h"
#import "LLYMedalHeaderView.h"
#import "LLYFlowLayout.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>


@property (nonatomic,strong) UICollectionView *mCollectionView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UIScrollView *mScrollView;
@property (nonatomic,assign) int currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.mScrollView];
    [self.view addSubview:self.mCollectionView];
    
    self.currentIndex = 0;
}


- (UICollectionView *)mCollectionView{

    if (!_mCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200) collectionViewLayout:flowLayout];
        _mCollectionView.delegate =  self;
        _mCollectionView.dataSource = self;
        _mCollectionView.backgroundColor = [UIColor redColor];
        
        [_mCollectionView registerNib:[UINib nibWithNibName:@"LLYMedalCell" bundle:nil] forCellWithReuseIdentifier:@"LLYMedalCell"];
        [_mCollectionView registerNib:[UINib nibWithNibName:@"LLYMedalHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLYMedalHeaderView"];
    }
    
    return _mCollectionView;
}

- (UIImageView *)headerImageView{

    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,200)];
        [_headerImageView setImage:[UIImage imageNamed:@"headerImage"]];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.layer.masksToBounds = YES;
    }
    return _headerImageView;
}

- (UIScrollView *)mScrollView{

    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, 30)];
        _mScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 30);
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        
        CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width/3;
        
        for (int i = 0; i < 6; ++i) {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, 30)];
            btn.tag = 1000+i;
            [btn setTitle:[NSString stringWithFormat:@"按钮%d",i] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_mScrollView addSubview:btn];
        }
    }
    
    return _mScrollView;
}


- (void)btnClicked:(id)sender{

    UIButton *btn = (UIButton *)sender;
    int index = (int)btn.tag - 1000;
    [self.mCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake([UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.width/3);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 2);
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    LLYMedalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLYMedalCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LLYMedalHeaderView *cell = (LLYMedalHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LLYMedalHeaderView" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.hidden = YES;
    }
    else{
        cell.hidden = NO;
    }
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"offsetY = %f",offsetY);
    //locate the scrollview which is in the centre
    
    CGPoint centerPoint = CGPointMake(50 + scrollView.contentOffset.x, scrollView.contentOffset.y);
    NSIndexPath *centerCellIndexPath = [self.mCollectionView indexPathForItemAtPoint:centerPoint];
    NSLog(@"sectionNumber===%ld",centerCellIndexPath.section);
    
    if (self.currentIndex != centerCellIndexPath.section) {
        self.currentIndex = (int)centerCellIndexPath.section;
        [self setBtnSelected:self.currentIndex];
    }
    
}



- (void)setBtnSelected:(int)index{

    for (UIView *btn in self.mScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if ((btn.tag - 1000) == index) {
                [btn setBackgroundColor:[UIColor redColor]];
            }
            else{
                [btn setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
    CGFloat btnWidth = [UIScreen mainScreen].bounds.size.width/3;
    if (index > 2) {
        [self.mScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width,0) animated:YES];
    }else{
        [self.mScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    }
}

// any offset changes

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  RecommendNewView.m
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendNewView.h"
#import "RecommendNewViewCell.h"
#import "IntroductionViewController.h"
#import "RecommendNewModel.h"
@interface RecommendNewView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSArray *rNewList;
@end

static NSString *recommentNewViewCellId = @"cellId";
@implementation RecommendNewView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemW = 120;
    CGFloat itemH = 250;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat collectionViewY = 0;
    CGFloat collectionViewH = itemH;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, ScreenWidth, collectionViewH) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[RecommendNewViewCell class] forCellWithReuseIdentifier:recommentNewViewCellId];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)setList:(NSArray *)list
{
    _list = list;
    self.rNewList = list;
    [self.collectionView reloadData];
}

- (void)setModel:(RecommendListModel *)model
{
    _model = model;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rNewList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendNewViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommentNewViewCellId forIndexPath:indexPath];
    
    cell.model = self.rNewList[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    RecommendNewModel *model = self.rNewList[indexPath.item];
    IntroductionViewController *vc = [[IntroductionViewController alloc] init];
    vc.dataId = model.ProjectID;
    vc.hidesBottomBarWhenPushed = YES;
    [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
}

@end

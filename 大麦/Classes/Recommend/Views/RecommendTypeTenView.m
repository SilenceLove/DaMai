//
//  RecommendTypeTenView.m
//  大麦
//
//  Created by 洪欣 on 16/12/15.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendTypeTenView.h"
#import "IntroductionViewController.h"
@interface RecommendTypeTenView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) UILabel *titleLb;
@property (weak, nonatomic) UILabel *subTitleLb;
@property (weak, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSArray *list;
@end

static NSString *recommendTypeTenViewCellId = @"RecommendTypeTenViewCell";
@implementation RecommendTypeTenView

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
    
    CGFloat itemW = ScreenWidth;
    CGFloat itemH = 100;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    CGFloat collectionViewY = 0;
    CGFloat collectionViewH = itemH + 5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, ScreenWidth, collectionViewH) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[RecommendTypeTenViewCell class] forCellWithReuseIdentifier:recommendTypeTenViewCellId];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}
- (void)setListModel:(RecommendListModel *)listModel
{
    _listModel = listModel;
    self.list = listModel.list;
    self.collectionView.height = listModel.list.count * 100 + 5;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTypeTenViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendTypeTenViewCellId forIndexPath:indexPath];
    cell.model = self.list[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendListSubModel *model = self.list[indexPath.item];
    if (model.type.integerValue == 0) {
        IntroductionViewController *vc = [[IntroductionViewController alloc] init];
        vc.dataId = model.context;
        vc.hidesBottomBarWhenPushed = YES;
        [[self getCurrentViewController].navigationController pushViewController:vc animated:YES];
    }
}
@end

@interface RecommendTypeTenViewCell ()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation RecommendTypeTenViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setModel:(RecommendListSubModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end

//
//  RecommendMiddleView.m
//  大麦
//
//  Created by 洪欣 on 16/12/14.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "RecommendMiddleView.h"
#import "RecommendListModel.h"
#import "RecommendListSubModel.h"
#import "IntroductionViewController.h"
@interface RecommendMiddleView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (copy, nonatomic) NSArray *list;
@property (weak, nonatomic) UIView *lineView;
@end

static NSString *recommendMiddleViewCellId = @"celId";
@implementation RecommendMiddleView

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
    
    CGFloat itemW = (ScreenWidth - 8) / 2;
    CGFloat itemH = itemW / 16 * 7;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);
    
    CGFloat collectionViewY = 0;
    CGFloat collectionViewH = itemH * 2 + 10;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectionViewY, ScreenWidth, collectionViewH) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[RecommendMiddleViewCell class] forCellWithReuseIdentifier:recommendMiddleViewCellId];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, collectionViewY, 0.5, collectionViewH - 10)];
    lineView.centerX = ScreenWidth / 2;
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    UIView *lineViewH = [[UIView alloc] initWithFrame:CGRectMake(0, itemH - 0.5, ScreenWidth, 0.5)];
    lineViewH.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self addSubview:lineViewH];
}

- (void)setModel:(RecommendListModel *)model
{
    _model = model;
    self.list = model.list;
    CGFloat itemW = (ScreenWidth - 8) / 2;
    CGFloat itemH = itemW / 16 * 7;
    self.collectionView.height = itemH * (model.list.count / 2) + 5;
    self.lineView.y = self.collectionView.y;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendMiddleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:recommendMiddleViewCellId forIndexPath:indexPath];
    cell.model = self.list[indexPath.item];
    
    HXWeakSelf
    [cell setDidCell:^(UICollectionViewCell *cell) {
        NSInteger seletedIndex = [weakSelf.collectionView indexPathForCell:cell].item;
        RecommendListSubModel * model = weakSelf.list[seletedIndex];
        if (model.type.integerValue == 0) {
            IntroductionViewController *vc = [[IntroductionViewController alloc] init];
            vc.dataId = model.context;
            vc.hidesBottomBarWhenPushed = YES;
            [[weakSelf getCurrentViewController].navigationController pushViewController:vc animated:YES];
        }
    }];
    return cell;
}

@end

@interface RecommendMiddleViewCell ()
@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation RecommendMiddleViewCell

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
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didCellClick)]];
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)didCellClick
{
    if (self.didCell) {
        self.didCell(self);
    }
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

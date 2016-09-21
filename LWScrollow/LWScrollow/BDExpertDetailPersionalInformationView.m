//
//  BDExpertDetailPersionalInformationView.m
//  scrollView实现header悬停
//
//  Created by 1 on 16/3/22.
//  Copyright © 2016年 linwei. All rights reserved.
//

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "BDExpertDetailPersionalInformationView.h"

@interface BDExpertDetailPersionalInformationView()
@property (nonatomic, weak) UIImageView *backgroundImageView;

/**
 *  个性标签
 */
@property (nonatomic, strong) NSArray *propertieLabels;

@end
@implementation BDExpertDetailPersionalInformationView

#pragma mark - 通过set方法将数据源传入
- (void)setPropertieLabels:(NSArray *)propertieLabels
{
    _propertieLabels = propertieLabels;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加imageView
        [self setupBackgroundImageView];
        
        //设置毛玻璃
        [self setupBlurView];
        
        //设置个人信息viwe
        [self setupOwnerInformationView];
    }
    return self;
}

- (void)setupBackgroundImageView
{
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.image = [UIImage imageNamed:@"Snip20160322_3"];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    
}
/**
 *  毛玻璃效果
 */
- (void)setupBlurView
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [toolBar setBarStyle:UIBarStyleBlack];
    toolBar.alpha = 0.7;
    [self.backgroundImageView addSubview:toolBar];
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [toolBar makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];
}

- (void)setupOwnerInformationView
{
    UIView *ownerView = [[UIView alloc] init];
    [self addSubview:ownerView];
    self.ownerView = ownerView;
    [ownerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        
    }];
    
    
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    [ownerView addSubview:avatarImageView];
    avatarImageView.image = [UIImage imageNamed:@"Snip20160322_5"];
    [avatarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(ownerView);
        make.top.equalTo(ownerView);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor greenColor];
    nameLabel.text = @"痛并快乐着";
    [ownerView addSubview:nameLabel];
    [nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avatarImageView.mas_bottom).offset(5);
        make.centerX.equalTo(ownerView);
    }];

    CGFloat propertieLabelY = 0;
    CGFloat propertieLabelW = 50;
    CGFloat propertieLabelH = 40;
    
    UIView *propertieView = [[UIView alloc] init];
    propertieView.backgroundColor = [UIColor redColor];
    [ownerView addSubview:propertieView];
    
    [propertieView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ownerView);
        make.size.equalTo(CGSizeMake(self.propertieLabels.count *propertieLabelW, propertieLabelH));
        make.top.equalTo(nameLabel.mas_bottom).offset(5);
    }];
    
    for (NSInteger i = 0; i < self.propertieLabels.count; i++) {
        UILabel *propertieLabel = [[UILabel alloc] init];
        
        propertieLabel.frame = CGRectMake(i * propertieLabelW, propertieLabelY,propertieLabelW, propertieLabelH);
        propertieLabel.text = @"大叔控";
        propertieLabel.textColor = [UIColor orangeColor];
        propertieLabel.font = [UIFont systemFontOfSize:10];
        [propertieView addSubview:propertieLabel];
    }
    
    //个性签名
    UILabel *propertieSignLabel = [[UILabel alloc] init];
    [ownerView addSubview:propertieSignLabel];
    propertieSignLabel.font = [UIFont systemFontOfSize:14];
    propertieSignLabel.numberOfLines = 0;
    propertieSignLabel.text = @"和哈哈哈哈哈哈哈哈哈哈哈哈和哈哈哈哈哈哈哈哈哈哈哈哈";
    propertieSignLabel.textColor = [UIColor whiteColor];
    
    [propertieSignLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(222);
        make.centerX.equalTo(ownerView);
        make.top.equalTo(propertieView.mas_bottom).offset(5);
    }];
    
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.backgroundImageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}



@end

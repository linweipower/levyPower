//
//  ViewController.m
//  尝试嵌套多层scrollview
//
//  Created by 1 on 16/3/24.
//  Copyright © 2016年 com.power.linwei. All rights reserved.
//
#import "BDExpertDetailPersionalInformationView.h"
#import "BDScrollowToV.h"
#import "BDScrollowToH.h"
#import "ThreeTableViewController.h"
#import "TowTableViewController.h"
#import "OneTableViewController.h"
#import "ViewController.h"
#import "UIView+LWView_Extension.h"
#define screenH  [UIScreen mainScreen].bounds.size.height
#define screenW  [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) OneTableViewController *oneVC;
@property (nonatomic, strong) TowTableViewController *twoVC;
@property (nonatomic, strong) ThreeTableViewController *threeVC;

// 头部标题视图
@property (weak, nonatomic)  UIView * titleView;

//被选中的上一个按钮
@property (weak, nonatomic)  UIButton * preSelectedBtn;

//下划线-指示器
@property (weak, nonatomic)  UIView * underLine;

// scrollerview
@property (weak, nonatomic)  UIScrollView * scrollView;
@property (weak, nonatomic) UIScrollView *scrollowH;
@property (weak, nonatomic) BDExpertDetailPersionalInformationView *perView;

@end


@implementation ViewController

#pragma mark 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    设置背景
    //    self.view.backgroundColor = LWGrayColor(206);
    
    //   1. 设置导航栏
    [self setupScrollowH];
    
    [self setupPerView];
    
    [self setupTitleView];
    //   2. 添加所有的子控制器
    [self setupChildViewController];
    
    //   3. 添加内容视图--scrollerview
    [self setupContentScrollView];
    
    //    最后添加,显示在最上面
    //   4. 添加头部标题视图-uiview
    //    [self setupTitleView];
    
    self.scrollView.delegate = self;
    
    //    5.默认添加第一个子控制器
    [self addChildViewIntoScrollView];
    //     [self setupTitleView];
    
    //    self.scrollowH.bounces = NO;K
    
}

- (void)setupPerView
{
    BDExpertDetailPersionalInformationView *perView = [[BDExpertDetailPersionalInformationView alloc] init];
    perView.frame = CGRectMake(0, 0, screenW, 270);
    
    [self.scrollowH addSubview:perView];
    self.perView = perView;
}

- (void)setupScrollowH
{
    UIScrollView *scrollowH = [[UIScrollView alloc] init];
    scrollowH.frame = self.view.bounds;
    [self.view addSubview:scrollowH];
    self.scrollowH = scrollowH;
    scrollowH.backgroundColor = [UIColor colorWithRed:100/255.0 green:200/255.0 blue:150/255.0 alpha:1];
    scrollowH.contentSize = CGSizeMake(0,screenH + 206);
    scrollowH.delegate = self;
    scrollowH.showsVerticalScrollIndicator = NO;
}


#pragma mark 其他

// 2. 添加所有的子控制器
- (void)setupChildViewController{
    self.oneVC = [[OneTableViewController alloc] init];
    [self addChildViewController:self.oneVC];
    
    self.twoVC = [[TowTableViewController alloc] init];
    [self addChildViewController:self.twoVC];
    
    self.threeVC = [[ThreeTableViewController alloc] init];
    [self addChildViewController:self.threeVC];
    
}


//   3. 添加内容视图--scrollerview
- (void)setupContentScrollView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    
    //    设置scrollerview的frame = 屏幕的bounds.
    scrollV.frame = CGRectMake(0, 314, screenW, screenH - 108);
    //    scrollV.contentOffset = CGPointMake(0,  -(314 + 44));
    [self.scrollowH addSubview:scrollV];
    //    隐藏scrollerview的滚动条
    scrollV.showsHorizontalScrollIndicator = NO;
    scrollV.showsVerticalScrollIndicator = NO;
    
    //    设置scrollerview的内容的滚动范围
    scrollV.contentSize = CGSizeMake(self.childViewControllers.count * scrollV.LW_width, 0);
    
    //    设置分页效果
    scrollV.pagingEnabled = YES;
    self.scrollView = scrollV;
    
}


//   4. 添加头部标题视图-uiview
- (void)setupTitleView{
    
    UIView *titleView = [[UIView alloc] init];
    
    titleView.backgroundColor = [UIColor blackColor];
    titleView.frame = CGRectMake(0, 270, screenW, 44);
    self.titleView = titleView;
    [self.scrollowH addSubview:titleView];
    
    //    4.1  添加头部标题视图的按钮--自定义按钮
    [self setupTitleBtn];
    
    //    4.2  添加下划线
    [self setupUnderLine];
    
}


//    4.1  添加自定义按钮
- (void)setupTitleBtn{
    
    NSArray *btnTitle = @[@"one",@"two",@"three"];
    NSInteger btnCount = btnTitle.count;
    
    CGFloat btnW = self.titleView.LW_width / btnCount;
    CGFloat btnH = self.titleView.LW_height;
    
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        CGFloat btnX = i * btnW;
        
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        [btn setTitle: btnTitle[i] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.titleView addSubview:btn];
        
    }
}


//    4.2  添加下划线
- (void)setupUnderLine{
    
    //    让第一个按钮选中
    UIButton *firstBtn = self.titleView.subviews.firstObject;
    firstBtn.selected = YES;
    self.preSelectedBtn = firstBtn;
    
    //    创建下划线指示器
    UIView *underLine = [[UIView alloc] init];
    
    underLine.LW_height = 2;
    underLine.LW_y = self.titleView.LW_height - underLine.LW_height;
    
    //    下划线的宽度根据文字的内容计算,lable包裹文字
    //    根据内容自动计算文字的宽度
    [firstBtn.titleLabel sizeToFit];
    underLine.LW_width = firstBtn.titleLabel.LW_width + 10;
    underLine.LW_centerX = firstBtn.LW_centerX;
    
    //    设置下划线的颜色
    underLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    //    underLine.backgroundColor = [UIColor redColor];
    
    [self.titleView addSubview:underLine];
    self.underLine = underLine;
    
}

//  5. 添加对应子控制器的view到scrollerview
//  --在scrollerview滚动完成时调用

- (void)addChildViewIntoScrollView{
    
    //  根据偏移量计算对应的子控制器的索引
    NSInteger index =  self.scrollView.contentOffset.x / self.scrollView.LW_width;
    
    //    取出对应的子控制器
    UIViewController * childVc = self.childViewControllers[index];
    
    //    判断子控制器的view有没有加载成功.
    if ([childVc isViewLoaded]) return;
    
    //    设置子控制器的背景色
    //    childVc.view.backgroundColor = LWRandomColor;
    
    //    添加对应子控制器的view到scrollerview上.
    [self.scrollView addSubview:childVc.view];
    
    //    设置frame
    childVc.view.frame = self.scrollView.bounds;
    
}


#pragma mark 代理方法

// 1 .拖拽UIScrollview 停止滚动时调用
//   ---调用点击按钮的方法---点击对应的按钮
//   ---调用添加子控制器view的方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    //   拖拽滚动scrollerview时,计算偏移量,根据偏移量计算按钮的角标,点击对应的按钮.
    //    if (scrollView.contentOffset.y < ) return;
    NSLog(@"kkkk%f", scrollView.contentOffset.y);
    if (scrollView == self.scrollowH) return;
    //   按钮的角标
    NSInteger index = scrollView.contentOffset.x / scrollView.LW_width;
    
    //    滚动到当前对应的按钮
    UIButton *currentBtn = self.titleView.subviews[index];
    //    点击对应的按钮
    [self clickTitleButton:currentBtn];
    
    //   添加对应子控制器的view到scrollerview--滚动完成才添加-懒加载
    [self addChildViewIntoScrollView];
    
}

// 2.
/**
 *  当scrollView停止滚动时调用
 *  前提：通过调用scrollView的以下2个方法导致停止滚动
 
 - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;
 - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self addChildViewIntoScrollView];
}



#pragma mark 监听事件

//  2. 监听头部视图中--按钮的点击
- (void)clickTitleButton :(UIButton *)titleBtn{
    
    //   切换按钮的选中状态
    self.preSelectedBtn.selected = NO;
    titleBtn.selected = YES;
    self.preSelectedBtn = titleBtn;
    
    //    让下划线滚动到对应的按钮
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.LW_width = titleBtn.titleLabel.LW_width + 10;
        self.underLine.LW_centerX = titleBtn.LW_centerX;
        
    }];
    
    
    //    点击按钮时,根据角标,计算偏移量,让scrollerview滚到对应的位置.
    
    
    //  按钮角标
    NSInteger indexBtn = titleBtn.tag;
    
    //  保存scrollerview的偏移量
    CGPoint offsetOfChildVc = self.scrollView.contentOffset;
    
    //  计算偏移量x值 = 对应按钮的索引 * 屏幕宽度
    offsetOfChildVc.x = indexBtn * self.scrollView.LW_width;
    
    //   滚动到对应区域--偏移量
    [self.scrollView setContentOffset:CGPointMake(offsetOfChildVc.x, 0) animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
    
    if (scrollView == self.scrollowH) {
        CGFloat offset = scrollView.contentOffset.y;
        if (offset >= 206) {
            self.oneVC.tableView.scrollEnabled = YES;
            self.twoVC.tableView.scrollEnabled = YES;
            self.threeVC.tableView.scrollEnabled = YES;
            
            [self.titleView removeFromSuperview];
            self.titleView.frame = CGRectMake(0, 64, screenW, 44);
            [self.view addSubview:self.titleView];
            
            [self.perView removeFromSuperview];
            self.perView.frame = CGRectMake(0, -206, screenW, 270);
            [self.view addSubview:self.perView];
            
        }else
        {
            self.oneVC.tableView.scrollEnabled = NO;
            self.twoVC.tableView.scrollEnabled = NO;
            self.threeVC.tableView.scrollEnabled = NO;
            
            [self.titleView removeFromSuperview];
            self.titleView.frame = CGRectMake(0, 270, screenW, 44);
            [self.scrollowH addSubview:self.titleView];
            
            [self.perView removeFromSuperview];
            self.perView.frame = CGRectMake(0, 0, screenW, 270);
            [self.scrollowH addSubview:self.perView];
        }
    }
    
    
}

@end


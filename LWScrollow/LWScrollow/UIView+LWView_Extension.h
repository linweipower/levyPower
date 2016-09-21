
#import <UIKit/UIKit.h>

@interface UIView (LWUIView_Extension)

//  分类里只声明set,get方法,需要自己写实现

@property (assign, nonatomic) CGFloat LW_width;
@property (assign, nonatomic) CGFloat LW_height;
@property (assign, nonatomic) CGFloat LW_x;
@property (assign, nonatomic) CGFloat LW_y;

@property (assign, nonatomic) CGFloat LW_centerY;
@property (assign, nonatomic) CGFloat LW_centerX;


//扩充从xib加载view的方法
+ (instancetype)LW_viewFromXib;

@end

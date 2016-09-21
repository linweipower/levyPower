
#import "UIView+LWView_Extension.h"

@implementation UIView (LWUIView_Extension)

+ (instancetype)LW_viewFromXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

//  写实现
//  宽高
- (void)setLW_height:(CGFloat)LW_height{
    
    CGRect frame = self.frame;
    frame.size.height = LW_height;
    self.frame = frame;
}

- (void)setLW_width:(CGFloat)LW_width{
    
    CGRect frame = self.frame;
    frame.size.width = LW_width;
    self.frame = frame;
}

- (CGFloat)LW_width{
    
    return self.frame.size.width;
}


-(CGFloat)LW_height{
    
    return self.frame.size.height;
}


//  x,y
- (void)setLW_x:(CGFloat)LW_x{
    
    CGRect frame = self.frame;
    frame.origin.x = LW_x;
    self.frame = frame;
}
- (void)setLW_y:(CGFloat)LW_y{
    
    CGRect frame = self.frame;
    frame.origin.y = LW_y;
    self.frame = frame;
    
}

- (CGFloat)LW_x{
    
    return self.frame.origin.x;
}
- (CGFloat)LW_y{
    
    return self.frame.origin.y;
}


// centerX,Y

- (void)setLW_centerX:(CGFloat)LW_centerX{
    
    CGPoint center = self.center;
    center.x = LW_centerX;
    self.center = center;
}

-(void)setLW_centerY:(CGFloat)LW_centerY{
    
    CGPoint center = self.center;
    center.y = LW_centerY;
    self.center = center;
}

- (CGFloat)LW_centerY{
    return self.center.y;
}

- (CGFloat)LW_centerX{
    return self.center.x;
}

@end

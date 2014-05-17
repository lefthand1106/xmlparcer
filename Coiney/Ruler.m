//
//  Ruler.m
//  Coiney
//
//  Created by 篠原正樹 on 2014/05/15.
//  Copyright (c) 2014年 masakishinohara. All rights reserved.
//

#import "Ruler.h"

@implementation Ruler

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = UIColor.clearColor; //背景を透明に
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect  screenSize = [[UIScreen mainScreen] bounds];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();  // コンテキストを取得
    
    // 線を黒色にする
    CGContextSetStrokeColorWithColor(context,UIColor.blackColor.CGColor);
    
    // 線の太さを指定
    CGContextSetLineWidth(context, 2.0);  //
    CGContextMoveToPoint(context, 0, 180);  // 始点
    CGContextAddLineToPoint(context, screenSize.size.width, 180); // 終点
    CGContextStrokePath(context);  // 描画

}


@end

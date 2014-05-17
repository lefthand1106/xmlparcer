//
//  ViewController.h
//  Coiney
//
//  Created by 篠原正樹 on 2014/05/15.
//  Copyright (c) 2014年 masakishinohara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>{
   
    NSString *nowTagStr;
    NSString *txtBuffer;
    
    NSMutableArray *sumAmount;
    
    UILabel *labelTitle;
    UILabel *labelSubTitle;
    UILabel *labelName;
    UILabel *labelPrice;
    UILabel *labelTotal1;
    UILabel *labelTotal2;

}

@property (strong, nonatomic) UITextView *textView;

@end

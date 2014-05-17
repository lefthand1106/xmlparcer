//
//  ViewController.m
//  Coiney
//
//  Created by 篠原正樹 on 2014/05/15.
//  Copyright (c) 2014年 masakishinohara. All rights reserved.
//

#import "ViewController.h"
#import "Ruler.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //それぞれの金額を格納する配列を生成
    sumAmount = [[NSMutableArray alloc]init];
    //テキストビューの初期化
    [self initTextView];
    //ラベルの初期化
    [self initLabel];
    //ファイル指定してXMLパーサーを作る
    [self setXMLParser];
}

//テキストビューの初期化
-(void)initTextView
{
    //グレースケール設定
    CGRect  screenSize = [[UIScreen mainScreen] bounds];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, screenSize.size.width, screenSize.size.height)];
    self.textView.opaque = NO;
    self.textView.backgroundColor = [UIColor colorWithWhite:.5f alpha:.6f];
    [self.view addSubview:self.textView];
}

//ラベルの初期化
- (void)initLabel
{
    NSString * font = @"AppleGothic";
    
    labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.numberOfLines = 0;
    labelTitle.font = [UIFont fontWithName:font size:21];
    //labelTitle.backgroundColor =[UIColor yellowColor];確認用
    
    labelSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    labelSubTitle.textAlignment = NSTextAlignmentCenter;
    labelSubTitle.numberOfLines = 0;
    labelSubTitle.font = [UIFont fontWithName:font size:12];
    //labelSubTitle.backgroundColor =[UIColor redColor];確認用
    
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    labelName.textAlignment = NSTextAlignmentLeft;
    labelName.numberOfLines = 0;
    labelName.font = [UIFont fontWithName:font size:15];
    //labelName.backgroundColor =[UIColor blueColor];確認用
    
    labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(150, 200, 100, 100)];
    labelPrice.textAlignment = NSTextAlignmentRight;
    labelPrice.numberOfLines = 0;
    labelPrice.font = [UIFont fontWithName:font size:15];
    //labelPrice.backgroundColor =[UIColor brownColor];確認用
    
    //@"合計"を固定表示
    labelTotal1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 300, 100, 30)];
    labelTotal1.textAlignment = NSTextAlignmentLeft;
    labelTotal1.font = [UIFont fontWithName:font size:15];
    //labelTotal1.backgroundColor =[UIColor greenColor];確認用
    
    labelTotal2 = [[UILabel alloc] initWithFrame:CGRectMake(150, 300, 100, 30)];
    labelTotal2.textAlignment = NSTextAlignmentRight;
    labelTotal2.font = [UIFont fontWithName:font size:15];
    //labelTotal2.backgroundColor =[UIColor purpleColor];確認用
    
    //ラベルのテキストを空欄にする
    labelTitle.text = @"";
    labelSubTitle.text = @"";
    labelName.text = @"";
    labelPrice.text = @"";
    labelTotal1.text = @"合計";
    labelTotal2.text = @"";
    
    //ラベルを画面に追加
    [self.view addSubview:labelTitle];
    [self.view addSubview:labelSubTitle];
    [self.view addSubview:labelName];
    [self.view addSubview:labelPrice];
    [self.view addSubview:labelTotal1];
    [self.view addSubview:labelTotal2];
}

//URLを指定してXMLパーサーを作る
- (void)setXMLParser
{
    //XMLを読み込む
    NSURL *myURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"sample" ofType:@"xml"]];
    //XMLパーサを初期化
	NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:myURL];
    //デリゲート指定
	myParser.delegate = self;
	// 解析を開始する
	[myParser parse];
}

//解析開始時の処理
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	//解析中タグの初期化
	nowTagStr = @"";
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    //開始タグが「title」だったら
    if ([elementName isEqualToString:@"title"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
    }
    
    //開始タグが「subtitle」だったら
    else if ([elementName isEqualToString:@"subtitle"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
	}
    
    //開始タグが「ruler」だったら
    else if ([elementName isEqualToString:@"ruler/"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
    }
    
    //開始タグが「name」だったら
    else if ([elementName isEqualToString:@"name"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
	}
    
    //開始タグが「price」だったら
    else if ([elementName isEqualToString:@"price"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
	}
    
    //開始タグが「total」だったら
    else if ([elementName isEqualToString:@"total/"]) {
		//解析中タグに設定
		nowTagStr = [NSString stringWithString:elementName];
		//テキストバッファの初期化
		txtBuffer = @"";
	}
}


//テキストバッファに文字を追加する
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//解析中のタグが「title」だったら
    if ([nowTagStr isEqualToString:@"title"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
    
    //解析中のタグが「subtitle」だったら
    else if ([nowTagStr isEqualToString:@"subtitle"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
    
    //解析中のタグが「ruler」だったら
    else if ([nowTagStr isEqualToString:@"ruler/"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
    
    //解析中のタグが「mname」だったら
    else if ([nowTagStr isEqualToString:@"name"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
    
    //解析中のタグが「price」だったら
    else if ([nowTagStr isEqualToString:@"price"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
	}
    
    //解析中のタグが「total」だったら
    else if ([nowTagStr isEqualToString:@"total/"]) {
		//テキストバッファに文字を追加する
		txtBuffer = [txtBuffer stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
	//終了タグが「title」だったら
    if ([elementName isEqualToString:@"title"]) {
		//ラベルにテキストバッファの文字を追加する
        labelTitle.text = [labelTitle.text stringByAppendingFormat:
                           @"%@", txtBuffer];
    }
    
	//終了タグが「subtitle」だったら
    else if ([elementName isEqualToString:@"subtitle"]) {
		//ラベルにテキストバッファの文字を追加する
        labelSubTitle.text = [labelSubTitle.text stringByAppendingFormat:
                              @"%@\n", txtBuffer];
    }
    
    //終了タグが「ruler」だったら
    else if ([elementName isEqualToString:@"ruler"]) {
        //線を画面に追加
        Ruler *bs = [[Ruler alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:bs];
    }
    
    //終了タグが「name」だったら
    else if ([elementName isEqualToString:@"name"]) {
        //ラベルにテキストバッファの文字を追加する
        labelName.text = [labelName.text stringByAppendingFormat:
                          @"%@\n", txtBuffer];
    }
    
	//終了タグが「price」だったら
    else if ([elementName isEqualToString:@"price"]) {
        //ラベルにテキストバッファの文字を追加する
        labelPrice.text = [labelPrice.text stringByAppendingFormat:
                           @"¥%@\n", txtBuffer];
        [sumAmount addObject:txtBuffer];
    }
    
	//終了タグが「total」だったら
    else if ([elementName isEqualToString:@"total"]) {
        //ラベルにテキストバッファの文字を追加する
        NSInteger sum = 0;
        for (NSString *num in sumAmount) {
            sum += [num intValue];
        }
        labelTotal2.text =[labelTotal2.text stringByAppendingFormat:
                           @"¥%d", sum];
    }
}

@end

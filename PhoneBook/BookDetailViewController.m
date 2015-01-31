//
//  BookDetailViewController.m
//  PhoneBook
//
//  Created by apple on 15/1/31.
//  Copyright (c) 2015年 huangcan.me. All rights reserved.
//

#import "BookDetailViewController.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
-(instancetype)initWithBook:(PhoneBook *)book{
    self=[super init];
    if (self) {
        _book=book;
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"电话薄详情";
    Name=[[UILabel alloc]initWithFrame:CGRectMake(0.15*ScreenWidth, 0.2*ScreenHeight, 0.2*ScreenWidth, 15)];
    [Name setTextAlignment:NSTextAlignmentLeft];
    [Name setFont:[UIFont fontWithName:@"Arial" size:15]];
    [Name setText:@"姓名:"];
    [self.view addSubview:Name];

    Email=[[UILabel alloc]initWithFrame:CGRectMake(0.15*ScreenWidth, 0.2*ScreenHeight+20, 0.2*ScreenWidth, 15)];
    [Email setTextAlignment:NSTextAlignmentLeft];
    [Email setFont:[UIFont fontWithName:@"Arial" size:15]];
    [Email setText:@"邮箱:"];
    [self.view addSubview:Email];

    tel=[[UILabel alloc]initWithFrame:CGRectMake(0.15*ScreenWidth, 0.2*ScreenHeight+40, 0.2*ScreenWidth, 15)];
    [tel setTextAlignment:NSTextAlignmentLeft];
    [tel setFont:[UIFont fontWithName:@"Arial" size:15]];
    [tel setText:@"电话号码:"];
    [self.view addSubview:tel];


    Name2=[[UILabel alloc]initWithFrame:CGRectMake(0.4*ScreenWidth, 0.2*ScreenHeight, 0.45*ScreenWidth, 15)];
    [Name2 setTextAlignment:NSTextAlignmentLeft];
    [Name2 setFont:[UIFont fontWithName:@"Arial" size:15]];
    [Name2 setText:_book.name];
    [Name2 setTextColor:[UIColor blackColor]];
    [self.view addSubview:Name2];



    Email2=[[UILabel alloc]initWithFrame:CGRectMake(0.4*ScreenWidth, 0.2*ScreenHeight+20, 0.45*ScreenWidth, 15)];
    [Email2 setTextAlignment:NSTextAlignmentLeft];
    [Email2 setFont:[UIFont fontWithName:@"Arial" size:15]];
     [Email2 setTextColor:[UIColor blackColor]];
    [Email2 setText:_book.email];
    [self.view addSubview:Email2];



    tel2=[[UILabel alloc]initWithFrame:CGRectMake(0.4*ScreenWidth, 0.2*ScreenHeight+40, 0.45*ScreenWidth, 15)];
    [tel2 setTextAlignment:NSTextAlignmentLeft];
    [tel2 setFont:[UIFont fontWithName:@"Arial" size:15]];
     [tel2 setTextColor:[UIColor blackColor]];
    [tel2 setText:_book.tel];
    [self.view addSubview:tel2];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

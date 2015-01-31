//
//  BookDetailViewController.h
//  PhoneBook
//
//  Created by apple on 15/1/31.
//  Copyright (c) 2015年 huangcan.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneBook.h"
@interface BookDetailViewController : UIViewController
{
    UILabel *Name,*Name2,*Email,*Email2,*tel,*tel2;
    PhoneBook *_book;
}
-(instancetype)initWithBook:(PhoneBook *)book;
@end

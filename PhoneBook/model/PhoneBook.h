//
//  PhoneBook.h
//  PhoneBook
//
//  Created by apple on 15/1/31.
//  Copyright (c) 2015年 huangcan.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneBook : NSObject
@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger recordID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;
@end

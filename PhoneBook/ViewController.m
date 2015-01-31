//
//  ViewController.m
//  PhoneBook
//
//  Created by apple on 15/1/31.
//  Copyright (c) 2015年 huangcan.me. All rights reserved.
//

#import "ViewController.h"
#import "PhoneBook.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BookDetailViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"电话薄";
    [self.view setBackgroundColor:[UIColor colorWithRed:244.0f/255 green:244.0f/255  blue:244.0f/255  alpha:1.0f]];
    BookTable =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    [BookTable setBackgroundColor:[UIColor clearColor]];
    BookTable.delegate=self;
    BookTable.dataSource=self;
    [self.view addSubview:BookTable];
    BookArray =[[NSMutableArray alloc]init];

    [self loadBook];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UitableView Delegate And DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ifile=@"_cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ifile];
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ifile];
    }
    PhoneBook *book=BookArray[indexPath.row];
    cell.textLabel.text=book.name;
    cell.textLabel.font=[UIFont fontWithName:@"Arial" size:15];
    cell.textLabel.textAlignment=NSTextAlignmentLeft;
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhoneBook *book=BookArray[indexPath.row];
    BookDetailViewController *detail=[[BookDetailViewController alloc]initWithBook:book];
    [self.navigationController pushViewController:detail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (ScreenHeight-64)/12;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [BookArray count];
}

#pragma mark -LoadBook
-(void)loadBook{
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;

    if (Version >= 6.0)

    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);

        //获取通讯录权限

        dispatch_semaphore_t sema = dispatch_semaphore_create(0);

        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});

        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

    }

    else

    {
        addressBooks = ABAddressBookCreate();

    }

    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);


    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);

    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        PhoneBook *phonebook = [[PhoneBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;

        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        phonebook.name = nameString;
        phonebook.recordID = (int)ABRecordGetRecordID(person);;

        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);

            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        phonebook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        phonebook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中
        [BookArray addObject:phonebook];

        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}
@end

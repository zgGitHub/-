//
//  ViewController.m
//  联系人索引
//
//  Created by Vmeet Lv on 15/3/6.
//  Copyright (c) 2015年 vmeet. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取通讯录里联系人姓名和手机号
    [self address];
    
    userSource = [[NSMutableArray alloc] init];
    for (char i = 'A'; i<='Z'; i++)
    {
         NSMutableArray *numarr = [[NSMutableArray alloc] init];
         NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        for (int j=0; j<dataSource.count; j++)
        {
            Model *model = [dataSource objectAtIndex:j];
            //获取姓名首位
            NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
            //将姓名首位转换成NSData类型
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            //data的长度大于等于3说明姓名首位是汉字
            if (data.length >=3)
            {
                //将汉字首字母拿出
                char a = pinyinFirstLetter([model.name characterAtIndex:0]);
                
                //将小写字母转成大写字母
                char b = a-32;
                if (b == i)
                {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array addObject:model.name];
                    if (model.tel != nil)
                    {
                        [array addObject:model.tel];
                    }
                    
                    [numarr addObject:array];
                    [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                }
                
            }
            else
            {
                //data的长度等于1说明姓名首位是字母或者数字
                if (data.length == 1)
                {
                    //判断姓名首位是否位小写字母
                    NSString * regex = @"^[a-z]$";
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
                    BOOL isMatch = [pred evaluateWithObject:string];
                    if (isMatch == YES)
                    {
                        //NSLog(@"这是小写字母");
                        
                        //把大写字母转换成小写字母
                        char j = i+32;
                        //数据封装成NSNumber类型
                        NSNumber *num = [NSNumber numberWithChar:j];
                        //给a开空间，并且强转成char类型
                        char *a = (char *)malloc(2);
                        //将num里面的数据取出放进a里面
                        sprintf(a, "%c", [num charValue]);
                        //把c的字符串转换成oc字符串类型
                        NSString *str = [[NSString alloc]initWithUTF8String:a];
                        if ([string isEqualToString:str])
                        {
                            NSMutableArray *array = [[NSMutableArray alloc] init];
                            [array addObject:model.name];
                            if (model.tel != nil)
                            {
                                [array addObject:model.tel];
                            }
                            
                            [numarr addObject:array];
                            [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                        }
                       
                    }
                    else
                    {
                        //判断姓名首位是否为大写字母
                        NSString * regexA = @"^[A-Z]$";
                        NSPredicate *predA = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexA];
                        BOOL isMatchA = [predA evaluateWithObject:string];
                        if (isMatchA == YES)
                        {
                            //NSLog(@"这是大写字母");
                            //
                            NSNumber *num = [NSNumber numberWithChar:i];
                            //给a开空间，并且强转成char类型
                            char *a = (char *)malloc(2);
                            //将num里面的数据取出放进a里面
                            sprintf(a, "%c", [num charValue]);
                            //把c的字符串转换成oc字符串类型
                            NSString *str = [[NSString alloc]initWithUTF8String:a];
                            if ([string isEqualToString:str])
                            {
                                NSMutableArray *array = [[NSMutableArray alloc] init];
                                [array addObject:model.name];
                                if (model.tel != nil)
                                {
                                    [array addObject:model.tel];
                                }
                                
                                [numarr addObject:array];
                                [dic setObject:numarr forKey:[NSNumber numberWithChar:i]];
                            }
                        }
                    }
                }
            }
        }
        if (dic.count != 0)
        {
            [userSource addObject:dic];
        }
    }
    
    char n = '#';
    int cont = 0;
    for (int j=0; j<dataSource.count; j++)
    {
        Model *model = [dataSource objectAtIndex:j];
        //获取姓名的首位
        NSString *string = [model.name substringWithRange:NSMakeRange(0, 1)];
        //将姓名首位转化成NSData类型
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        //判断data的长度是否小于3
        if (data.length < 3)
        {
            if (cont == 0)
            {
                dic1 = [[NSMutableDictionary alloc] init];
                numarr1 = [[NSMutableArray alloc] init];
                cont++;
            }
            if (data.length == 1)
            {
                //判断首位是否为数字
                NSString * regexs = @"^[0-9]$";
                NSPredicate *preds = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexs];
                BOOL isMatch = [preds evaluateWithObject:string];
                if (isMatch == YES)
                {
                    //如果姓名为数字
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    [array addObject:model.name];
                    if (model.tel != nil)
                    {
                        [array addObject:model.tel];
                    }
                    
                    [numarr1 addObject:array];
                    [dic1 setObject:numarr1 forKey:[NSNumber numberWithChar:n]];
                }
            }
            else
            {
                //如果姓名为空
                NSMutableArray *array = [[NSMutableArray alloc] init];
                model.name = @"无";
                [array addObject:model.name];
                if (model.tel != nil)
                {
                    [array addObject:model.tel];
                    [numarr1 addObject:array];
                    [dic1 setObject:numarr1 forKey:[NSNumber numberWithChar:n]];
                }
            }
        }
    }
    
    if (dic1.count != 0)
    {
        [userSource addObject:dic1];
    }
}
#pragma mark - 获取通讯录里联系人姓名和手机号
- (void)address
{
    dataSource = [[NSMutableArray alloc] init];
    
    //    NSMutableArray *contactsdata= [[NSMutableArray alloc] init];
    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    //判断是否在ios6.0版本以上
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0){
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        //获取通讯录权限
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        CFErrorRef* error=nil;
        addressBooks = ABAddressBookCreateWithOptions(NULL, error);
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        Model *addressBook = [[Model alloc] init];
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
        }else {
            if ((__bridge id)abLastName != nil){
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
//        addressBook.recordID = (int)ABRecordGetRecordID(person);
        
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
                        addressBook.tel = (__bridge NSString*)value;
                        NSLog(@"%@",addressBook.tel);
                        break;
                    }
                        //                    case 1: {// Email
                        //                        addressBook.email = (__bridge NSString*)value;
                        //                        break;
                        //                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [dataSource addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}
#pragma mark - 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //便立构造器
    for (NSDictionary *dic in userSource)
    {
       
        //将取出来的数据封装成NSNumber类型
        NSNumber *num = [[dic allKeys] lastObject];
        //给a开空间，并且强转成char类型
        char *a = (char *)malloc(2);
        //将num里面的数据取出放进a里面
        sprintf(a, "%c", [num charValue]);
        //把c的字符串转换成oc字符串类型
        NSString *str = [[NSString alloc]initWithUTF8String:a];
        [array addObject:str];
    }
    /*
    for (char i='A'; i<'Z'; i++)
    {
        //将取出来的数据封装成NSNumber类型
        NSNumber *num = [NSNumber numberWithChar:i];
        //给a开空间，并且强转成char类型
        char *a = (char *)malloc(2);
        //将num里面的数据取出放进a里面
        sprintf(a, "%c", [num charValue]);
        //把c的字符串转换成oc字符串类型
        NSString *str = [[NSString alloc]initWithUTF8String:a];
        [array addObject:str];
    }
     */
    return array;
}
#pragma mark - 设置section的行数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return userSource.count;
}
#pragma mark - 设置section的头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - 设置section显示的内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = [userSource objectAtIndex:section];
    NSNumber *num = [[dic allKeys] lastObject];
    char *a = (char *)malloc(2);
    sprintf(a, "%c", [num charValue]);
    NSString *str = [[NSString alloc] initWithUTF8String:a];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 320, 100);
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    return btn;
}
#pragma mark - 设置每个section里的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = [userSource objectAtIndex:section];
    NSArray *array = [[dic allValues] firstObject];
    return array.count;
}
#pragma mark - 显示每行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dic = [userSource objectAtIndex:indexPath.section];
    NSArray *arr = [[dic allValues] lastObject];
    NSArray *array = [arr objectAtIndex:indexPath.row];
    NSString *name = nil;
    NSString *tel = nil;
    if (array.count != 1)
    {
        if ([[array objectAtIndex:0] isEqualToString:@"无"]) {
            tel = [array objectAtIndex:1];
        }
        else
        {
            name = [array objectAtIndex:0];
            tel = [array objectAtIndex:1];
        }
    }
    else
    {
        name = [array lastObject];
    }
   
    cell.numlab.text = name;
    cell.tellab.text = tel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

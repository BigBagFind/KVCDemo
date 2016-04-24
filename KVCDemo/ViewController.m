//
//  ViewController.m
//  KVCDemo
//
//  Created by 吴玉铁 on 16/4/24.
//  Copyright © 2016年 吴玉铁. All rights reserved.
//

#import <objc/runtime.h>
#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDelegate>{
    NSNumber *_age;
}


@property (nonatomic,strong) Person *person;
@property (nonatomic,copy) NSString *name;

@end

@implementation ViewController

- (Person *)person{
    if (!_person) {
        _person = [[Person alloc]init];
    }
    return _person;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // calling the accessor method
//    [self setName:@"Savings"];
//
//    NSLog(@"%@",self.name);
    // using setValue:forKey:
    //[self setValue:@"Savings" forKey:@"name"];
    
//    [self setValue:@"Savings" forKeyPath:@"name"];
//    NSLog(@"%@",self.name);
    // using a key path, where account is a kvc-compliant property
    // of "document"
    //[document setValue:@"Savings" forKeyPath:@"account.name"]
   
    NSLog(@"name:%@",self.person.name);
    NSLog(@"balance:%@",self.person.money.balance);
    
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [self.person setValue:@"TGG" forKey:@"name"];
    [self.person setValue:@"Tgg" forKey:@"name"];
    
    [self.person addObserver:self forKeyPath:@"money.balance" options:NSKeyValueObservingOptionNew context:nil];
    [self.person setValue:[NSNumber numberWithInt:100] forKeyPath:@"money.balance"];
    [self.person setValue:[NSNumber numberWithInt:1000] forKeyPath:@"money.balance"];
    [self.person setValue:[NSNumber numberWithInt:10000] forKeyPath:@"money.balance"];
    
    // runtime
    // propertyList
    unsigned int count;
    objc_property_t *properyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(properyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    // method
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    // Ivar 常量 Ivar
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    //获取协议列表 Protocol * __unsafe_unretained
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"name"]){//这里只处理balance属性
        NSLog(@"keyPath=%@,object=%@,newValue=%@,change=%@",keyPath,object,[change objectForKey:@"new"],change);
    }
    if([keyPath isEqualToString:@"money.balance"]){//这里只处理balance属性
        NSLog(@"keyPath=%@,object=%@,newValue=%@,change=%@",keyPath,object,[change objectForKey:@"new"],change);
    }
}


#pragma  mark-log
- (void)runtimeLogMethod{
    NSLog(@"runtimeLogMethoding...\n");
}


#pragma mark 重写销毁方法
-(void)dealloc{
    
    [self.person removeObserver:self forKeyPath:@"name"];//移除监听
    [self.person removeObserver:self forKeyPath:@"money.balance"];
    
}

@end

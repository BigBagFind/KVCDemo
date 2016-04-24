//
//  Person.m
//  KVCDemo
//
//  Created by 吴玉铁 on 16/4/24.
//  Copyright © 2016年 吴玉铁. All rights reserved.
//

#import "Person.h"

@implementation Person


- (Money *)money{
    if (!_money) {
        _money = [[Money alloc]init];
    }
    return _money;
}


@end

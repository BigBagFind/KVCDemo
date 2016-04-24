//
//  Person.h
//  KVCDemo
//
//  Created by 吴玉铁 on 16/4/24.
//  Copyright © 2016年 吴玉铁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Money.h"

@interface Person : NSObject

@property (nonatomic,strong) Money *money;
@property (nonatomic,copy) Money *name;


@end

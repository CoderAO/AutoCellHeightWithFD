//
//  AOMessage.m
//  QQChat
//
//  Created by 敖然 on 15/6/5.
//  Copyright (c) 2015年 AT. All rights reserved.
//

#import "AOMessage.h"

@implementation AOMessage

+ (instancetype)messageWithDic:(NSDictionary *)dic {
    AOMessage *model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end

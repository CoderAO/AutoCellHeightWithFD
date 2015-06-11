//
//  AOMessage.h
//  QQChat
//
//  Created by 敖然 on 15/6/5.
//  Copyright (c) 2015年 AT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AOMessageTypeMe,
    AOMessageTypeOther
} AOMessageType;

@interface AOMessage : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) AOMessageType type;

/**
 *  是否要隐藏时间
 */
@property (nonatomic, assign, getter=isTimeHidden) BOOL timeHidden;

+ (instancetype)messageWithDic:(NSDictionary *)dic;

@end

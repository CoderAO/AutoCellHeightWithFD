//
//  AOMessageCell.h
//  QQChat
//
//  Created by 敖然 on 15/6/5.
//  Copyright (c) 2015年 AT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AOMessage;

@interface AOMessageCell : UITableViewCell

/**
 *  数据模型
 */
@property (nonatomic, strong) AOMessage *model;

@end

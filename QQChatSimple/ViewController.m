//
//  ViewController.m
//  QQChatSimple
//
//  Created by 敖然 on 15/6/6.
//  Copyright (c) 2015年 AT. All rights reserved.
//

#import "ViewController.h"
#import "AOMessage.h"
#import "AOMessageCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.inputField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.inputField.leftViewMode = UITextFieldViewModeAlways;

    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    self.tableView.fd_debugLogEnabled = YES;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages" ofType:@"plist"];
        NSArray *originArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mArry = [NSMutableArray array];
        AOMessage *lastModel = nil;
        for (NSDictionary *dic in originArray) {
            AOMessage *model = [AOMessage messageWithDic:dic];
            if ([model.time isEqualToString:lastModel.time]) {
                model.timeHidden = YES;
            }
            else {
                model.timeHidden = NO;
            }
            [mArry addObject:model];
            lastModel = model;
        }
        _dataList = mArry;
        [_dataList addObjectsFromArray:mArry];
    }
    return _dataList;
}

#pragma mark - keyboard

- (void)UIKeyboardWillChangeFrame:(NSNotification *)note {
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animationDuration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - keyboardFrame.origin.y;

    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];

    } completion:^(BOOL finished) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataList.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AOMessage *message = self.dataList[indexPath.row];
    NSString *ID = nil;
    if (message.type == AOMessageTypeMe) {
        ID = @"me";
    }
    else {
        ID = @"other";
    }

//    return [tableView fd_heightForCellWithIdentifier:ID configuration:^(id cell) {
//        AOMessageCell *aoCell = cell;
//        aoCell.model = self.dataList[indexPath.row];
//    }];

    return [tableView fd_heightForCellWithIdentifier:ID cacheByIndexPath:indexPath configuration:^(AOMessageCell *cell) {
        cell.model = self.dataList[indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AOMessage *model = self.dataList[indexPath.row];
    NSString *ID = model.type == AOMessageTypeMe ? @"me" : @"other";
    AOMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

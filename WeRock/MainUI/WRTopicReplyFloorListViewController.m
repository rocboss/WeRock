//
//  WRTopicReplyFloorListViewController.m
//  WeRock
//
//  Created by ZYVincent on 15/5/4.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicReplyFloorListViewController.h"
#import "WRTopicReplyFloorCell.h"
#import "WRTopicReplyCell.h"
#import "WRTopicManager.h"

@interface WRTopicReplyFloorListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *sourceArray;

@property (nonatomic,strong)UITableView *floorListTable;

@property (nonatomic,strong)WRTopicManager *topicManager;

@end

@implementation WRTopicReplyFloorListViewController

- (instancetype)initWithReply:(WRTopicReplyFloorContentModel *)reply
{
    if(self = [super init]){
        
        self.sourceArray = [[NSMutableArray alloc]init];
        [self.sourceArray addObject:reply];
        self.topicManager = [[WRTopicManager alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setStrNavTitle:@"回复详情"];

    /* 对话列表 */
    self.floorListTable = [[UITableView alloc]init];
    self.floorListTable.dataSource = self;
    self.floorListTable.delegate = self;
    self.floorListTable.backgroundColor = [WRGuideStyle mainBackgroundColor];
    self.floorListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.floorListTable.frame = (CGRect){0,0,GJCFSystemScreenWidth,GJCFSystemScreenHeight  - 44 - 20};
    [self.view addSubview:self.floorListTable];
    
    [self requestFloorList];
}

#pragma mark - tableView Delegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        static NSString *DetailCellIdentifier = @"DetailCellIdentifier";
        
        WRTopicReplyCell *detailCell = (WRTopicReplyCell *)[tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
        
        if (!detailCell) {
            detailCell = [[WRTopicReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellIdentifier];
        }
        [detailCell setReply:[self.sourceArray objectAtIndex:indexPath.row]];
        
        return detailCell;
        
    }else{
        
        static NSString *ReplyCellIdentifier = @"ReplyCellIdentifier";
        
        WRTopicReplyFloorCell *replyCell = (WRTopicReplyFloorCell *)[tableView dequeueReusableCellWithIdentifier:ReplyCellIdentifier];
        
        if (!replyCell) {
            replyCell = [[WRTopicReplyFloorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReplyCellIdentifier];
        }
        [replyCell setFloor:[self.sourceArray objectAtIndex:indexPath.row]];
        
        return replyCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        WRTopicReplyContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
        
        return contentModel.contentHeight;
        
    }else{
        
        WRTopicReplyFloorContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
        
        return contentModel.contentHeight;
    }
}

- (void)requestFloorList
{
    WRTopicReplyContentModel *contentModel = [self.sourceArray firstObject];
    WRTopicReplyModel *reply = [[WRTopicReplyModel alloc]init];
    reply.pid = contentModel.pid;
    
    WRConditionModel *condition = [[WRConditionModel alloc]init];
    
    GJCFWeakSelf weakSelf = self;
    [self.topicManager getTopicReplyFloorList:reply withCondition:condition withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
       
        GJCFAsyncMainQueue(^{
            
            [weakSelf detailWithFloorList:resultModelArray];

        });
        
    }];
}

- (void)detailWithFloorList:(NSArray *)resultList
{
    for (NSDictionary *item in resultList) {
        
        NSAttributedString *content = [self floorAttrisWithFloor:item];
        
        WRTopicReplyFloorContentModel *floorModel = [[WRTopicReplyFloorContentModel alloc]init];
        floorModel.contentString = content;
        floorModel.userId = item[@"floorUser"];
        
        [self.sourceArray addObject:floorModel];
    }
    
    [self.floorListTable reloadData];
}

- (NSAttributedString *)floorAttrisWithFloor:(NSDictionary *)floorDict
{
    GJCFCoreTextAttributedStringStyle *stringStyle = [[GJCFCoreTextAttributedStringStyle alloc]init];
    stringStyle.font = [WRGuideStyle topicListSummaryFont];
    stringStyle.foregroundColor = [WRGuideStyle topicListSummaryColor];
    
    GJCFCoreTextParagraphStyle *paragraphStyle = [[GJCFCoreTextParagraphStyle alloc]init];
    paragraphStyle.maxLineSpace = 5.f;
    paragraphStyle.minLineSpace = 5.f;
    
    NSMutableString *floorString = [NSMutableString string];
    [floorString appendFormat:@"%@ : %@     %@",floorDict[@"floorUser"],floorDict[@"floorContent"],floorDict[@"floorTime"]];
    
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]initWithString:floorString attributes:[stringStyle attributedDictionary]];
    
    GJCFCoreTextKeywordAttributedStringStyle *keywordStyle = [[GJCFCoreTextKeywordAttributedStringStyle alloc]init];
    keywordStyle.keyword = floorDict[@"floorUser"];
    keywordStyle.keywordColor = [UIColor blueColor];
    keywordStyle.font = [UIFont systemFontOfSize:14];
    [resultString setKeywordEffectByStyle:keywordStyle];
    
    GJCFCoreTextKeywordAttributedStringStyle *timeKeyStyle = [[GJCFCoreTextKeywordAttributedStringStyle alloc]init];
    timeKeyStyle.keyword = floorDict[@"floorTime"];
    timeKeyStyle.keywordColor = [WRGuideStyle topicListTimeColor];
    timeKeyStyle.font = [UIFont systemFontOfSize:12];
    [resultString setKeywordEffectByStyle:timeKeyStyle];
    
    [resultString addAttributes:[paragraphStyle paragraphAttributedDictionary] range:GJCFStringRange(floorString)];
    
    return resultString;
}

@end

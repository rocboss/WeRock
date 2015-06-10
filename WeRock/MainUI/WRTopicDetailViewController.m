//
//  WRTopicDetailViewController.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicDetailViewController.h"
#import "WRTopicDetailCell.h"
#import "WRTopicReplyCell.h"
#import "WRTopicReplyFloorListViewController.h"
#import "WRTopicManager.h"

@interface WRTopicDetailViewController ()<UITableViewDataSource,UITableViewDelegate,WRTopicDetailCellDelegate,WRTopicReplyCellDelegate>

@property (nonatomic,strong)NSMutableArray *sourceArray;

@property (nonatomic,strong)WRTopicManager *topicManager;

@property (nonatomic,strong)WRTopicContentModel *contentModel;

@property (nonatomic,strong)UITableView *detailTable;

@end

@implementation WRTopicDetailViewController

- (instancetype)initWithTopic:(WRTopicContentModel *)topic
{
    if (self = [super init]) {
    
        self.contentModel = topic;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topicManager = [[WRTopicManager alloc]init];
    
    [self setStrNavTitle:@"帖子详情"];
    
    self.sourceArray = [[NSMutableArray alloc]init];
    
    /* 对话列表 */
    self.detailTable = [[UITableView alloc]init];
    self.detailTable.dataSource = self;
    self.detailTable.delegate = self;
    self.detailTable.backgroundColor = [WRGuideStyle mainBackgroundColor];
    self.detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.detailTable.frame = (CGRect){0,0,GJCFSystemScreenWidth,GJCFSystemScreenHeight  - 44 - 20};
    [self.view addSubview:self.detailTable];
    
    [self requestTopicDetail];
    [self requestTopicReply];
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
    WRTopicBaseContentModel *baseModel = [self.sourceArray objectAtIndex:indexPath.row];
    
    if (baseModel.contentType == WRTopicContentTypeTopic) {
        
        static NSString *DetailCellIdentifier = @"DetailCellIdentifier";

        WRTopicDetailCell *detailCell = (WRTopicDetailCell *)[tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
        
        if (!detailCell) {
            detailCell = [[WRTopicDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DetailCellIdentifier];
            detailCell.delegate = self;
        }
        [detailCell setTopicContent:[self.sourceArray objectAtIndex:indexPath.row]];
        
        return detailCell;
        
    }else{
        
        static NSString *ReplyCellIdentifier = @"ReplyCellIdentifier";
        
        WRTopicReplyCell *replyCell = (WRTopicReplyCell *)[tableView dequeueReusableCellWithIdentifier:ReplyCellIdentifier];
        
        if (!replyCell) {
            replyCell = [[WRTopicReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReplyCellIdentifier];
            replyCell.delegate = self;
        }
        [replyCell setReply:[self.sourceArray objectAtIndex:indexPath.row]];
        
        return replyCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        WRTopicContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
        
        return contentModel.contentHeight;
        
    }else{
        
        WRTopicReplyContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
        
        return contentModel.contentHeight;
    }
}

- (void)topicReplyCellNeedCheckMoreFloor:(WRTopicReplyCell *)replyCell
{
    NSIndexPath *indexPath = [self.detailTable indexPathForCell:replyCell];
    
    WRTopicReplyContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
    
    WRTopicReplyFloorListViewController *floorListVC = [[WRTopicReplyFloorListViewController alloc]initWithReply:contentModel];
    [[WRStackManager shareManager]pushViewController:floorListVC animated:YES];
}

- (void)topicDetailCellNeedUpdateContentHeight:(WRTopicDetailCell *)cell withNewContentHeight:(CGFloat)height
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    WRTopicContentModel *contentModel = [self.sourceArray firstObject];
    contentModel.contentHeight = height;
    
    [self.sourceArray replaceObjectAtIndex:0 withObject:contentModel];
    [self.detailTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)topicReplyCell:(WRTopicReplyCell *)replyCell needUpdateContentHeight:(CGFloat)contentHeight
{
    NSIndexPath *indexPath = [self.detailTable indexPathForCell:replyCell];

    WRTopicReplyContentModel *contentModel = [self.sourceArray objectAtIndex:indexPath.row];
    contentModel.contentHeight = contentHeight;
    

}

- (void)requestTopicDetail
{
    WRTopicModel *topic = [[WRTopicModel alloc]init];
    topic.tid = self.contentModel.tid;
    
    GJCFWeakSelf weakSelf = self;
    [self.topicManager getTopicDetail:topic withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
       
        if (status) {
            
            GJCFAsyncMainQueue(^{
                
                [weakSelf detailWithTopic:[resultModelArray objectAtIndex:0]];

            });
        }
        
    }];
}

- (void)detailWithTopic:(WRTopicModel *)topic
{
    WRTopicContentModel *contentModel = [[WRTopicContentModel alloc]init];
    contentModel.titleString = [WRTopicStyle formateTitle:topic.title];
    contentModel.timeString = [WRTopicStyle formateTime:topic.postTime];
    contentModel.summaryString = [WRTopicStyle formateContent:topic.content];
    contentModel.picArray = topic.pictures;
    contentModel.headUrl = topic.avatar;
    contentModel.tid = topic.tid;
    contentModel.nameString = [WRTopicStyle formateNameString:topic.userName];
    contentModel.replyCountString = [WRTopicStyle formateReplyCount:topic.comments];
    WRTopicDetailCell *topicCell = [[WRTopicDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [topicCell setTopicContent:contentModel];
    contentModel.contentHeight = [topicCell contentHeight];

    [self.sourceArray insertObject:contentModel atIndex:0];
    [self.detailTable reloadData];
}


- (void)requestTopicReply
{
    WRTopicModel *topic = [[WRTopicModel alloc]init];
    topic.tid = self.contentModel.tid;
    
    WRConditionModel *condition = [[WRConditionModel alloc]init];
    
    GJCFWeakSelf weakSelf = self;
    [self.topicManager getTopicReplyList:topic withCondition:condition withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
        
        GJCFAsyncMainQueue(^{
            
            [weakSelf detailWithReplyList:resultModelArray];

        });
        
    }];
}

- (void)detailWithReplyList:(NSArray *)replyList
{
    for (NSDictionary *item in replyList) {
        
        WRTopicReplyContentModel *replyModel = [[WRTopicReplyContentModel alloc]init];
        replyModel.userName = [WRTopicStyle formateNameString:item[@"username"]];
        replyModel.avatar = [WRHttpUitil serverPicUrl:item[@"avatar"]];
        replyModel.timeString = [WRTopicStyle formateTime:item[@"posttime"]];
        replyModel.content = [WRTopicStyle formateContent:item[@"content"]];
        replyModel.floors = item[@"floor"];
        replyModel.pid = item[@"pid"];
        
        NSMutableArray *combinePicUrls = [NSMutableArray array];
        for (NSString *url in [item objectForKey:@"pictures"]) {
            
            NSString *combineUrl = url;
            if ([url hasPrefix:WRServerSubPath]) {
                combineUrl  = [NSString stringWithFormat:@"http://www.lulingshuo.com%@",url];
            }else{
                combineUrl =  [NSString stringWithFormat:@"%@%@",WRServerHost,url];
            }
            [combinePicUrls addObject:combineUrl];
        }
        replyModel.pictures = combinePicUrls;
        
        WRTopicReplyCell *replyCell = [[WRTopicReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [replyCell setReply:replyModel];
        replyModel.contentHeight = [replyCell contentHeight];
        
        [self.sourceArray addObject:replyModel];
    }
    
    [self.detailTable reloadData];
}

@end

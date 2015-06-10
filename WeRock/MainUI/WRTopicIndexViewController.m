//
//  WRTopicIndexViewController.m
//  WeRock
//
//  Created by ZYVincent on 15/4/30.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicIndexViewController.h"
#import "WRTagIndexViewController.h"
#import "WRTopicCell.h"
#import "WRTopicManager.h"
#import "WRTopicStyle.h"
#import "WRTopicDetailViewController.h"

@interface WRTopicIndexViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *topicTable;

@property (nonatomic,strong)NSMutableArray *topicSourceArray;

@property (nonatomic,strong)WRTopicManager *topicManager;

@end

@implementation WRTopicIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStrNavTitle:@"帖子"];
    
    self.topicSourceArray = [[NSMutableArray alloc]init];
    self.topicManager = [[WRTopicManager alloc]init];
    
    /* 对话列表 */
    self.topicTable = [[UITableView alloc]init];
    self.topicTable.dataSource = self;
    self.topicTable.delegate = self;
    self.topicTable.backgroundColor = [WRGuideStyle mainBackgroundColor];
    self.topicTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topicTable.frame = (CGRect){0,0,GJCFSystemScreenWidth,GJCFSystemScreenHeight  - 44 - 20};
    [self.view addSubview:self.topicTable];
 
    [self performSelector:@selector(requestTopic) withObject:nil afterDelay:2];
}

#pragma mark - tableView Delegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    WRTopicCell *baseCell = (WRTopicCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!baseCell) {
        
        baseCell = [[WRTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    WRTopicContentModel *contentModel = [self.topicSourceArray objectAtIndex:indexPath.row];

    [baseCell setcontentModel:contentModel];
    
    [baseCell downloadImage:contentModel.picArray];
    
    return baseCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRTopicContentModel *contentModel = [self.topicSourceArray objectAtIndex:indexPath.row];
    
    return contentModel.contentHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRTopicDetailViewController *detailVC = [[WRTopicDetailViewController alloc]initWithTopic:[self.topicSourceArray objectAtIndex:indexPath.row]];
    [[WRStackManager shareManager]pushViewController:detailVC animated:YES];
}

#pragma mark - 网络取数据

- (void)requestTopic
{
    WRConditionModel *condtion = [[WRConditionModel alloc]init];
    condtion.topicSortType = @"lasttime";
    
    GJCFWeakSelf weakSelf = self;
    [self.topicManager getHomeTopic:condtion withResult:^(BOOL status, NSArray *resultModelArray, NSString *msg) {
       
        if (status) {
            
            GJCFAsyncMainQueue(^{
                
                [weakSelf addNewTopics:resultModelArray];

            });
        }
        
    }];
}

- (void)addNewTopics:(NSArray *)topics
{
    for (WRTopicModel *topic in topics) {
        
        WRTopicContentModel *contentModel = [[WRTopicContentModel alloc]init];
        contentModel.titleString = [WRTopicStyle formateTitle:topic.title];
        contentModel.timeString = [WRTopicStyle formateTime:topic.postTime];
        NSString *summary = topic.content.length > 30? [NSString stringWithFormat:@"%@...",[topic.content substringToIndex:29]]:topic.content;
        contentModel.summaryString = [WRTopicStyle formateSummary:summary];
        contentModel.picArray = topic.pictures;
        contentModel.headUrl = topic.avatar;
        contentModel.tid = topic.tid;
        contentModel.nameString = [WRTopicStyle formateNameString:topic.userName];
        contentModel.replyCountString = [WRTopicStyle formateReplyCount:topic.comments];
        WRTopicCell *topicCell = [[WRTopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [topicCell setcontentModel:contentModel];
        contentModel.contentHeight = [topicCell contentHeight];
        
        [self.topicSourceArray addObject:contentModel];
    }
    
    [self.topicTable reloadData];
}

@end

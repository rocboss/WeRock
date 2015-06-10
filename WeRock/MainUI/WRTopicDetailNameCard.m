//
//  WRTopicDetailNameCard.m
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicDetailNameCard.h"

@interface WRTopicDetailNameCard()

@property (nonatomic,strong)WRHeadView *headView;

@property (nonatomic,strong)GJCFCoreTextContentView *nameLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *lastTimeActiveLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *groupRoleLabel;

@property (nonatomic,assign)CGFloat headContentMargin;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@property (nonatomic,assign)CGFloat headViewWidth;

@end

@implementation WRTopicDetailNameCard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.headContentMargin = 8.f;
        self.headViewWidth = 30.f;
        self.gjcf_width = frame.size.width;
        self.gjcf_height = self.headViewWidth;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    CGFloat nameMaxWidth = self.gjcf_width - self.headViewWidth - self.headContentMargin;

    self.headView = [[WRHeadView alloc]init];
    self.headView.gjcf_size = CGSizeMake(self.headViewWidth, self.headViewWidth);
    [self addSubview:self.headView];
    
    self.nameLabel = [[GJCFCoreTextContentView alloc]init];
    self.nameLabel.contentBaseWidth = nameMaxWidth;
    self.nameLabel.contentBaseHeight = 10.f;
    [self addSubview:self.nameLabel];
    
    self.lastTimeActiveLabel = [[GJCFCoreTextContentView alloc]init];
    self.lastTimeActiveLabel.contentBaseSize = self.nameLabel.contentBaseSize;
    [self addSubview:self.lastTimeActiveLabel];
    
    self.groupRoleLabel = [[GJCFCoreTextContentView alloc]init];
    self.groupRoleLabel.contentBaseSize = CGSizeMake(40, 10);
    [self addSubview:self.groupRoleLabel];
}

- (void)setTopicContent:(WRTopicContentModel *)topic
{
    [self.headView setHeadUrl:topic.headUrl];
    
    CGSize nameSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.nameString forBaseContentSize:self.nameLabel.contentBaseSize];
    self.nameLabel.gjcf_size = nameSize;
    self.nameLabel.gjcf_left = self.headView.gjcf_right + self.headContentMargin;
    self.nameLabel.gjcf_top = self.headView.gjcf_top;
    self.nameLabel.contentAttributedString = topic.nameString;
    
    CGSize lastTimeString = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.timeString forBaseContentSize:self.lastTimeActiveLabel.contentBaseSize];
    self.lastTimeActiveLabel.gjcf_size = lastTimeString;
    self.lastTimeActiveLabel.gjcf_left = self.nameLabel.gjcf_left;
    self.lastTimeActiveLabel.gjcf_top = self.nameLabel.gjcf_bottom + 5.f;
    self.lastTimeActiveLabel.contentAttributedString = topic.timeString;
}

- (void)setReplyContent:(WRTopicReplyContentModel *)reply
{
    [self.headView setHeadUrl:reply.avatar];
    
    CGSize nameSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:reply.userName forBaseContentSize:self.nameLabel.contentBaseSize];
    self.nameLabel.gjcf_size = nameSize;
    self.nameLabel.gjcf_left = self.headView.gjcf_right + self.headContentMargin;
    self.nameLabel.gjcf_top = self.headView.gjcf_top;
    self.nameLabel.contentAttributedString = reply.userName;
    
    CGSize lastTimeString = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:reply.timeString forBaseContentSize:self.lastTimeActiveLabel.contentBaseSize];
    self.lastTimeActiveLabel.gjcf_size = lastTimeString;
    self.lastTimeActiveLabel.gjcf_left = self.nameLabel.gjcf_left;
    self.lastTimeActiveLabel.gjcf_top = self.nameLabel.gjcf_bottom + 5.f;
    self.lastTimeActiveLabel.contentAttributedString = reply.timeString;
}

@end

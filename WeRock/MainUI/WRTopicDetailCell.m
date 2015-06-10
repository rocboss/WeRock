//
//  WRTopicDetailCell.m
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicDetailCell.h"
#import "WRTopicDetailNameCard.h"

#define WRTopicDetailCellBaseImageViewTag 987911

@interface WRTopicDetailCell ()

@property (nonatomic,strong)UIImageView *backgroundImageView;

@property (nonatomic,strong)WRTopicDetailNameCard *nameCard;

@property (nonatomic,strong)GJCFCoreTextContentView *titleLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *contentLabel;

@property (nonatomic,strong)GJCFCoreTextContentView *commentCountLabel;

@property (nonatomic,strong)UIImageView *isTopTagView;

@property (nonatomic,assign)CGFloat cellBoardMargin;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@property (nonatomic,assign)CGFloat headContentMargin;

@property (nonatomic,assign)CGFloat headViewWidth;

@property (nonatomic,strong)WRTopicContentModel *theTopic;

@end

@implementation WRTopicDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentInnerMargin = 13.f;
        self.headViewWidth = 35.f;
        self.headContentMargin = 8.f;
        
        CGFloat contentMaxWidth = GJCFSystemScreenWidth - self.headContentMargin - self.headViewWidth - 2*self.cellBoardMargin;
        
        self.backgroundImageView = [[UIImageView alloc]init];
        self.backgroundImageView.gjcf_width = GJCFSystemScreenWidth;
        self.backgroundImageView.userInteractionEnabled = YES;
        UIImage *normalBack = [UIImage imageNamed:@"cell_n"];
        CGFloat width = normalBack.size.width;
        CGFloat height = normalBack.size.height;
        self.backgroundImageView.image = GJCFImageResize(normalBack,height/2-1, height/2+1, width/2-1, width/2+1);
        [self.contentView addSubview:self.backgroundImageView];
        
        self.nameCard = [[WRTopicDetailNameCard alloc]initWithFrame:CGRectMake(0, 0,contentMaxWidth, self.headViewWidth)];
        self.nameCard.gjcf_left = self.contentInnerMargin;
        [self.backgroundImageView addSubview:self.nameCard];
        
        self.titleLabel = [[GJCFCoreTextContentView alloc]init];
        self.titleLabel.contentBaseSize = CGSizeMake(contentMaxWidth, 20);
        self.titleLabel.gjcf_top = self.headContentMargin;
        [self.backgroundImageView addSubview:self.titleLabel];
        
        self.contentLabel = [[GJCFCoreTextContentView alloc]init];
        self.contentLabel.gjcf_size = CGSizeMake(contentMaxWidth, 10);
        self.contentLabel.contentBaseSize = CGSizeMake(contentMaxWidth, 10);
        [self.backgroundImageView addSubview:self.contentLabel];

        self.isTopTagView = [[UIImageView alloc]init];
        [self.backgroundImageView addSubview:self.isTopTagView];

        
    }
    return self;
}

- (void)setTopicContent:(WRTopicContentModel *)topic
{
    self.theTopic = topic;
    
    [self.nameCard setTopicContent:topic];
    self.nameCard.gjcf_top = self.headContentMargin;
    
    CGSize titleSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.titleString forBaseContentSize:self.titleLabel.contentBaseSize];
    self.titleLabel.gjcf_size = titleSize;
    self.titleLabel.gjcf_left = self.nameCard.gjcf_left;
    self.titleLabel.gjcf_top = self.nameCard.gjcf_bottom + self.contentInnerMargin;
    self.titleLabel.contentAttributedString = topic.titleString;
    
    CGSize summarySize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:topic.summaryString forBaseContentSize:self.contentLabel.contentBaseSize];
    self.contentLabel.gjcf_size = summarySize;
    self.contentLabel.gjcf_left = self.titleLabel.gjcf_left;
    self.contentLabel.gjcf_top = self.titleLabel.gjcf_bottom + self.headContentMargin;
    self.contentLabel.contentAttributedString = topic.summaryString;
    
    CGFloat contentImageBottom = self.contentLabel.gjcf_bottom + self.headContentMargin;
    
    CGFloat imageWidth = GJCFSystemScreenWidth - 2*self.contentInnerMargin;
    for (NSInteger index = 0; index < topic.picArray.count ;index ++) {
        
        GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicDetailCellBaseImageViewTag + index];
        
        if (!imageView) {
            imageView = [[GJCUAsyncImageView alloc]init];
            imageView.gjcf_size = CGSizeMake(imageWidth,imageWidth);
            imageView.tag = WRTopicDetailCellBaseImageViewTag + index;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.backgroundImageView addSubview:imageView];
            imageView.clipsToBounds = YES;
        }
        imageView.image = [UIImage imageNamed:@"image_hold"];
        imageView.gjcf_left = self.titleLabel.gjcf_left;
        imageView.gjcf_top = contentImageBottom;
        contentImageBottom = imageView.gjcf_bottom + self.headContentMargin;
        [imageView setUrl:[topic.picArray objectAtIndex:index]];
        
    }
    
    self.backgroundImageView.gjcf_height = contentImageBottom;
}

- (void)updateContentHeightWithDownload
{
    NSInteger lastImgTag = WRTopicDetailCellBaseImageViewTag + self.theTopic.picArray.count-1;
    GJCUAsyncImageView *nextImgView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:lastImgTag];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicDetailCellNeedUpdateContentHeight:withNewContentHeight:)]) {
        [self.delegate topicDetailCellNeedUpdateContentHeight:self withNewContentHeight:nextImgView.gjcf_bottom + self.headContentMargin];
    }
}

- (CGFloat)contentHeight
{
    return self.backgroundImageView.gjcf_bottom;
}

@end

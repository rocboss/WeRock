//
//  WRTopicReplyCell.m
//  WeRock
//
//  Created by ZYVincent on 15/5/3.
//  Copyright (c) 2015年 ZYProSoft. All rights reserved.
//

#import "WRTopicReplyCell.h"
#import "WRTopicDetailNameCard.h"

#define WRTopicReplyCellFloorBaseTag 8887650

#define WRTopicReplyCellPictureTag 887890

@interface WRTopicReplyCell ()

@property (nonatomic,strong)UIImageView *backgroundImageView;

@property (nonatomic,strong)WRTopicDetailNameCard *nameCard;

@property (nonatomic,strong)GJCFCoreTextContentView *contentLabel;

@property (nonatomic,strong)UIView *floorContentView;

@property (nonatomic,strong)UIButton *actionButton;

@property (nonatomic,strong)UIImageView *floorSeprateLine;

@property (nonatomic,assign)CGFloat contentInnerMargin;

@property (nonatomic,assign)CGFloat headContentMargin;

@property (nonatomic,assign)CGFloat headViewWidth;

@property (nonatomic,assign)CGFloat cellBoardMargin;

@property (nonatomic,strong)WRTopicReplyContentModel *theReply;

@property (nonatomic,strong)UIButton *checkMoreFloorBtn;

@property (nonatomic,strong)UIImageView *bottomSeprateLine;

@end

@implementation WRTopicReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentInnerMargin = 13.f;
        self.headViewWidth = 35.f;
        self.headContentMargin = 8.f;
        
        CGFloat contentMaxWidth = GJCFSystemScreenWidth - self.headContentMargin - self.headViewWidth - 2*self.contentInnerMargin;

        self.backgroundImageView = [[UIImageView alloc]init];
        self.backgroundImageView.gjcf_width = GJCFSystemScreenWidth;
        self.backgroundImageView.backgroundColor = GJCFQuickHexColor(@"f3f3f2");
        self.backgroundImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.backgroundImageView];
        
        self.nameCard = [[WRTopicDetailNameCard alloc]initWithFrame:CGRectMake(0, 0,contentMaxWidth, self.headViewWidth)];
        self.nameCard.gjcf_left = self.contentInnerMargin;
        self.nameCard.gjcf_top = self.headContentMargin;
        [self.backgroundImageView addSubview:self.nameCard];

        self.contentLabel = [[GJCFCoreTextContentView alloc]init];
        self.contentLabel.gjcf_size = CGSizeMake(contentMaxWidth, 10);
        self.contentLabel.contentBaseSize = CGSizeMake(contentMaxWidth, 10);
        [self.backgroundImageView addSubview:self.contentLabel];
        
        self.floorContentView = [[UIView alloc]init];
        self.floorContentView.gjcf_size = CGSizeMake(contentMaxWidth, 10);
        [self.backgroundImageView addSubview:self.floorContentView];
        
        self.floorSeprateLine = [[UIImageView alloc]init];
        self.floorSeprateLine.gjcf_size = CGSizeMake(contentMaxWidth, 0.5);
        self.floorSeprateLine.backgroundColor = [UIColor grayColor];
        self.floorSeprateLine.hidden = YES;
        [self.floorContentView addSubview:self.floorSeprateLine];
        
        self.checkMoreFloorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.checkMoreFloorBtn.gjcf_size = CGSizeMake(100, 15);
        self.checkMoreFloorBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.checkMoreFloorBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.checkMoreFloorBtn setTitle:@"查看更多回复" forState:UIControlStateNormal];
        self.checkMoreFloorBtn.hidden = YES;
        [self.checkMoreFloorBtn addTarget:self action:@selector(tapOnFloorMore) forControlEvents:UIControlEventTouchUpInside];
        [self.floorContentView addSubview:self.checkMoreFloorBtn];

        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backgroundImageView addSubview:self.actionButton];
        
        self.bottomSeprateLine = [[UIImageView alloc]init];
        self.bottomSeprateLine.gjcf_height = 0.5f;
        self.bottomSeprateLine.gjcf_width = GJCFSystemScreenWidth - self.contentInnerMargin;
        self.bottomSeprateLine.gjcf_left = self.contentInnerMargin;
        self.bottomSeprateLine.backgroundColor = GJCFQuickHexColor(@"b0b0af");
        [self.backgroundImageView addSubview:self.bottomSeprateLine];
        
    }
    return self;
}

- (void)setReply:(WRTopicReplyContentModel *)contentModel
{
    self.theReply = contentModel;
    
    [self.nameCard setReplyContent:contentModel];
    
    CGFloat leftMargin = self.headViewWidth + self.contentInnerMargin + self.headContentMargin;
    
    CGSize summarySize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:contentModel.content forBaseContentSize:self.contentLabel.contentBaseSize];
    self.contentLabel.gjcf_size = summarySize;
    self.contentLabel.gjcf_left = leftMargin;
    self.contentLabel.gjcf_top = self.nameCard.gjcf_bottom + self.contentInnerMargin;
    self.contentLabel.contentAttributedString = contentModel.content;
    
    CGFloat contentImageBottom = self.contentLabel.gjcf_bottom + self.headContentMargin;
    
    if (contentModel.pictures.count > 0) {
        
        CGFloat imageWidth = GJCFSystemScreenWidth - 2*self.contentInnerMargin - leftMargin;
        
        GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicReplyCellPictureTag];
        
        if (!imageView) {
            imageView = [[GJCUAsyncImageView alloc]init];
            imageView.gjcf_size = CGSizeMake(imageWidth,imageWidth);
            imageView.tag = WRTopicReplyCellPictureTag;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.backgroundImageView addSubview:imageView];
            imageView.clipsToBounds = YES;
        }
        imageView.image = [UIImage imageNamed:@"image_hold"];
        imageView.gjcf_left = leftMargin;
        imageView.gjcf_top = contentImageBottom;
        contentImageBottom = imageView.gjcf_bottom + self.headContentMargin;
        [imageView setUrl:[contentModel.pictures firstObject]];
    }else{
        GJCUAsyncImageView *imageView = (GJCUAsyncImageView *)[self.backgroundImageView viewWithTag:WRTopicReplyCellPictureTag];
        imageView.hidden = YES;
    }
    
    CGFloat floorTop = contentImageBottom;

    self.floorContentView.gjcf_top = floorTop;
    
    if (contentModel.floors.count > 0) {
        
        self.floorSeprateLine.hidden = NO;
        
        CGFloat floorInner = 0.f + self.headContentMargin;
        
        for (NSInteger index = 0;index < contentModel.floorsAttris.count; index++) {
            
            GJCFCoreTextContentView *floorLabel = (GJCFCoreTextContentView *)[self.floorContentView viewWithTag:WRTopicReplyCellFloorBaseTag + index];
            
            if (!floorLabel) {
                floorLabel = [[GJCFCoreTextContentView alloc]init];
                floorLabel.tag = WRTopicReplyCellFloorBaseTag + index;
                floorLabel.contentBaseWidth = self.floorSeprateLine.gjcf_width;
                floorLabel.contentBaseHeight = 10.f;
                [self.floorContentView addSubview:floorLabel];
            }
            
            NSAttributedString *floorString = [contentModel.floorsAttris objectAtIndex:index];
            CGSize floorSize = [GJCFCoreTextContentView contentSuggestSizeWithAttributedString:floorString forBaseContentSize:floorLabel.contentBaseSize];
            floorLabel.gjcf_size = floorSize;
            
            floorLabel.contentAttributedString = floorString;
            floorLabel.gjcf_top = floorInner;
            floorInner = floorLabel.gjcf_bottom + self.headContentMargin;
        }
        self.floorContentView.gjcf_height = floorInner;
        self.floorContentView.gjcf_left = leftMargin;
        CGFloat floorWidth = GJCFSystemScreenWidth - 2*self.contentInnerMargin - leftMargin;
        self.floorContentView.gjcf_width = floorWidth;
        self.floorSeprateLine.gjcf_width = self.floorContentView.gjcf_width;
        
        //隐藏用不上的
        if (contentModel.floorsAttris.count < 3) {
            
            for (GJCFCoreTextContentView *floorLabel in self.floorContentView.subviews) {
                
                if ([floorLabel.class isSubclassOfClass:[GJCFCoreTextContentView class]]) {
                    
                    if (floorLabel.tag > WRTopicReplyCellFloorBaseTag+contentModel.floorsAttris.count-1) {
                        
                        floorLabel.hidden = YES;
                    }
                }
            }
            
            self.checkMoreFloorBtn.hidden = YES;
            
        }else{
            floorInner = floorInner + self.headContentMargin;
            self.checkMoreFloorBtn.gjcf_top = floorInner;
            self.checkMoreFloorBtn.hidden = NO;
            self.checkMoreFloorBtn.gjcf_right = self.floorContentView.gjcf_width;
            self.floorContentView.gjcf_height = self.checkMoreFloorBtn.gjcf_bottom + self.headContentMargin;
        }
        
    }else{
        
        self.floorContentView.hidden = YES;
    }
    
    self.backgroundImageView.gjcf_height = self.floorContentView.gjcf_bottom;
    self.bottomSeprateLine.gjcf_bottom = self.backgroundImageView.gjcf_height;
}

- (void)updateContentHeightWithDownload
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicReplyCell:needUpdateContentHeight:)]) {
        [self.delegate topicReplyCell:self needUpdateContentHeight:self.floorContentView.gjcf_bottom];
    }
}

- (void)tapOnFloorMore
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topicReplyCellNeedCheckMoreFloor:)]) {
        [self.delegate topicReplyCellNeedCheckMoreFloor:self];
    }
}

- (CGFloat)contentHeight
{
    return self.backgroundImageView.gjcf_bottom;
}

@end

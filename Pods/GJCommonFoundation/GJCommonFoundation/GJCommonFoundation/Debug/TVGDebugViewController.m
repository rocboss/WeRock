// TVGDebugViewController.m
//  TVGBaseProject
//
//  Created by ZYVincent on 14-8-20.
//
//  Copyright (c) 2014年 liyi. All rights reserved. 2014年 TVG Monkey
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TVGDebugViewController.h"
#import "TVGDebugModel.h"
#import "TVGDebugSectionInfo.h"

@interface TVGDebugViewController ()

@property (nonatomic,strong)NSMutableArray *debugSourceArray;

@end

@implementation TVGDebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.debugSourceArray = [NSMutableArray array];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        
        self.debugSourceArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"功能测试";
}

- (void)addDebugSections:(NSArray *)secitons
{
    [self.debugSourceArray addObjectsFromArray:secitons];
}


- (void)insertDebugTitle:(NSString *)title className:(NSString *)className
{
    TVGDebugModel *loggerDemo = [TVGDebugModel debugModelWithTitle:title withClassName:className];
    TVGDebugSectionInfo *loggerSectionInfo = [TVGDebugSectionInfo debugSectionInfoWithTitle:title withTestsArra:@[loggerDemo]];
    [self.debugSourceArray addObject:loggerSectionInfo];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.debugSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TVGDebugSectionInfo *sectionInfo = [self.debugSourceArray objectAtIndex:section];
    return [sectionInfo debugModelCount];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TVGDebugSectionInfo *SectionInfo = [self.debugSourceArray objectAtIndex:indexPath.section];
    TVGDebugModel *testItem = [SectionInfo debugModelAtIndex:indexPath.row];
    cell.textLabel.text = testItem.title;
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TVGDebugSectionInfo *sectionInfo = [self.debugSourceArray objectAtIndex:section];
    UILabel *sectinInfoLabel = [[UILabel alloc]initWithFrame:(CGRect){0,0,tableView.frame.size.width,40}];
    sectinInfoLabel.backgroundColor = [UIColor lightGrayColor];
    sectinInfoLabel.textColor = [UIColor whiteColor];
    sectinInfoLabel.text = sectionInfo.title;
    return sectinInfoLabel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TVGDebugSectionInfo *SectionInfo = [self.debugSourceArray objectAtIndex:indexPath.section];
    TVGDebugModel *testItem = [SectionInfo debugModelAtIndex:indexPath.row];
    
    Class selectClass = NSClassFromString(testItem.className);
    
    if (selectClass) {
        UIViewController *detailVC = [[selectClass alloc]init];
        detailVC.title = testItem.title;
        detailVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

@end

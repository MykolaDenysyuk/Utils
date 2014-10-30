//
//  TableDatasourceAndDelegate.m
//
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#define kSectionHeight 25.0f
#define kFooterHeight 4.0f
#define kRowHeight 45.0f

#import "TableDatasourceAndDelegate.h"

@interface TableDatasourceAndDelegate ()
{
    IBOutlet UITableView * _nibOutletTableView;
}
@end

@implementation TableDatasourceAndDelegate

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureForTableView:_nibOutletTableView];
}

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self) {
        [self configureForTableView:tableView];
    }
    return self;
}

- (void)configureForTableView:(UITableView *)tableView
{
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _defaultHeaderHeight = kSectionHeight;
    _defaultFooterHeight = kFooterHeight;
    _defaultRowHeight = kRowHeight;
}

- (void)setSectionTitles:(NSArray *)sectionTitles
{
    _sectionTitles = sectionTitles;
    [self.tableView reloadData];
}

- (void)setRowItems:(NSArray *)rowItems
{
    _rowItems = rowItems;
    [self.tableView reloadData];
}

#pragma mark - UITableView datasource:

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.numberOfSectionsBlock) {
        return self.numberOfSectionsBlock(tableView, 0);
    }
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.numberOfRowsBlock) {
        return self.numberOfRowsBlock(tableView, section);
    }
    return self.rowItems.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section < self.sectionTitles.count)
        return self.sectionTitles[section];
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellClass == nil) {
        self.cellClass = [UITableViewCell class];
    }
    NSString * identifier = NSStringFromClass(self.cellClass);
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self.cellClass alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:identifier];
    }
    
    if (self.configureCellBlock) {
        self.configureCellBlock(tableView, cell, indexPath, [self retrieveRowItemInTable:tableView forIndexPath:indexPath]);
    }
    return cell;
}

#pragma mark - UITableView delegate:

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.headerHeightBlock) {
        return self.headerHeightBlock(tableView, section);
    }
    return self.defaultHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.createHeaderBlock) {
        return self.createHeaderBlock(tableView, section);
    }
    
    CGFloat height  = [self tableView:tableView heightForHeaderInSection:section];
    
    UIView * holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    holderView.backgroundColor = [UIColor clearColor];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-10, height)];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:10];
    titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [holderView addSubview:titleLabel];
    
    return holderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.footerHeightBlock) {
        return self.footerHeightBlock(tableView, section);
    }
    
    return self.defaultFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.createFooterBlock) {
        return self.createFooterBlock(tableView, section);
    }
    
    CGFloat height  = [self tableView:tableView heightForFooterInSection:section];
    
    UIView * holderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, height)];
    holderView.backgroundColor = [UIColor clearColor];
    holderView.layer.masksToBounds = YES;
    UIView * shadowView = [[UIView alloc] initWithFrame:CGRectMake(-5, -1, tableView.frame.size.width + 10, 1)];
    shadowView.backgroundColor = [UIColor blackColor];
    shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 2);
    shadowView.layer.shadowOpacity = .5f;
    shadowView.layer.shadowRadius = 1.0f;
    shadowView.layer.shouldRasterize = YES;
    shadowView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [holderView addSubview:shadowView];
    
    return holderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rowHeightBlock) {
        return self.rowHeightBlock(tableView, indexPath, [self retrieveRowItemInTable:tableView forIndexPath:indexPath]);
    }
    
    return self.defaultRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowBlock) {
        self.didSelectRowBlock(tableView, [tableView cellForRowAtIndexPath:indexPath], indexPath, [self retrieveRowItemInTable:tableView forIndexPath:indexPath]);
    }
}

#pragma mark - UIScrollView:

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - Common helpers:

- (id)retrieveRowItemInTable:(UITableView* )tableView forIndexPath:(NSIndexPath *)indexPath
{
    id rowItem = self.getRowItemBlock ? self.getRowItemBlock(tableView,indexPath) : self.rowItems.count > indexPath.row ? self.rowItems[indexPath.row] : nil;
    return rowItem;
}

@end

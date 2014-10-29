//
//  TableDatasourceAndDelegate.h
//
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef CGFloat (^TableHeaderFooterHeightBlock)(UITableView*, NSInteger section);
typedef UIView* (^TableCreateHeaderFooterViewBlock)(UITableView*,NSInteger section);
typedef void (^TableDidCreateHeaderFooterViewBlock)(UITableView*, NSInteger section, UIView* headerFooterView);
typedef NSInteger (^TableNumberOfRowsInSection)(UITableView*, NSInteger section);
typedef id (^TableRowItem)(UITableView*, NSIndexPath*);
typedef CGFloat (^TableRowHeightBlock)(UITableView*,NSIndexPath* indexPath, id rowItem);
typedef void (^TableManipulateWithRowBlock)(UITableView*,id cell,NSIndexPath* indexPath, id rowItem);




@interface TableDatasourceAndDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView;

@property (readonly, nonatomic) UITableView * tableView;

@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) NSArray * rowItems;
@property (nonatomic, strong) Class cellClass;

// Defaults:

@property (nonatomic) CGFloat defaultHeaderHeight;
@property (nonatomic) CGFloat defaultFooterHeight;
@property (nonatomic) CGFloat defaultRowHeight;

// Callback requests:

@property (nonatomic, copy) TableHeaderFooterHeightBlock headerHeightBlock;
@property (nonatomic, copy) TableHeaderFooterHeightBlock footerHeightBlock;
@property (nonatomic, copy) TableCreateHeaderFooterViewBlock createHeaderBlock;
@property (nonatomic, copy) TableCreateHeaderFooterViewBlock createFooterBlock; 
@property (nonatomic, copy) TableNumberOfRowsInSection numberOfRowsBlock;
@property (nonatomic, copy) TableRowItem getRowItemBlock;
@property (nonatomic, copy) TableRowHeightBlock rowHeightBlock;
@property (nonatomic, copy) TableManipulateWithRowBlock configureCellBlock;
@property (nonatomic, copy) TableManipulateWithRowBlock didSelectRowBlock;

- (void)setHeaderHeightBlock:(TableHeaderFooterHeightBlock)headerHeightBlock;
- (void)setFooterHeightBlock:(TableHeaderFooterHeightBlock)footerHeightBlock;
- (void)setCreateHeaderBlock:(TableCreateHeaderFooterViewBlock)createHeaderBlock;
- (void)setCreateFooterBlock:(TableCreateHeaderFooterViewBlock)createFooterBlock;
- (void)setNumberOfRowsBlock:(TableNumberOfRowsInSection)numberOfRowsBlock;
- (void)setGetRowItemBlock:(TableRowItem)getRowItemBlock;
- (void)setRowHeightBlock:(TableRowHeightBlock)rowHeightBlock;
- (void)setConfigureCellBlock:(TableManipulateWithRowBlock)configureCellBlock;
- (void)setDidSelectRowBlock:(TableManipulateWithRowBlock)didSelectRowBlock;

@end

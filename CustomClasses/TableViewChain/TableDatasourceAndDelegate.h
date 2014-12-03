//
//  TableDatasourceAndDelegate.h
//
//
//  Created by Mykola Denysyuk on 8/4/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef CGFloat (^TableHeaderFooterHeightBlock)(UITableView* tableView, NSInteger section);
typedef UIView* (^TableCreateHeaderFooterViewBlock)(UITableView* tableView,NSInteger section);
typedef void (^TableDidCreateHeaderFooterViewBlock)(UITableView* tableView, NSInteger section, UIView* headerFooterView);
typedef NSInteger (^TableNumberOfRowsInSection)(UITableView* tableView, NSInteger section);
typedef id (^TableRowItem)(UITableView* tableView, NSIndexPath* indexPath);
typedef CGFloat (^TableRowHeightBlock)(UITableView* tableView,NSIndexPath* indexPath, id rowItem);
typedef void (^TableManipulateWithRowBlock)(UITableView* tableView,id cell,NSIndexPath* indexPath, id rowItem);
typedef void (^ScrollViewDidScrollBlock)(UIScrollView* scrollView, BOOL willDecelerate);



@interface TableDatasourceAndDelegate : NSObject <UITableViewDelegate, UITableViewDataSource>

- (instancetype)initWithTableView:(UITableView *)tableView;
- (void)configureForTableView:(UITableView *)tableView;

@property (readonly, nonatomic, setter=configureForTableView:) UITableView * tableView;

@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) NSArray * rowItems;
@property (nonatomic, strong) Class cellClass;

// Defaults:

@property (nonatomic) CGFloat defaultHeaderHeight;
@property (nonatomic) CGFloat defaultFooterHeight;
@property (nonatomic) CGFloat defaultRowHeight;
@property (nonatomic) UITableViewCellSelectionStyle cellSelectionStyle;

// Callback requests:

@property (nonatomic, copy) TableHeaderFooterHeightBlock headerHeightBlock;
@property (nonatomic, copy) TableHeaderFooterHeightBlock footerHeightBlock;
@property (nonatomic, copy) TableCreateHeaderFooterViewBlock createHeaderBlock;
@property (nonatomic, copy) TableCreateHeaderFooterViewBlock createFooterBlock;
@property (nonatomic, copy) TableNumberOfRowsInSection numberOfSectionsBlock;
@property (nonatomic, copy) TableNumberOfRowsInSection numberOfRowsBlock;
@property (nonatomic, copy) TableRowItem getRowItemBlock;
@property (nonatomic, copy) TableRowHeightBlock rowHeightBlock;
@property (nonatomic, copy) TableManipulateWithRowBlock configureCellBlock;
@property (nonatomic, copy) TableManipulateWithRowBlock didSelectRowBlock;
@property (nonatomic, copy) ScrollViewDidScrollBlock scrollViewDidScrollBlock;
@property (nonatomic, copy) ScrollViewDidScrollBlock scrollViewDidEndDragingBlock;

- (void)setHeaderHeightBlock:(TableHeaderFooterHeightBlock)headerHeightBlock;
- (void)setFooterHeightBlock:(TableHeaderFooterHeightBlock)footerHeightBlock;
- (void)setCreateHeaderBlock:(TableCreateHeaderFooterViewBlock)createHeaderBlock;
- (void)setCreateFooterBlock:(TableCreateHeaderFooterViewBlock)createFooterBlock;
- (void)setNumberOfSectionsBlock:(TableNumberOfRowsInSection)numberOfSectionsBlock;
- (void)setNumberOfRowsBlock:(TableNumberOfRowsInSection)numberOfRowsBlock;
- (void)setGetRowItemBlock:(TableRowItem)getRowItemBlock;
- (void)setRowHeightBlock:(TableRowHeightBlock)rowHeightBlock;
- (void)setConfigureCellBlock:(TableManipulateWithRowBlock)configureCellBlock;
- (void)setDidSelectRowBlock:(TableManipulateWithRowBlock)didSelectRowBlock;
- (void)setScrollViewDidScrollBlock:(ScrollViewDidScrollBlock)scrollViewDidScrollBlock;
- (void)setScrollViewDidEndDragingBlock:(ScrollViewDidScrollBlock)scrollViewDidEndDragingBlock;

@end

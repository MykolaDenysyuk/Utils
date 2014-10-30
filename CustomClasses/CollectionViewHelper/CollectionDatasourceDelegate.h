//
//  CollectionDatasourceDelegate.h
//  CollectionDatasourceDelegate
//
//  Created by Mykola Denysyuk on 10/29/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger (^CollectionNumberOfItemsInSectionBlock)(UICollectionView* collectionView, NSInteger section);
typedef id (^CollectionItemBlock)(UICollectionViewCell* collectionView, NSIndexPath* indexPath);
typedef void (^CollectionManipulateWithItemBlock)(UICollectionView* collectionView,UICollectionViewCell* cell,NSIndexPath* indexPath, id item);


@interface CollectionDatasourceDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

// Initial values

@property (readonly, nonatomic, setter=configureWithCollectionView:) UICollectionView * collectionView;
@property (readonly, nonatomic, setter=registerCellClass:) Class cellClass;
@property (nonatomic) NSArray * items;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (void)configureWithCollectionView:(UICollectionView *)collectionView;
- (void)registerCellClass:(Class )cellClass;


// Configuration:

@property (nonatomic, copy) CollectionNumberOfItemsInSectionBlock numberOfItemsBlock;
@property (nonatomic, copy) CollectionItemBlock getItemBlock;
@property (nonatomic, copy) CollectionManipulateWithItemBlock configureCellBlock;
@property (nonatomic, copy) CollectionManipulateWithItemBlock didSelectItemBlock;

- (void)setNumberOfItemsBlock:(CollectionNumberOfItemsInSectionBlock)numberOfItemsBlock;
- (void)setGetItemBlock:(CollectionItemBlock)getItemBlock;
- (void)setConfigureCellBlock:(CollectionManipulateWithItemBlock)configureCellBlock;
- (void)setDidSelectItemBlock:(CollectionManipulateWithItemBlock)didSelectItemBlock;

@end

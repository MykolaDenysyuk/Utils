//
//  CollectionDatasourceDelegate.h
//  CollectionDatasourceDelegate
//
//  Created by Mykola Denysyuk on 10/29/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSInteger (^CollectionNumberOfSectionsBlock)(UICollectionView* collectionView);
typedef NSInteger (^CollectionNumberOfItemsInSectionBlock)(UICollectionView* collectionView, NSInteger section);
typedef id (^CollectionItemBlock)(UICollectionViewCell* collectionView, NSIndexPath* indexPath);
typedef void (^CollectionManipulateWithItemBlock)(UICollectionView* collectionView,UICollectionViewCell* cell,NSIndexPath* indexPath, id item);
typedef UICollectionReusableView* (^CollectionReturnSupplementaryView)(UICollectionView* collectionView, NSString* kind, NSIndexPath* indexPath);
typedef void(^CollectionConfigureSupplementaryViewBlock)(UICollectionView* collectionView, UICollectionReusableView* view, NSString* kind, NSIndexPath* indexPath);
typedef CGSize(^CollectionReturnSizeBlock)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSIndexPath* indexPath);
typedef CGFloat(^CollectionReturnSpacingBlock)(UICollectionView* collectionView, UICollectionViewLayout* layout, NSInteger section);

extern NSString * const CollectionDefaultReusableViewIdentifier;

@interface CollectionDatasourceDelegate : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

// Initial values

@property (readonly, nonatomic, setter=configureWithCollectionView:) UICollectionView * collectionView;
@property (readonly, nonatomic, setter=registerCellClass:) Class cellClass;
@property (nonatomic) NSArray * items;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (void)configureWithCollectionView:(UICollectionView *)collectionView;
- (void)registerCellClass:(Class )cellClass;


// Configuration:
@property (nonatomic, copy) CollectionNumberOfSectionsBlock numberOfSectionsBlock;
@property (nonatomic, copy) CollectionNumberOfItemsInSectionBlock numberOfItemsBlock;
@property (nonatomic, copy) CollectionItemBlock getItemBlock;
@property (nonatomic, copy) CollectionManipulateWithItemBlock configureCellBlock;
@property (nonatomic, copy) CollectionManipulateWithItemBlock didSelectItemBlock;
@property (nonatomic, copy) CollectionReturnSupplementaryView returnSupplementaryViewBlock;
@property (nonatomic, copy) CollectionConfigureSupplementaryViewBlock configureSupplementaryViewBlock;
@property (nonatomic, copy) CollectionReturnSizeBlock getItemSizeBlock;
@property (nonatomic, copy) CollectionReturnSpacingBlock minimumLineSpacingBlock;
@property (nonatomic, copy) CollectionReturnSpacingBlock minimumInteritemSpacingBlock;

- (void)setNumberOfSectionsBlock:(CollectionNumberOfSectionsBlock)numberOfSectionsBlock;
- (void)setNumberOfItemsBlock:(CollectionNumberOfItemsInSectionBlock)numberOfItemsBlock;
- (void)setGetItemBlock:(CollectionItemBlock)getItemBlock;
- (void)setConfigureCellBlock:(CollectionManipulateWithItemBlock)configureCellBlock;
- (void)setDidSelectItemBlock:(CollectionManipulateWithItemBlock)didSelectItemBlock;
- (void)setReturnSupplementaryViewBlock:(CollectionReturnSupplementaryView)returnSupplementaryViewBlock;
- (void)setConfigureSupplementaryViewBlock:(CollectionConfigureSupplementaryViewBlock)configureSupplementaryViewBlock;
- (void)setGetItemSizeBlock:(CollectionReturnSizeBlock)getItemSizeBlock;
- (void)setMinimumLineSpacingBlock:(CollectionReturnSpacingBlock)minimumLineSpacingBlock;
- (void)setMinimumInteritemSpacingBlock:(CollectionReturnSpacingBlock)minimumInteritemSpacingBlock;

@end

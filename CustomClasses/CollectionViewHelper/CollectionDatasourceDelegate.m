//
//  CollectionDatasourceDelegate.m
//  CollectionDatasourceDelegate
//
//  Created by Mykola Denysyuk on 10/29/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "CollectionDatasourceDelegate.h"

NSString * const CollectionDefaultReusableViewIdentifier = @"reusableViewId";

@interface CollectionDatasourceDelegate ()
{
    IBOutlet UICollectionView * _nibCollectionView;
    NSString * _cellClassName;
}
@end

@implementation CollectionDatasourceDelegate

#pragma mark - Lifecycle:

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

 - (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        [self configureWithCollectionView:collectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureWithCollectionView:_nibCollectionView];
    [self registerCellClass:nil];
}

- (void)configureWithCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:CollectionDefaultReusableViewIdentifier];
}

#pragma mark - Accessors:

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.collectionView reloadData];
}

- (void)registerCellClass:(Class)cellClass
{
    if (cellClass == nil)
        cellClass = [UICollectionViewCell class];
    
    _cellClass = cellClass;
    _cellClassName = NSStringFromClass(cellClass);
    [self.collectionView registerClass:cellClass
            forCellWithReuseIdentifier:_cellClassName];
}

#pragma mark - UICollectionView:

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (_numberOfSectionsBlock) {
        return _numberOfSectionsBlock(collectionView);
    }
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (_returnSupplementaryViewBlock) {
        return _returnSupplementaryViewBlock(collectionView, kind, indexPath);
    }
    
    UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                        withReuseIdentifier:CollectionDefaultReusableViewIdentifier
                                                                               forIndexPath:indexPath];
    if (_configureSupplementaryViewBlock) {
        _configureSupplementaryViewBlock(collectionView, view, kind, indexPath);
    }
    return view;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfItemsBlock)
        return self.numberOfItemsBlock(collectionView, section);
    return self.items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_getItemSizeBlock)
        return _getItemSizeBlock(collectionView, collectionViewLayout, indexPath);
    return [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (_minimumLineSpacingBlock)
        return _minimumLineSpacingBlock(collectionView, collectionViewLayout, section);
    return [(UICollectionViewFlowLayout*)collectionViewLayout minimumLineSpacing];
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (_minimumInteritemSpacingBlock)
        return _minimumInteritemSpacingBlock(collectionView, collectionViewLayout, section);
    return [(UICollectionViewFlowLayout*)collectionViewLayout minimumInteritemSpacing];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellClassName
                                                                            forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(collectionView, cell, indexPath, [self retriveItemAtIndex:indexPath]);
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectItemBlock) {
        self.didSelectItemBlock(collectionView, [collectionView cellForItemAtIndexPath:indexPath], indexPath, [self retriveItemAtIndex:indexPath]);
    }
}

#pragma mark - Common helpers:

- (id)retriveItemAtIndex:(NSIndexPath *)indexPath
{
    id item = self.getItemBlock ? self.getItemBlock(self.collectionView, indexPath) : self.items.count > indexPath.row ? self.items[indexPath.row] : nil;
    return item;
}

@end

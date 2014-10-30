//
//  CollectionDatasourceDelegate.m
//  CollectionDatasourceDelegate
//
//  Created by Mykola Denysyuk on 10/29/14.
//  Copyright (c) 2014 Mykola Denysyuk. All rights reserved.
//

#import "CollectionDatasourceDelegate.h"

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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.numberOfItemsBlock)
        return self.numberOfItemsBlock(collectionView, section);
    return self.items.count;
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

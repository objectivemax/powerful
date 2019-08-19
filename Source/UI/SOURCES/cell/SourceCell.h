//
//  SourceCell.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 6/6/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SourceCollectionCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFIndexedCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *SourceCellIdentifier = @"SourceCellIdentifier";

@interface SourceCell : UITableViewCell

@property (nonatomic, strong) AFIndexedCollectionView *collectionView;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

//
//  HorizontalScrollView.h
//  HorizontalScrollView
//
//  Created by OHSEUNGWOOK on 2017. 3. 31..
//  Copyright © 2017년 OHSEUNGWOOK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalScrollView : UIScrollView

@property (nonatomic, assign) CGSize itemSize;							// item 사이즈
@property (nonatomic, assign, readonly) CGFloat itemMargin;				// item간 Margin

@property (nonatomic, assign) CGFloat scrollViewLeftSpace;				// 스크롤뷰 좌측 여백
@property (nonatomic, assign) CGFloat minMarginBetweenItems;			// item간의 최소 Margin값
@property (nonatomic, assign) CGFloat minWidthAppearOfLastItem;			// 화면에 노출되는 마지막 Item의 width값

// View
- (NSArray *)itemViews;
- (void)calcurateItemsMargin;

// Add Item
- (void)addItem:(UIView *)item;
- (void)addItems:(NSArray *)items;

// remove Item
- (BOOL)removeItem:(UIView *)item;
- (BOOL)removeItems:(NSArray *)items;
- (BOOL)removeItemAtIndex:(NSInteger)index;
- (BOOL)removeAllItems;

@end

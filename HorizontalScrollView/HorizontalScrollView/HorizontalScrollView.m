//
//  HorizontalScrollView.m
//  HorizontalScrollView
//
//  Created by OHSEUNGWOOK on 2017. 3. 31..
//  Copyright © 2017년 OHSEUNGWOOK. All rights reserved.
//

#import "HorizontalScrollView.h"

@interface HorizontalScrollView ()

@property (nonatomic, assign) CGFloat itemMargin;

@end

#define kDefaultLeftMargin 5.0f;
#define kMinSpaceBetweenItems 10.0f;
#define kMinAppearSpaceOfLastItem 20.0f;

@implementation HorizontalScrollView {
	
	NSMutableArray *items_;
	CGFloat itemY_;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {

		self.showsHorizontalScrollIndicator = NO;
		self.decelerationRate = UIScrollViewDecelerationRateFast;

		[self initView];
	}
	
	return self;
}

- (void)initView
{
	items_ = [NSMutableArray new];
	_itemSize = CGSizeMake(self.frame.size.width * 0.8f, self.frame.size.height * 0.8f);
	
	_scrollViewLeftSpace = kDefaultLeftMargin;
	_minMarginBetweenItems = kMinSpaceBetweenItems;
	_minWidthAppearOfLastItem = kMinAppearSpaceOfLastItem;
}

- (void)setFrame:(CGRect)frame
{
	CGRect oldFrame = self.frame;	// frame이 업데이트되기 전에 저장.
	[super setFrame:frame];
	
	itemY_ = (frame.size.height - _itemSize.height) / 2;
	
	if (frame.size.width != oldFrame.size.width) {
		[self updateAllSubViews];
	}
}

#pragma mark - Item Functions

- (NSArray *)itemViews
{
	return items_;
}

- (void)addItem:(UIView *)item
{
	if (items_ != nil && [items_ count] > 0) {
		
		UIView *prevItem = [items_ lastObject];
		[item setFrame:CGRectMake(CGRectGetMaxX(prevItem.frame) + _itemMargin, itemY_, _itemSize.width, _itemSize.height)];
		
	} else {
		[item setFrame:CGRectMake(_scrollViewLeftSpace, itemY_, _itemSize.width, _itemSize.height)];
	}
	
	[items_ addObject:item];
	[self addSubview:item];
	
	[self setContentSize:CGSizeMake(_scrollViewLeftSpace + item.frame.origin.x + _itemSize.width, self.frame.size.height)];
}

- (void)addItems:(NSArray *)items
{
	for (UIView *item in items) {
		[self addItem:item];
	}
}

- (BOOL)removeItem:(UIView *)item
{
	if (item == nil || ![item isKindOfClass:[UIView class]]) {
		return NO;
	}
	
	if (items_ != nil && [items_ count] > 0 && [items_ containsObject:item]) {
		NSInteger index = [items_ indexOfObject:item];
		if (index != NSNotFound) {
			return [self removeItemAtIndex:index];
		}
	}
	
	return NO;
}

- (BOOL)removeItems:(NSArray *)items
{
	if (items == nil || [items_ count] == 0) {
		return NO;
	}
	
	if (items_ != nil && [items_ count] > 0) {
		
		for (UIView *removeItem in items_) {
			[removeItem removeFromSuperview];
		}
		
		[items_ removeObjectsInArray:items];
		[self updateAllSubViews];
		return YES;
	}
	
	return NO;
}

- (BOOL)removeItemAtIndex:(NSInteger)index
{
	if (index < 0) {
		return NO;
	}
	
	if (items_ != nil && [items_ count] > 0) {
		
		if (index < [items_ count]) {
			
			[items_ enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
				
				UIView *item = obj;
				
				if (idx == index) {
					
					// Item 삭제
					if (item != nil) {
						[item removeFromSuperview];
					}
					[items_ removeObjectAtIndex:index];
					
				} else if (index < idx) {
					
					// 삭제된 Item의 뒤 Item 재정렬
					[item setFrame:CGRectMake(CGRectGetMinX(item.frame) - _itemMargin - _itemSize.width,
											  itemY_,
											  _itemSize.width,
											  _itemSize.height)];
				}
			}];
			
			return YES;
		}
	}
	
	return NO;
}

- (BOOL)removeAllItems
{
	if (items_ == nil || [items_ count] == 0) {
		return NO;
	}
	
	if (items_ != nil && [items_ count] > 0) {
		
		for (UIView *removeItem in items_) {
			[removeItem removeFromSuperview];
		}
		
		[items_ removeAllObjects];
		self.contentSize = CGSizeZero;
		
		return YES;
	}
	
	return NO;
}

#pragma mark - UI

- (void)setItemSize:(CGSize)itemSize
{
	_itemSize = itemSize;
	itemY_ = (self.frame.size.height - itemSize.height) / 2.0f;
}

- (void)calcurateItemsMargin
{
	// 현재 보이는 스크린 기준으로 노출되는 Item 수. (내림처리)
	NSInteger showItemCount = floorf(self.frame.size.width - _scrollViewLeftSpace - _minWidthAppearOfLastItem) / (_itemSize.width + _minMarginBetweenItems);
	
	// Item간 Margin
	_itemMargin = round(((self.frame.size.width - _scrollViewLeftSpace - _minWidthAppearOfLastItem) / showItemCount) - _itemSize.width);
}

- (void)updateAllSubViews
{
	// Margin
	[self calcurateItemsMargin];
	
	CGFloat itemX = _scrollViewLeftSpace;
	
	for (UIView *item in items_) {
		item.frame = CGRectMake(itemX, item.frame.origin.y, item.frame.size.width, item.frame.size.height);
		itemX += item.frame.size.width + _itemMargin;
	}
	
	itemX = itemX - _itemMargin + _scrollViewLeftSpace;
	self.contentSize = CGSizeMake(itemX, self.frame.size.height);
}

@end


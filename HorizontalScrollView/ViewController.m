//
//  ViewController.m
//  HorizontalScrollView
//
//  Created by OHSEUNGWOOK on 2017. 4. 5..
//  Copyright © 2017년 OHSEUNGWOOK. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalScrollView.h"

#define ITEM_SIZE 150.0f

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self loadButtonScrollViews];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)loadButtonScrollViews
{
	HorizontalScrollView *scrollView = [[HorizontalScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, ITEM_SIZE)];
	scrollView.minWidthAppearOfLastItem = ITEM_SIZE / 2.0f;
	scrollView.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
	[scrollView calcurateItemsMargin];
	
	NSMutableArray *buttonArray = [NSMutableArray array];
	for (NSInteger index = 0; index < 10; index++) {
		
		UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
		[button setBackgroundColor:[UIColor redColor]];
		[button setTag:index];
		[button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
		[buttonArray addObject:button];
	}
	
	[scrollView addItems:buttonArray];
	
	[self.view addSubview:scrollView];
	
	scrollView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
														  attribute:NSLayoutAttributeTop
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.topLayoutGuide
														  attribute:NSLayoutAttributeBottom
														 multiplier:1.0f
														   constant:0.0f]];
	
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
														  attribute:NSLayoutAttributeHeight
														  relatedBy:NSLayoutRelationEqual
															 toItem:nil
														  attribute:NSLayoutAttributeNotAnAttribute
														 multiplier:1.0f
														   constant:ITEM_SIZE]];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:scrollView
														  attribute:NSLayoutAttributeWidth
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeWidth
														 multiplier:1.0f
														   constant:0.0f]];
}

- (void)selectedButton:(UIButton *)button
{
	NSLog(@"selected Button Tag : %zd", button.tag);
}

@end

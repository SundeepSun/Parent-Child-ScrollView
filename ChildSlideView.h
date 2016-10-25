//
//  ChildSlideView.h
//  ParentChildSlideViewWithScroll
//
//  Created by sundeep shivakumar on 19/10/16.
//  Copyright © 2016 sundeep shivakumar. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ChildSlideView;

@protocol ChildSlideViewDelegate <NSObject>

@required

-(NSInteger)numberOfSlideItemsInChild:(ChildSlideView *)slideView;

-(NSArray *)namesOfSlideItemsInChild:(ChildSlideView *)slideView;

-(void) slideViewChild:(ChildSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional



- (UIColor *)colorOfSliderInSlideViewChild:(ChildSlideView *)slideView;

- (UIColor *)colorOfSlideViewChild:(ChildSlideView *)slideView;


@end


@interface ChildSlideView : UIView

@property (weak,nonatomic) id<ChildSlideViewDelegate> delegate;

@property (strong,nonatomic) NSMutableArray *namesOfslideItems;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems;

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;

-(void) reloadChildData;

@end

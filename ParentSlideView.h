//
//  ParentSlideView.h
//  ParentChildSlideViewWithScroll
//
//  Created by sundeep shivakumar on 19/10/16.
//  Copyright © 2016 sundeep shivakumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ParentSlideView;

@protocol ParentSlideViewDelegate <NSObject>

@required

-(NSInteger)numberOfSlideItemsInParent:(ParentSlideView *)slideView;

-(NSArray *)namesOfSlideItemsInParent:(ParentSlideView *)slideView;

-(void) slideViewParent:(ParentSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional



- (UIColor *)colorOfSliderInSlideViewParent:(ParentSlideView *)slideView;

- (UIColor *)colorOfSlideViewParent:(ParentSlideView *)slideView;


@end



@interface ParentSlideView : UIView

@property (weak,nonatomic) id<ParentSlideViewDelegate> delegate;

@property (strong,nonatomic) NSMutableArray *namesOfslideItems;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems;

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;



@end

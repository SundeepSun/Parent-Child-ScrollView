//
//  ChildSlideView.m
//  ParentChildSlideViewWithScroll
//
//  Created by sundeep shivakumar on 19/10/16.
//  Copyright © 2016 sundeep shivakumar. All rights reserved.
//

#import "ChildSlideView.h"




#define Slider_Height                   5
#define SlideBar_Height                 50
#define SlideView_Height                50
#define Slider_DefaultColor             [UIColor colorWithRed:148/255.0 green:214/255.0 blue:218/255.0 alpha:1.0]
#define SlideBar_DefaultColor           [UIColor colorWithRed:114/255.0 green:119/255.0 blue:123/255.0 alpha:1.0]
#define SlideView_DefaultColor          [UIColor colorWithRed:114/255.0 green:119/255.0 blue:123/255.0 alpha:1.0]
#define Title_DefaultColor              [UIColor colorWithRed:0.65 green:0.73 blue:0.75 alpha:1]

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)

#define Button_Title_Font                [UIFont systemFontOfSize:16.f]

@interface ChildSlideView () <UIScrollViewDelegate> {
    
    struct {
        
        unsigned int DefinedColorOfSlider : 1;
        unsigned int DefinedColorOfSlideView : 1;
        
    } colorFlag;
    
    
}


@property (assign, nonatomic) NSInteger numberOfSlideItems;

@property (strong, nonatomic) NSArray *namesOfSlideItems;

@property (strong, nonatomic) UIColor *colorOfSlider;

@property (strong, nonatomic) UIColor *colorOfSlideView;

@property (strong, nonatomic) UIView *slideBar;

@property (strong, nonatomic) UIView *slider;

@property (strong, nonatomic) UIScrollView *contentScrollView;

@property (strong, nonatomic) UIScrollView *childScrollView;

@property (strong, nonatomic) NSMutableArray *buttonsArray;

@end


@implementation ChildSlideView
#pragma mark - setter (Override)

-(void)setDelegate:(id<ChildSlideViewDelegate>)delegate {
    
    _delegate = delegate;
    colorFlag.DefinedColorOfSlider = [delegate respondsToSelector:@selector(colorOfSliderInSlideViewChild:)];
    colorFlag.DefinedColorOfSlideView = [delegate respondsToSelector:@selector(colorOfSlideViewChild:)];
}


#pragma mark - life cycle

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        [self setBackgroundColor:[UIColor grayColor]];
        [self initData];
    }
    
    return self;
}

-(void) layoutSubviews {
    
    [super layoutSubviews];
    [self configureData];
    [self addSubViews];
}

-(void) initData {
    
    _numberOfSlideItems = 0;
    _namesOfSlideItems = [NSMutableArray new];
    _colorOfSlider = Slider_DefaultColor;
    _colorOfSlideView = SlideView_DefaultColor;
    _buttonsArray = [NSMutableArray new];
}

-(void) configureData {
    
    self.numberOfSlideItems = [self.delegate numberOfSlideItemsInChild:self];
    self.namesOfSlideItems = [self.delegate namesOfSlideItemsInChild:self];
}

-(void) addSubViews {
    
    [self addChildScrollView];
    [self addSlideBar];
    [self addButtons];
    [self addSlider];
    
}

-(void) addChildScrollView {
    
    if( ! _childScrollView){
       
        _childScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, SlideBar_Height)];
        _childScrollView.backgroundColor =  SlideBar_DefaultColor;
        CGFloat slideItemWidth = 0;
        for (NSInteger number=0; number < _numberOfSlideItems; number++) {
            NSString *title = [self.namesOfSlideItems objectAtIndex:number];
          slideItemWidth   = slideItemWidth+ [title sizeWithFont:Button_Title_Font].width+10;
        }
        _childScrollView.contentSize = CGSizeMake(slideItemWidth+40, 0);
        _childScrollView.bounces = YES;
        _childScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_childScrollView];
        
    }
    

    
}

-(void) addSlideBar {
    
    if(! _slideBar){
        _slideBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _childScrollView.contentSize.width, SlideBar_Height)];
        _slideBar.backgroundColor = SlideBar_DefaultColor;
        [self.childScrollView addSubview:_slideBar];
    }
    
}

-(void) addButtons {
    
    NSInteger numberOfItems = [self.namesOfSlideItems count];
    CGFloat previousSlideItemWidth = 0;
    
    for (NSInteger number=0; number < numberOfItems; number++) {
      
        NSString *title = [self.namesOfSlideItems objectAtIndex:number];
        CGFloat slideItemWidth = [title sizeWithFont:Button_Title_Font].width+10;
        CGFloat position_x = 1.5;
        [self.slideBar addSubview:[self customButtonWithFrame:CGRectMake( position_x+previousSlideItemWidth, 5, slideItemWidth, 35)
                                                     forTitle:[self.namesOfSlideItems objectAtIndex:number]
                                                      withTag:number]];
        previousSlideItemWidth = slideItemWidth+(position_x+previousSlideItemWidth);
    }
}

- (void)addSlider {
    
    if(! _slider){
        CGFloat slideItemWidth = [[self.namesOfSlideItems objectAtIndex:0] sizeWithFont:Button_Title_Font].width +10;
        CGFloat position_x = 1.5;
        [self.slideBar addSubview:[self sliderWithFrame:CGRectMake( position_x, SlideView_Height-Slider_Height, slideItemWidth, Slider_Height)]];
    }

}



#pragma mark - Button custom methods


- (UIButton *)customButtonWithFrame:(CGRect)rect forTitle:(NSString *)title withTag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTag:tag];
    [button setTitleColor:Title_DefaultColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:Button_Title_Font];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonsArray addObject:button];
    
    return button;
}





#pragma mark - event response
- (void)buttonClicked:(UIButton *)button {
    
    [self.delegate slideViewChild:self didSelectItemAtIndex:button.tag];
    [self animateSliderToPositionWithOffset:CGPointMake(button.frame.origin.x, 0) tag:button.tag];
    for (UIButton *button in _buttonsArray) {
        
        [button setTitleColor:Title_DefaultColor forState:UIControlStateNormal];
    }
    [button setTitleColor:[_slider backgroundColor] forState:UIControlStateNormal];
    
    
}

#pragma - mark private methods

- (void)animateSliderToPositionWithOffset:(CGPoint)offset tag:(NSInteger)tag{
    
    CGFloat slideItemWidth = [[self.namesOfSlideItems objectAtIndex:tag] sizeWithFont:Button_Title_Font].width + 10;
    CGFloat position_x = 1.5;
    CGRect newFrame = CGRectMake(offset.x+position_x, _slider.frame.origin.y, slideItemWidth, _slider.frame.size.height);
    [_slider setFrame:newFrame];
    
}



- (UIView *)sliderWithFrame:(CGRect)rect {
    
    if (!_slider) {
        
        _slider = [[UIView alloc] initWithFrame:rect];
        [_slider setBackgroundColor:Slider_DefaultColor];
        
        if (colorFlag.DefinedColorOfSlider) {
            
            [_slider setBackgroundColor:[self.delegate colorOfSliderInSlideViewChild:self]];
        }
        
        if (colorFlag.DefinedColorOfSlideView) {
            
            [_slideBar setBackgroundColor:[self.delegate colorOfSliderInSlideViewChild:self]];
        }
    }
    
    return _slider;
}


#pragma - mark Reload Child View 

-(void) reloadChildData {
    
    [_childScrollView removeFromSuperview];
    
    for(UIView *subViews in _childScrollView.subviews){
        [subViews removeFromSuperview];
        
        for(UIView *sub in subViews.subviews){
            [sub removeFromSuperview];
        }
       
    }
    
    _childScrollView = nil;
    _slider = nil;
    _slideBar = nil;
    [_buttonsArray removeAllObjects];
    [self configureData];
    [self addSubViews];
}



@end

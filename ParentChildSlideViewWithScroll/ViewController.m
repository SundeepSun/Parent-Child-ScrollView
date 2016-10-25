//
//  ViewController.m
//  ParentChildSlideViewWithScroll
//
//  Created by sundeep shivakumar on 19/10/16.
//  Copyright © 2016 sundeep shivakumar. All rights reserved.
//

#import "ViewController.h"
#import "ParentSlideView.h"
#import "ChildSlideView.h"

@interface ViewController () <ParentSlideViewDelegate,ChildSlideViewDelegate>

@property (strong,nonatomic) NSMutableArray *childDataArray;

@property (strong,nonatomic) NSMutableArray *parentDataArray;

@property (strong,nonatomic) ChildSlideView *childSlideView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ParentSlideView *parentSlideView = [[ParentSlideView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    parentSlideView.delegate = self;
    [self.view addSubview:parentSlideView];
    
    _childSlideView = [[ChildSlideView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height-64)];
    _childSlideView.delegate = self;
    [self.view addSubview:_childSlideView];
    
    _parentDataArray = [[NSMutableArray alloc] initWithObjects:@"Andhra Pradesh", @"Arunachal Pradesh", @"Assam", @"Bihar",@"Chhattisgarh",@"Goa",@"Gujarat",@"Haryana",@"Himachal Pradesh",@"Jammu and Kashmir",@"Jharkhand", @"Karnataka", @"Kerala", @"Madhya Pradesh",@"Maharashtra",@"Manipur",@"Meghalaya",@"Mizoram",@"Nagaland",@"Odisha",@"Punjab",@"Rajasthan",@"Sikkim",@"Tamil Nadu",@"Telangana",@"Tripura",@"Uttar Pradesh",@"Uttarakhand",@"West Bengal", nil];
    
    _childDataArray = [[NSMutableArray alloc] initWithObjects:@"Andaman and Nicobar Islands", @"Chandigarh", @"Dadar and Nagar Haveli", @"Daman and Diu",@"Delhi",@"Lakshadweep",@"Puducherry", nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ParentSlideViewDelegate

- (NSInteger)numberOfSlideItemsInParent:(ParentSlideView *)slideView {
    
    return _parentDataArray.count ;
}

- (NSArray *)namesOfSlideItemsInParent:(ParentSlideView *)slideView {

    return _parentDataArray;
}

- (void)slideViewParent:(ParentSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    
    NSLog(@" index %li", index);
    [_childDataArray removeAllObjects];
    
    for (NSInteger number=0; number < _parentDataArray.count; number++) {
        
        [_childDataArray addObject:[_parentDataArray objectAtIndex:index]];
        
    }
    
    [_childSlideView reloadChildData];
    
}


#pragma mark - ChildSlideViewDelegate

- (NSInteger)numberOfSlideItemsInChild:(ChildSlideView *)slideView {
    
    return _childDataArray.count;
}

- (NSArray *)namesOfSlideItemsInChild:(ChildSlideView *)slideView {
    
   
    return _childDataArray;
}

- (void)slideViewChild:(ChildSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    
    NSLog(@" index %li", index);
}



@end

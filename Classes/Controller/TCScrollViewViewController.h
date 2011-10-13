//
//  TCScrollViewViewController.h
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCScrollView.h"
#import "TCBackgroundView.h"

@interface TCScrollViewViewController : UIViewController <UIScrollViewDelegate>{
    TCScrollView        *_scrollView;
    TCBackgroundView    *_backgroundView;
    NSMutableArray      *_informationArray;//information to from models, to views
    NSMutableArray      *_displayedArray;
    NSNumber            *_previousPosition;
}
@property(nonatomic,assign) TCScrollView        *scrollView;
@property(nonatomic,assign) TCBackgroundView    *backgroundView;
@property(nonatomic,retain) NSMutableArray      *informationArray;
@property(nonatomic,retain) NSMutableArray      *displayedArray;
@property(nonatomic,retain) NSNumber            *previousPosition;

-(id)init;

@end


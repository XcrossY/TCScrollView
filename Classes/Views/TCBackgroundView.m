//
//  TCBackgroundView.m
//  TCScrollView
//
//  Created by Zander on 10/8/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import "TCBackgroundView.h"


@implementation TCBackgroundView

-(void)dealloc {
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame {    
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    return self;
}

@end

//
//  TCLabelSwitchView.m
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import "TCLabelSwitchView.h"


@implementation TCLabelSwitchView
@synthesize label = _label;
@synthesize onoff = _onoff;

static const CGFloat kFontSize = 15.0f;

-(void)dealloc {
    self.label = nil;
    self.onoff = nil;
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame 
        andTCState:(TCState *)state {

    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.label      = [[UILabel alloc] initWithFrame:
                           CGRectMake(0.0f, 0.0f, 
                                      self.frame.size.width, 
                                      self.frame.size.height/2)];
        [self.label setBackgroundColor:[UIColor clearColor]];
        self.label.text = state.name;
        self.label.textAlignment = UITextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:kFontSize];
        [self addSubview:self.label];
        
        self.onoff      = [[UISwitch alloc]initWithFrame:
                           CGRectMake(0.0, self.frame.size.height/2, 100.0, 100.0)];
        if (state.switchState) {
            self.onoff.on = YES; 
        }
        [self addSubview:self.onoff];
    }
    return self;
}

-(BOOL)switchState {
    return self.onoff.on;
}


@end

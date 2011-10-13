//
//  TCScrollView.m
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import "TCScrollView.h"

//Each labelSwitch object will have a width of kLabelSwitchWidth
static const CGFloat    kLabelSwitchWidth   = 130.0f;
static const CGFloat    kLabelSwitchOffsetX = 15.0f;

@implementation TCScrollView
@dynamic delegate;

-(void)dealloc {
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scrollEnabled = YES;
        [self setBackgroundColor:[UIColor lightTextColor]];
    }
    return self;
}


-(TCLabelSwitchView *)addLabelSwitch:(TCState *)state 
           atPosition:(NSNumber *)number {
    TCLabelSwitchView *labelSwitch = [[TCLabelSwitchView alloc]initWithFrame:
                                      CGRectMake(kLabelSwitchOffsetX + [number intValue]*kLabelSwitchWidth, 
                                                 self.frame.size.height/4, 
                                                 kLabelSwitchWidth-2*kLabelSwitchOffsetX, 
                                                 self.frame.size.height/2)
                                                                  andTCState:state];
    [self addSubview:labelSwitch];
    [labelSwitch release];
    NSLog(@"added at %i", [number intValue]);
    return labelSwitch;
}

-(void)removeLabelSwitch:(TCLabelSwitchView *)labelSwitch
              atPosition:(NSNumber *)number {
    [labelSwitch removeFromSuperview];
    NSLog(@"removed at %i", [number intValue]);
}


@end

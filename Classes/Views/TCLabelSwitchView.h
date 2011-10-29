//
//  TCLabelSwitchView.h
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCState.h"


@interface TCLabelSwitchView : UIView {
    UILabel     *_label;
    UISwitch    *_onoff;
}
@property(nonatomic,retain) UILabel    *label;
@property(nonatomic,retain) UISwitch   *onoff;

-(id)initWithFrame:(CGRect)frame
        andTCState:(TCState *)state;
-(BOOL)switchState; 

@end

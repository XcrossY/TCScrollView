//
//  TCScrollView.h
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCLabelSwitchView.h"
#import "TCState.h"


@interface TCScrollView : UIScrollView {
    id <UIScrollViewDelegate>   delegate;
}
@property(nonatomic,assign) id <UIScrollViewDelegate>   delegate;

-(id)initWithFrame:                         (CGRect)frame; 
-(TCLabelSwitchView *)addLabelSwitch:       (TCState *)state
                          atPosition:       (NSNumber *)number; //Positions start at zero
-(void)removeLabelSwitch:                   (TCLabelSwitchView *)labelSwitch 
              atPosition:                   (NSNumber *)number; 
@end

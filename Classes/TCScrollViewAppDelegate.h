//
//  TCScrollViewAppDelegate.h
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TCScrollViewViewController;

@interface TCScrollViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TCScrollViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) TCScrollViewViewController *viewController;

@end


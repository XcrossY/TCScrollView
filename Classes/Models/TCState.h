//
//  TCState.h
//  TCScrollView
//
//  Created by Zander on 10/8/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TCState : NSObject {
    NSString    *_name;
    NSNumber    *_switchState; //wrapper for BOOL value. 0 is NO, other is YES
}
@property(nonatomic,copy)   NSString    *name;
@property(nonatomic,retain) NSNumber    *switchState;

//all states initialized with switchState=0
-(id)initWithName:(NSString *)name;
-(void)switchStateTo:(NSNumber *)number;
+(NSMutableArray *)getAll50States;

@end

//
//  TCState.m
//  TCScrollView
//
//  Created by Zander on 10/8/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import "TCState.h"

@implementation TCState
@synthesize name        = _name;
@synthesize switchState = _switchState;

-(void)dealloc {
    self.name        = nil;
    self.switchState = nil;
    [super dealloc];    
}

-(id)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name        = name;
        self.switchState = nil;
    }
    return self;
}

-(void)switchStateTo:(NSNumber *)number {
    self.switchState = number;
}

+(NSMutableArray *)getAll50States {
    
    //from http://www.ilru.org/html/publications/directory/state_list.html
    //also showing D.C. some love
    NSArray *stringArray = [[NSArray alloc]initWithObjects:
                             @"Alabama",@"Alaska",@"Arizona",@"Arkansas",
                             @"California",@"Colorado",@"Connecticut",
                             @"Delaware",@"D.C.",
                             @"Florida",@"Georgia",@"Hawaii",@"Idaho",@"Illinois",
                             @"Indiana",@"Iowa",@"Kansas",@"Kentucky",@"Louisiana",
                             @"Maine",@"Maryland",@"Massachusetts",@"Michigan",
                             @"Minnesota",@"Mississippi",@"Missouri",@"Montana",
                             @"Nebraska",@"Nevada",@"New Hampshire",@"New Jersey",
                             @"New Mexico",@"New York",@"North Carolina",
                             @"North Dakota",@"Ohio",@"Oklahoma",@"Oregon",
                             @"Pennsylvania",@"Rhode Island",@"South Carolina",
                             @"South Dakota",@"Tennessee",@"Texas",@"Utah",
                             @"Vermont",@"Virginia",@"Washington",
                             @"West Virginia",@"Wisconsin",@"Wyoming", nil];
    
    NSMutableArray *statesArray = [[NSMutableArray alloc]
                                   initWithCapacity:[stringArray count]];
    for (int i=0; i<[stringArray count]; i++) {
        [statesArray addObject:
         [[TCState alloc]initWithName:[stringArray objectAtIndex:i]]];
    }
    
    return statesArray;
}


@end

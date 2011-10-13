//
//  TCScrollViewViewController.m
//  TCScrollView
//
//  Created by Zander on 10/2/11.
//  Copyright 2011 MetroGnome, LLC. All rights reserved.
//

#import "TCScrollViewViewController.h"
#import "TCState.h"

@interface TCScrollViewViewController (Private)
-(void)scrollViewDidScroll:         (UIScrollView *)scrollView;
-(void)loadLabelSwitchAtPosition:   (NSNumber *)number;
-(void)removeLabelSwitchAtPosition: (NSNumber *)number; 
-(int)getPosition:                  (UIScrollView *)scrollView;
//If being displayed, returns TCLabelSwitch at position number
-(TCLabelSwitchView *)getDisplayedLabelSwitchAtPosition:(NSNumber *)number; 
@end


@implementation TCScrollViewViewController
@synthesize scrollView          = _scrollView;
@synthesize backgroundView      = _backgroundView;
@synthesize informationArray    = _informationArray;
@synthesize displayedArray      = _displayedArray;
@synthesize previousPosition    = _previousPosition;

static const CGFloat    kScreenHeight       = 480.0f;
static const CGFloat    kScreenWidth        = 320.0f;
static const CGFloat    kScrollViewOffsetX  = 15.0f;
static const CGFloat    kScrollViewOffsetY  = 45.0f;
static const CGFloat    kLabelSwitchWidth   = 130.0f;
static const int        kTotalDisplayedLabelSwitch = 3;

-(void)dealloc {
    self.backgroundView     = nil;
    self.scrollView         = nil;
    self.displayedArray     = nil;
    self.informationArray   = nil;
    self.previousPosition   = nil;
    [super dealloc];
}

-(id)init {
    if (self = [super init]) {
        self.informationArray = [TCState getAll50States];
        self.displayedArray = [NSMutableArray arrayWithCapacity:[self.informationArray count]];
        self.backgroundView = [[TCBackgroundView alloc]initWithFrame:
                               CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
        self.scrollView     = [[TCScrollView alloc]initWithFrame:
                               CGRectMake(kScrollViewOffsetX, kScrollViewOffsetY, 
                                          kScreenWidth-2*kScrollViewOffsetX, 
                                          kScreenHeight/3)];
        [self.scrollView setContentSize:
         CGSizeMake(kLabelSwitchWidth*[self.informationArray count], self.scrollView.frame.size.height)];
        
        //initial scrollView has 3 LabelSwitches
        int initialContent = 4;
        for (int i = 0; i < initialContent; i++) {
            TCLabelSwitchView *labelSwitch = 
            [self.scrollView addLabelSwitch:[self.informationArray objectAtIndex:i]
                                 atPosition:[[NSNumber alloc]initWithInt:i]];
            [self.displayedArray addObject:labelSwitch];
        }
        self.previousPosition = 0;
        self.scrollView.delegate = self;
    }
    return self;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

//Tracks the scrolling of TCScrollView
//If a labelSwitch comes into frame, dynamically creates new labelSwitch
//If a labelSwitch leaves frame, release labelSwitch and store information
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int position    = [self getPosition:scrollView];
    if ([self.previousPosition intValue] == position) {
        return;
    }
    self.previousPosition = [NSNumber numberWithInt:position];
    NSLog(@"Position: %i", position);
    
    int loadBuffer   = 3;
    //load/unload next LabelSwitch if needed
    NSNumber *positionToAdd = [NSNumber numberWithInt:position+loadBuffer];
    if ([positionToAdd intValue] < [self.informationArray count]) {
        //load/unload LabelSwitch farthest to the right
        if (![self getDisplayedLabelSwitchAtPosition:positionToAdd]) {
            [self loadLabelSwitchAtPosition:positionToAdd];
        }
        else {
            [self removeLabelSwitchAtPosition:positionToAdd];
        }
    }
    positionToAdd = [NSNumber numberWithInt:position+loadBuffer-1];
    if ([positionToAdd intValue] < [self.informationArray count]) {

        if (![self getDisplayedLabelSwitchAtPosition:positionToAdd]) {
            [self loadLabelSwitchAtPosition:positionToAdd];
        }
    }
    
    //load/unload LabelSwitches to the left
    NSNumber *positionToRemove = [NSNumber numberWithInt:position-loadBuffer];
    if ([positionToRemove intValue] >= 0) {
        if (![self getDisplayedLabelSwitchAtPosition:positionToRemove]) {
            [self loadLabelSwitchAtPosition:positionToRemove];
        }
        else {
            [self removeLabelSwitchAtPosition:positionToRemove];
        }
    }
    positionToRemove = [NSNumber numberWithInt:position-loadBuffer+1];
    if ([positionToRemove intValue] >= 0) {
        if (![self getDisplayedLabelSwitchAtPosition:positionToRemove]) {
            [self loadLabelSwitchAtPosition:positionToRemove];
        }
    }
}

#pragma mark -
#pragma mark Private
//Creates TCLabelSwitch for and loads in _scrollView at position number.
//Keeps track of TCLabelSwitches being displayed in _displayedArray in this controller
-(void)loadLabelSwitchAtPosition:(NSNumber *)number {
     TCLabelSwitchView *labelSwitch = 
        [self.scrollView addLabelSwitch:[self.informationArray objectAtIndex:[number intValue]]
                             atPosition:number]; 
    [self.displayedArray addObject:labelSwitch];
}

//Removes LabelSwitch at position number
//Iff there is a LabelSwitch in _displayedArray: removes from _scrollView,
//logs any changes to model TCState in _informationArray
-(void)removeLabelSwitchAtPosition:(NSNumber *)number {
    TCLabelSwitchView *labelSwitch = [self getDisplayedLabelSwitchAtPosition:number];
    if (labelSwitch) {
            [self.scrollView removeLabelSwitch:labelSwitch
                                    atPosition:number];
            [self.displayedArray removeObject:labelSwitch];
            
            //record state of UISwitch
            TCState *stateFromView = [[TCState alloc]initWithName:labelSwitch.label.text];
            if ([labelSwitch switchState]) {
                [stateFromView switchStateTo:[NSNumber numberWithInt:1]];
            }
            [self.informationArray replaceObjectAtIndex:[number intValue]
                                             withObject:stateFromView];
    }
}

//Returns LabelSwitch at position number if already displayed, or else returns nil
-(TCLabelSwitchView *)getDisplayedLabelSwitchAtPosition:(NSNumber *)number {
    TCLabelSwitchView *labelSwitch;
    //Because of NSMutableArray mem management and shifting array indices,
    //create consolidatedArray such that we can query each object in the array
    //without segfaulting by accidentally searching outside _displayedArrays bounds
    NSArray *consolidatedArray = [[NSArray alloc]initWithArray:self.displayedArray];
    
    for (int i=0; i<[consolidatedArray count]; i++) {       
        labelSwitch = [consolidatedArray objectAtIndex:i];
        NSNumber *labelSwitchPosition = 
        [NSNumber numberWithFloat:
            (labelSwitch.frame.origin.x-kScrollViewOffsetX)/kLabelSwitchWidth]; 
        
        if ([labelSwitchPosition intValue] == [number intValue]) {
            return labelSwitch;
        }
    }
    return nil;
}

//The leftmost position for a LabelSwitch in ScrollView
-(int)getPosition:(UIScrollView *)scrollView {  
    return scrollView.bounds.origin.x / kLabelSwitchWidth;
}

//As NSMutableArray is slippery, this creates full array with placeholders, such
//that we can keep track of where each LabelSwitch belongs, ie. always has enough slots
-(void)createDisplayArray {
    self.displayedArray = [NSMutableArray arrayWithCapacity:[self.informationArray count]];
    for (int i=0; i<[self.informationArray count]; i++) {
        [self.displayedArray addObject:[NSNumber numberWithInt:4]];
    }
}

#pragma mark -
#pragma mark Memory
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

@end

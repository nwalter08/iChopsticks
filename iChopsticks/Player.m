//
//  Player.m
//  iChopsticks
//
//  Created by Haley Walter on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Hand.h"

@implementation Player

@synthesize LeftHand =_LeftHand;
@synthesize RightHand = _RightHand;

-
(void)setUp {
    self.LeftHand = [[Hand alloc] init];
    self.RightHand = [[Hand alloc] init];
    self.LeftHand.HandCount = 1;
    self.RightHand.HandCount = 1;
}

@end

//
//  Player.h
//  iChopsticks
//
//  Created by Haley Walter on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hand.h"

@interface Player : NSObject

@property (strong, nonatomic) Hand *LeftHand;
@property (strong, nonatomic) Hand *RightHand;

-(void)setUp;

@end

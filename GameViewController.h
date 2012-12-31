//
//  GameViewController.h
//  iChopsticks
//
//  Created by Haley Walter on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface GameViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *ComputerLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *ComputerRightLabel;
@property (strong, nonatomic) IBOutlet UILabel *HumanLeftLabel;
@property (strong, nonatomic) IBOutlet UILabel *HumanRightLabel;

@property (strong, nonatomic) Player *HumanPlayer;
@property (strong, nonatomic) Player *ComputerPlayer;

@property (strong, nonatomic) IBOutlet UIButton *LLButton;
@property (strong, nonatomic) IBOutlet UIButton *LRButton;
@property (strong, nonatomic) IBOutlet UIButton *RLButton;
@property (strong, nonatomic) IBOutlet UIButton *RRButton;
@property (strong, nonatomic) IBOutlet UIButton *SplitButton;

- (IBAction)LLtapped:(id)sender;
- (IBAction)LRtapped:(id)sender;
- (IBAction)RLtapped:(id)sender;
- (IBAction)RRtapped:(id)sender;
- (IBAction)SplitTapped:(id)sender;
@end

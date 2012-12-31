//
//  GameViewController.m
//  iChopsticks
//
//  Created by Haley Walter on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "Player.h"
#import "Hand.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize ComputerLeftLabel = _ComputerLeftLabel;
@synthesize ComputerRightLabel = _ComputerRightLabel;
@synthesize HumanLeftLabel = _HumanLeftLabel;
@synthesize HumanRightLabel = _HumanRightLabel;
@synthesize HumanPlayer = _HumanPlayer;
@synthesize ComputerPlayer = _ComputerPlayer;
@synthesize LLButton = _LLButton;
@synthesize LRButton = _LRButton;
@synthesize RLButton = _RLButton;
@synthesize RRButton = _RRButton;
@synthesize SplitButton = _SplitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self gameSetup];
}

-(void)gameSetup {
    self.HumanPlayer = [[Player alloc] init];
    self.ComputerPlayer = [[Player alloc] init];
    [self.HumanPlayer setUp];
    [self.ComputerPlayer setUp];
    
    [self.LLButton setEnabled:YES];
    [self.LLButton setBackgroundColor:[UIColor clearColor]];
    [self.LRButton setEnabled:YES];
    [self.LRButton setBackgroundColor:[UIColor clearColor]];
    [self.RLButton setEnabled:YES];
    [self.RLButton setBackgroundColor:[UIColor clearColor]];
    [self.RRButton setEnabled:YES];
    [self.RRButton setBackgroundColor:[UIColor clearColor]];
    
    [self checkWinnerAndLabelUpdate];
}

- (void)viewDidUnload
{
    [self setComputerLeftLabel:nil];
    [self setComputerRightLabel:nil];
    [self setHumanLeftLabel:nil];
    [self setHumanRightLabel:nil];
    [self setLLButton:nil];
    [self setLRButton:nil];
    [self setRLButton:nil];
    [self setRRButton:nil];
    [self setSplitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)LLtapped:(id)sender {
    //increase computer's left hand by human's left hand
    [self add:self.HumanPlayer.LeftHand to:self.ComputerPlayer.LeftHand];
    
    //do computer move
    [self computerMove];
}

- (IBAction)LRtapped:(id)sender {
    //increase computer's left hand by human's left hand
    [self add:self.HumanPlayer.LeftHand to:self.ComputerPlayer.RightHand];
    
    //do computer move
    [self computerMove];
}

- (IBAction)RLtapped:(id)sender {
    //increase computer's left hand by human's left hand
    [self add:self.HumanPlayer.RightHand to:self.ComputerPlayer.LeftHand];
    
    //do computer move
    [self computerMove];
}

- (IBAction)RRtapped:(id)sender {
    //increase computer's left hand by human's left hand
    [self add:self.HumanPlayer.RightHand to:self.ComputerPlayer.RightHand];
    
    //do computer move
    [self computerMove];
}

- (IBAction)SplitTapped:(id)sender {
    //combine both hands and divide by two and assign to both hands
    
    int handTotal = self.HumanPlayer.LeftHand.HandCount + self.HumanPlayer.RightHand.HandCount;
    self.HumanPlayer.LeftHand.HandCount = handTotal / 2;
    self.HumanPlayer.RightHand.HandCount = handTotal / 2;
    
    [self computerMove];
    
    [self checkWinnerAndLabelUpdate];
}

- (void)computerMove {
    int compHand = arc4random_uniform(2);
    int humanHand = arc4random_uniform(2);
    
    if (self.ComputerPlayer.LeftHand.HandCount == 0) {
        compHand = 1;
    }
    if (self.ComputerPlayer.RightHand.HandCount == 0) {
        compHand = 0;
    }
    
    if (self.HumanPlayer.LeftHand.HandCount == 0) {
        humanHand = 1;
    }
    if (self.HumanPlayer.RightHand.HandCount == 0) {
        humanHand = 0;
    }
    
    if (compHand == 0) {
        if (humanHand == 0) {
            [self add:self.ComputerPlayer.LeftHand to:self.HumanPlayer.LeftHand];
        } else {
            [self add:self.ComputerPlayer.LeftHand to:self.HumanPlayer.RightHand];
        }
    } else {
        if (humanHand == 0) {
            [self add:self.ComputerPlayer.RightHand to:self.HumanPlayer.LeftHand];
        } else {
            [self add:self.ComputerPlayer.RightHand to:self.HumanPlayer.RightHand];
        }
    }
    
    [self checkWinnerAndLabelUpdate];
}

- (void)add:(Hand*)FirstHand to:(Hand*)SecondHand {
    int handTotal = SecondHand.HandCount + FirstHand.HandCount;
    
    if (handTotal >= 5)
    {
        SecondHand.HandCount = handTotal % 5;
    } else {
        SecondHand.HandCount += FirstHand.HandCount;
    }
}

- (void)checkWinnerAndLabelUpdate {
    if (self.HumanPlayer.LeftHand.HandCount == 0 && self.HumanPlayer.RightHand.HandCount == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"You Lose"
                                                       message: @"Nice try porky!"
                                                      delegate: self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK",nil];
        
        
        [alert show];
        
        [self gameSetup];
    }
    
    if (self.ComputerPlayer.LeftHand.HandCount == 0 && self.ComputerPlayer.RightHand.HandCount == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"You Win"
                                                       message: @"Get a life..."
                                                      delegate: self
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"OK",nil];
        
        
        [alert show];
        
        [self gameSetup];
    }
    
    [self checkHandAvailability];
    
    
    
    //Update all labels
    [self updateLabels];
}

- (void)checkHandAvailability {
    if (self.HumanPlayer.LeftHand.HandCount == 0 || self.ComputerPlayer.LeftHand.HandCount == 0) {
        [self.LLButton setEnabled:NO];
        [self.LLButton setBackgroundColor:[UIColor redColor]];
    } else {
        [self.LLButton setEnabled:YES];
        [self.LLButton setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.HumanPlayer.LeftHand.HandCount == 0 || self.ComputerPlayer.RightHand.HandCount == 0) {
        [self.LRButton setEnabled:NO];
        [self.LRButton setBackgroundColor:[UIColor redColor]];
    } else {
        [self.LRButton setEnabled:YES];
        [self.LRButton setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.HumanPlayer.RightHand.HandCount == 0 || self.ComputerPlayer.LeftHand.HandCount == 0) {
        [self.RLButton setEnabled:NO];
        [self.RLButton setBackgroundColor:[UIColor redColor]];
    } else {
        [self.RLButton setEnabled:YES];
        [self.RLButton setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.HumanPlayer.RightHand.HandCount == 0 || self.ComputerPlayer.RightHand.HandCount == 0) {
        [self.RRButton setEnabled:NO];
        [self.RRButton setBackgroundColor:[UIColor redColor]];
    } else {
        [self.RRButton setEnabled:YES];
        [self.RRButton setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.HumanPlayer.LeftHand.HandCount == 0 && (self.HumanPlayer.RightHand.HandCount % 2) == 0)
    {
        [self.SplitButton setEnabled:YES];
        [self.SplitButton setBackgroundColor:[UIColor clearColor]];
    } else if (self.HumanPlayer.RightHand.HandCount == 0 && (self.HumanPlayer.LeftHand.HandCount % 2) == 0) {
        [self.SplitButton setEnabled:YES];
        [self.SplitButton setBackgroundColor:[UIColor clearColor]];
    } else {
        [self.SplitButton setEnabled:NO];
        [self.SplitButton setBackgroundColor:[UIColor redColor]];
    }
}

- (void)updateLabels {
    self.ComputerLeftLabel.text = [NSString stringWithFormat:@"%d", self.ComputerPlayer.LeftHand.HandCount];
    self.ComputerRightLabel.text = [NSString stringWithFormat:@"%d", self.ComputerPlayer.RightHand.HandCount];
    self.HumanLeftLabel.text = [NSString stringWithFormat:@"%d", self.HumanPlayer.LeftHand.HandCount];
    self.HumanRightLabel.text = [NSString stringWithFormat:@"%d", self.HumanPlayer.RightHand.HandCount];
}
@end

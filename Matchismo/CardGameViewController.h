//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Ryan Jadhav on 11/27/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"

@interface CardGameViewController : UIViewController

- (PlayingCardDeck *)createDeck;

@end

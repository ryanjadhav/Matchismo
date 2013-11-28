//
//  Deck.h
//  Matchismo
//
//  Created by Ryan Jadhav on 11/28/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end

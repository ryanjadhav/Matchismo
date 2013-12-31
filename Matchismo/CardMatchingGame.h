//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ryan Jadhav on 12/14/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)resetScore;
- (void)setNumberOfCardsToTwo;
- (void)setNumberOfCardsToThree;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;
@property (nonatomic, strong) NSString *statusMessage;

@end

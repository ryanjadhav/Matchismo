//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ryan Jadhav on 12/14/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSUInteger numberOfCardsToMatch;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSUInteger)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) [self setNumberOfCardsToTwo];
    return _numberOfCardsToMatch;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                // build array of all chosen cards
                if (otherCard.isChosen && !otherCard.isMatched && otherCards.count < self.numberOfCardsToMatch) {
                    [otherCards addObject:otherCard];
                }
                
                // if the array is of the size of the match determine if theres a winner
                if (otherCards.count == (self.numberOfCardsToMatch - 1)) {
                    int matchScore = [card match:otherCards];
                    if (matchScore) {
                        NSInteger points = matchScore * MATCH_BONUS;
                        self.score += points;
                        self.statusMessage = [NSString stringWithFormat:@"Matched for %d points", points];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *cards in otherCards) {
                            cards.chosen = NO;
                        }
                        self.statusMessage = [NSString stringWithFormat:@"Mismatched for -%d points", MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)resetScore
{
    self.score = 0;
}

- (void)setNumberOfCardsToTwo
{
    self.numberOfCardsToMatch = 2;
}

- (void)setNumberOfCardsToThree
{
    self.numberOfCardsToMatch = 3;
}

- (instancetype)init
{
    return nil;
}

@end

//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ryan Jadhav on 11/28/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;

    for (PlayingCard *otherCard in otherCards) {
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
            self.matched = YES;
            otherCard.matched = YES;    
        } else if (self.rank == otherCard.rank) {
            score = 4;
            self.matched = YES;
            otherCard.matched = YES;
        }
    }
    
    return score;
}

- (NSString *) contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // we provide getter and setter

+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}


+ (NSArray *) rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end

//
//  Card.m
//  Matchismo
//
//  Created by Ryan Jadhav on 11/28/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end

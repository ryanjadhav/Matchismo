//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ryan Jadhav on 11/28/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end

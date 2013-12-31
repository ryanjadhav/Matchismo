//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ryan Jadhav on 11/27/13.
//  Copyright (c) 2013 Ryan Jadhav. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeControl;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [self createGame];
    return _game;
}

- (PlayingCardDeck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]];
}

- (IBAction)resetGame:(UIButton *)sender
{
    _game = [self createGame];
    [self.game resetScore];
    [self updateUI];
    self.gameModeControl.enabled = YES;
}

- (IBAction)setCardMatch:(UISegmentedControl *)sender
{
    [self reset];

    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    NSInteger segmentIndex = [segmentedControl selectedSegmentIndex];
    if (segmentIndex == 0) {
        [self.game setNumberOfCardsToTwo];
    } else if (segmentIndex == 1) {
        [self.game setNumberOfCardsToThree];
    }
    
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    self.gameModeControl.enabled = NO;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.statusLabel.text = self.game.statusMessage;
}

- (void)reset
{
    _game = [self createGame];
    [self.game resetScore];
    self.gameModeControl.enabled = YES;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end

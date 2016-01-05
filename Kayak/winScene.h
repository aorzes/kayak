//
//  fallScene.h
//  Kayak
//
//  Created by Anton Orzes on 31.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "GameScene.h"


@interface winScene : SKScene
{
    double ukupnoVrijeme;
    double najboljeVrijeme;
    NSInteger  brojKrugova;
    NSInteger  ukupnoNovaca;
    NSInteger novac;
    
    SKSpriteNode *newGame;
    SKSpriteNode *fbook;
    SKSpriteNode *twit;
    
}
@end

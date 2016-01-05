//
//  GameScene.m
//  Kayak
//
//  Created by Anton Orzes on 20.12.2015..
//  Copyright (c) 2015. Anton Orzes. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    aionoff = [defaults boolForKey:@"aionoff"];
    enduranceOn = [defaults boolForKey:@"enduranceOn"];
    brojKrugova = [defaults integerForKey:@"brojKrugova"];
    if(brojKrugova == 0)
    {
        brojKrugova =3;
        aionoff = YES;
        enduranceOn = NO;
    }
}

-(void)SaveGame {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:aionoff forKey:@"aionoff"];
    [defaults setBool:enduranceOn forKey:@"enduranceOn"];
    [defaults setInteger:brojKrugova forKey:@"brojKrugova"];
    [defaults synchronize];
}





-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   
    float razmak = 55;
    
    [self LoadGame];
    
    
    
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"uvodna"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"podloga";
    podloga.zPosition=0;
    [self addChild:podloga];
    
    
    SKShapeNode *bijelo = [SKShapeNode shapeNodeWithRect:CGRectMake(30, 30, self.size.width/3+30, self.size.height-50)];
    bijelo.fillColor = [UIColor whiteColor];
    bijelo.alpha=0.3;
    bijelo.name = @"bijelo";
    bijelo.zPosition=1;
    [self addChild:bijelo];
    
    SKSpriteNode *quick = [SKSpriteNode spriteNodeWithImageNamed:@"startGame"];
    quick.size = CGSizeMake(self.size.width/3, 50);
    quick.position = CGPointMake(100, self.size.height - razmak-30);
    quick.name = @"quick";
    quick.zPosition=2;
    [self addChild:quick];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(quick.position.x+quick.size.width + 10, razmak+30)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner];
    
    aiOnOff = [SKSpriteNode spriteNodeWithImageNamed:@"aiOn"];
    aiOnOff.size = CGSizeMake(self.size.width/3, 50);
    aiOnOff.position = CGPointMake(100, quick.position.y-razmak);
    aiOnOff.name = @"aiOnOff";
    aiOnOff.zPosition=2;
    [self addChild:aiOnOff];
    if (aionoff) {
        aiOnOff.texture = [SKTexture textureWithImageNamed:@"aiOn"];
    }
    else{
        aiOnOff.texture = [SKTexture textureWithImageNamed:@"aiOff"];
    }

    
    SKSpriteNode *timePerLap = [SKSpriteNode spriteNodeWithImageNamed:@"timePerLap"];
    timePerLap.size = CGSizeMake(self.size.width/3, 50);
    timePerLap.position = CGPointMake(100, aiOnOff.position.y-razmak);
    timePerLap.name = @"timePerLap";
    timePerLap.zPosition=2;
    [self addChild:timePerLap];
    
    endurance = [SKSpriteNode spriteNodeWithImageNamed:@"endurance"];
    endurance.size = CGSizeMake(self.size.width/3, 50);
    endurance.position = CGPointMake(100, timePerLap.position.y-razmak);
    endurance.name = @"endurance";
    endurance.zPosition=2;
    [self addChild:endurance];
    if (enduranceOn) {
        endurance.texture = [SKTexture textureWithImageNamed:@"enduranceOn"];
    }
    else{
        endurance.texture = [SKTexture textureWithImageNamed:@"endurance"];
    }

    
    SKSpriteNode *selectMap = [SKSpriteNode spriteNodeWithImageNamed:@"selectMap"];
    selectMap.size = CGSizeMake(self.size.width/3, 50);
    selectMap.position = CGPointMake(100, endurance.position.y-razmak);
    selectMap.name = @"selectMap";
    selectMap.zPosition=2;
    [self addChild:selectMap];
    
    SKSpriteNode *selectK = [SKSpriteNode spriteNodeWithImageNamed:@"selectKayak"];
    selectK.size = CGSizeMake(self.size.width/3, 50);
    selectK.position = CGPointMake(100, selectMap.position.y-razmak);
    selectK.name = @"selectK";
    selectK.zPosition=2;
    [self addChild:selectK];
    
    SKSpriteNode *leadreB = [SKSpriteNode spriteNodeWithImageNamed:@"leaderboard"];
    leadreB.size = CGSizeMake(self.size.width/3, 50);
    leadreB.position = CGPointMake(100, selectK.position.y-razmak);
    leadreB.name = @"leaderboard";
    leadreB.zPosition=2;
    [self addChild:leadreB];
    
    osovina = [SKShapeNode shapeNodeWithCircleOfRadius:2];
    osovina.fillColor = [UIColor whiteColor];
    osovina.position = CGPointMake(timePerLap.position.x+timePerLap.size.width/2+10, timePerLap.position.y);
    osovina.name = @"osovina";
    osovina.zPosition=0;
    [self addChild:osovina];
    
    SKSpriteNode *poluga = [SKSpriteNode spriteNodeWithImageNamed:@"poluga"];
    poluga.size = CGSizeMake(self.size.width/3, 30);
    poluga.anchorPoint =CGPointMake(0.0, 0.5);
    poluga.position = CGPointMake(0, 0);
    poluga.name = @"poluga";
    poluga.zPosition=3;
    [osovina addChild:poluga];
    
    
    SKSpriteNode *Lap1 = [SKSpriteNode spriteNodeWithImageNamed:@"1lap"];
    Lap1.size = CGSizeMake(self.size.width/3, 40);
    Lap1.position = CGPointMake(self.size.width-20, timePerLap.position.y+80);
    Lap1.name = @"1lap";
    Lap1.zPosition=4;
    [self addChild:Lap1];
   
    SKSpriteNode *Lap2 = [SKSpriteNode spriteNodeWithImageNamed:@"2lap"];
    Lap2.size = CGSizeMake(self.size.width/3, 40);
    Lap2.position = CGPointMake(self.size.width-20, timePerLap.position.y+40);
    Lap2.name = @"2lap";
    Lap2.zPosition=4;
    [self addChild:Lap2];
    
    SKSpriteNode *Lap3 = [SKSpriteNode spriteNodeWithImageNamed:@"3lap"];
    Lap3.size = CGSizeMake(self.size.width/3, 40);
    Lap3.position = CGPointMake(self.size.width-20, timePerLap.position.y);
    Lap3.name = @"3lap";
    Lap3.zPosition=4;
    [self addChild:Lap3];
    
    SKSpriteNode *Lap4 = [SKSpriteNode spriteNodeWithImageNamed:@"5lap"];
    Lap4.size = CGSizeMake(self.size.width/3, 40);
    Lap4.position = CGPointMake(self.size.width-20, timePerLap.position.y-40);
    Lap4.name = @"4lap";
    Lap4.zPosition=4;
    [self addChild:Lap4];
    
    SKSpriteNode *Lap5 = [SKSpriteNode spriteNodeWithImageNamed:@"10lap"];
    Lap5.size = CGSizeMake(self.size.width/3, 40);
    Lap5.position = CGPointMake(self.size.width-20, timePerLap.position.y-80);
    Lap5.name = @"5lap";
    Lap5.zPosition=4;
    [self addChild:Lap5];

    SKSpriteNode *node = Lap1;
    switch (brojKrugova) {
        case 1:
            node = Lap1;
            break;
        case 2:
            node = Lap2;
            break;
        case 3:
            node = Lap3;
            break;
        case 5:
            node = Lap4;
            break;
        case 10:
            node = Lap5;
            break;
            
        default:
            node = Lap3;
            break;
    }
    
    CGFloat kut = atan2f(osovina.position.y-node.position.y, osovina.position.x-node.position.x+50)+M_PI;
    SKAction *rotiraj = [SKAction rotateToAngle:kut duration:0.2 shortestUnitArc:YES];
    [osovina runAction:rotiraj];

    SKShapeNode *bijelo2 = [SKShapeNode shapeNodeWithRect:CGRectMake(Lap5.position.x-Lap5.size.width/2-10, Lap5.position.y-30, 70, Lap1.position.y - Lap5.position.y + 80)];
    bijelo2.fillColor = [UIColor whiteColor];
    bijelo2.alpha=0.3;
    bijelo2.name = @"bijelo";
    bijelo2.zPosition=1;
    [self addChild:bijelo2];
    
    [[gameCenterFiles sharedInstance]authenticateLocalUser];
    
    
}


- (void)showLeaderboardOnViewController:(UIViewController*)viewController
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != nil) {
        gameCenterController.gameCenterDelegate = self;
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.leaderboardIdentifier = @"maxScore";
        
        [viewController presentViewController: gameCenterController animated: YES completion:nil];
    }
}




- (void) presentLeaderboards {
    GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
    gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
    gameCenterController.gameCenterDelegate = self;
    
    UIViewController *vc=self.view.window.rootViewController;
    [vc presentViewController:gameCenterController animated:YES completion:nil];
    
    
}




- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)reportScore{
    
    GKScore *highScoreS = [[GKScore alloc]initWithLeaderboardIdentifier:@"maxScore"];
    // highScoreS.value = maxScore;
    
    [GKScore reportScores:@[highScoreS] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}



-(void) pokreniPrviLevel{

    SKScene *igra = [[prvaScena alloc]initWithSize:self.size];
    SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
    [self.view presentScene:igra transition:tranzicija];
    [spinner stopAnimating];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if ([node.name isEqualToString:@"quick"]) {
            
            [spinner startAnimating];
            SKAction *pokC=[SKAction waitForDuration:0.1];
            SKAction *pokL = [SKAction performSelector: @selector(pokreniPrviLevel) onTarget:(self)];
            [self runAction:[SKAction sequence:@[pokC,pokL]]];
            
            
        }
        
        if ([node.name isEqualToString:@"selectMap"]) {
            SKScene *igra = [[izbornikScene alloc]initWithSize:self.size];
            igra.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
            [self.view presentScene:igra transition:tranzicija];
            
        }


        if ([node.name isEqualToString:@"selectK"]) {
            SKScene *igra = [[izbornikKajaka alloc]initWithSize:self.size];
            igra.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
            [self.view presentScene:igra transition:tranzicija];
            
        }
        if ([node.name isEqualToString:@"1lap"] || [node.name isEqualToString:@"2lap"] || [node.name isEqualToString:@"3lap"] || [node.name isEqualToString:@"4lap"] || [node.name isEqualToString:@"5lap"])
        {
            
            CGFloat kut = atan2f(osovina.position.y-node.position.y, osovina.position.x-node.position.x+50)+M_PI;
            SKAction *rotiraj = [SKAction rotateToAngle:kut duration:0.2 shortestUnitArc:YES];
            [osovina runAction:rotiraj];
            if ([node.name isEqualToString:@"1lap"]) {brojKrugova = 1;}
            if ([node.name isEqualToString:@"2lap"]) {brojKrugova = 2;}
            if ([node.name isEqualToString:@"3lap"]) {brojKrugova = 3;}
            if ([node.name isEqualToString:@"4lap"]) {brojKrugova = 5;}
            if ([node.name isEqualToString:@"5lap"]) {brojKrugova = 10;}

        }
        if ([node.name isEqualToString:@"aiOnOff"]) {
            
            aionoff = !aionoff;
            if (aionoff) {
                aiOnOff.texture = [SKTexture textureWithImageNamed:@"aiOn"];
            }
            else{
                aiOnOff.texture = [SKTexture textureWithImageNamed:@"aiOff"];
            }
            
        }
        if ([node.name isEqualToString:@"endurance"]) {
            
            enduranceOn = !enduranceOn;
            if (enduranceOn) {
                endurance.texture = [SKTexture textureWithImageNamed:@"enduranceOn"];
            }
            else{
                endurance.texture = [SKTexture textureWithImageNamed:@"endurance"];
            }
            
        }




    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self SaveGame];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

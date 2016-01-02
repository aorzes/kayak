//
//  fallScene.m
//  Kayak
//
//  Created by Anton Orzes on 31.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import "winScene.h"
#import "prvaScena.h"

@implementation winScene


-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ukupnoVrijeme = [defaults floatForKey:@"ukupnoVrijeme"];
    brojKrugova = [defaults integerForKey:@"brojKrugova"];
    
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    [self LoadGame];
    
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"winPodloga"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"podloga";
    podloga.zPosition=0;
    [self addChild:podloga];
    
    SKSpriteNode *newGame = [SKSpriteNode spriteNodeWithImageNamed:@"newGame"];
    newGame.size = CGSizeMake(self.size.width/3, 50);
    newGame.position = CGPointMake(self.size.width/2, self.size.height - 80);
    newGame.name = @"start";
    newGame.zPosition=2;
    [self addChild:newGame];

    SKSpriteNode *pehar = [SKSpriteNode spriteNodeWithImageNamed:@"pehar"];
    pehar.size = CGSizeMake(100, 150);
    pehar.position = CGPointMake(self.size.width/2, 80);
    pehar.name = @"pehar";
    pehar.zPosition=2;
    [self addChild:pehar];
    
    SKLabelNode *vrijemeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    vrijemeLabel.text=[NSString stringWithFormat:@"Time: %.2f",ukupnoVrijeme];
    vrijemeLabel.fontSize = 16;
    vrijemeLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-120);
    vrijemeLabel.zPosition=3;
    [self addChild:vrijemeLabel];
    
    SKLabelNode *lapsLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    lapsLabel.text=[NSString stringWithFormat:@"Lap: %ld",(long)brojKrugova];
    lapsLabel.fontSize = 16;
    lapsLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-140);
    lapsLabel.zPosition=3;
    [self addChild:lapsLabel];

    
    SKLabelNode *pokruguLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pokruguLabel.text=[NSString stringWithFormat:@"Per lap: %.2f",ukupnoVrijeme/brojKrugova];
    pokruguLabel.fontSize = 16;
    pokruguLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-160);
    pokruguLabel.zPosition=3;
    [self addChild:pokruguLabel];
    
   }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
                
        if ([node.name isEqualToString:@"start"]) {
            
            SKScene *igra = [[GameScene alloc]initWithSize:self.size];
            igra.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
            [self.view presentScene:igra transition:tranzicija];
            
        }
    }
}

@end

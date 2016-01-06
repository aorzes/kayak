//
//  fallScene.m
//  Kayak
//
//  Created by Anton Orzes on 31.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import "fallScene.h"

@implementation fallScene


-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    a = [defaults floatForKey:@"akrug"];
    enduranceOn = [defaults boolForKey:@"enduranceOn"];
    novac = [defaults integerForKey:@"novac"];
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    [self LoadGame];
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"fallPodloga"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"podloga";
    podloga.zPosition=0;
    [self addChild:podloga];
    
    
    SKSpriteNode *quick = [SKSpriteNode spriteNodeWithImageNamed:@"newGame"];
    quick.size = CGSizeMake(self.size.width/3, 50);
    quick.position = CGPointMake(self.size.width/2, self.size.height - 70);
    quick.name = @"start";
    quick.zPosition=2;
    [self addChild:quick];
    if (enduranceOn) {
        SKLabelNode *brojKrugovaLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        brojKrugovaLabel.text=[NSString stringWithFormat:@"Laps: %.2f",a/(2*M_PI)];
        brojKrugovaLabel.fontSize = 16;
        brojKrugovaLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-120);
        brojKrugovaLabel.zPosition=3;
        [self addChild:brojKrugovaLabel];
        
        SKLabelNode *novacLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        novacLabel.text=[NSString stringWithFormat:@"Money: %ld $",(long)novac];
        novacLabel.fontSize = 16;
        novacLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-150);
        novacLabel.zPosition=3;
        [self addChild:novacLabel];

    }
        
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

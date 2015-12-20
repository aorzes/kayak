//
//  GameScene.m
//  Kayak
//
//  Created by Anton Orzes on 20.12.2015..
//  Copyright (c) 2015. Anton Orzes. All rights reserved.
//

#import "GameScene.h"
#import "igraScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
   
    
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"uvodna"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"start";
    podloga.zPosition=1;
    [self addChild:podloga];
    
    SKSpriteNode *tipka = [SKSpriteNode spriteNodeWithImageNamed:@"start"];
    tipka.size = CGSizeMake(self.size.width/2, 100);
    tipka.position = CGPointMake(self.size.width/2, self.size.height - 100);
    tipka.name = @"start";
    tipka.zPosition=2;
    [self addChild:tipka];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        if ([node.name isEqualToString:@"start"]) {
            SKScene *igra = [[igraScene alloc]initWithSize:self.size];
            igra.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
            [self.view presentScene:igra transition:tranzicija];
            
        }

    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end

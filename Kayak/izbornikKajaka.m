//
//  izbornikKajaka.m
//  Kayak
//
//  Created by Anton Orzes on 04.01.2016..
//  Copyright © 2016. Anton Orzes. All rights reserved.
//

#import "izbornikKajaka.h"

@implementation izbornikKajaka

-(void)SaveGame {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:bojaKajaka forKey:@"bojaKajaka"];
    [defaults synchronize];
    
}

-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bojaKajaka = [defaults integerForKey:@"bojaKajaka"];
}


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    [self LoadGame];
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"voda4"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"podloga";
    podloga.zPosition=0;
    [self addChild:podloga];
    
    
    SKSpriteNode *quick = [SKSpriteNode spriteNodeWithImageNamed:@"back"];
    quick.size = CGSizeMake(self.size.width/3, 50);
    quick.position = CGPointMake(self.size.width/2, self.size.height - 70);
    quick.name = @"back";
    quick.zPosition=2;
    [self addChild:quick];
    
    NSArray *popisIkona = @[@"kayakRed", @"kayakBlue", @"kayakYellow", @"kayakCyan", @"kayakGreen", @"kayakPurple", @"kayakWhite", @"kayakBlack"];
    
    float velicina = (self.size.height - 200) / 7;
    float polozaj = self.size.height - 120;
    for (int i=0; i<8; i++) {
        SKSpriteNode *okvir = [SKSpriteNode spriteNodeWithImageNamed:@"iOkvir"];
        okvir.size = CGSizeMake(self.size.width/2, velicina-10);
        okvir.position = CGPointMake(self.size.width/2, polozaj);
        okvir.name = [NSString stringWithFormat:@"okvir%d",i];
        okvir.zPosition=3;
        [self addChild:okvir];
        
        SKSpriteNode *shadow = [SKSpriteNode spriteNodeWithImageNamed:@"iOkvir"];
        shadow.size = okvir.size;
        shadow.position = CGPointMake(self.size.width/2-5, polozaj-5);
        shadow.blendMode = SKBlendModeAlpha;
        shadow.colorBlendFactor = 1;
        shadow.color = [SKColor blackColor];
        shadow.zPosition=2;
        shadow.alpha = .25;
        [self addChild:shadow];
        
        polozaj -= velicina;
        
        SKSpriteNode *ikona = [SKSpriteNode spriteNodeWithImageNamed:popisIkona[i]];
        ikona.size = CGSizeMake(25, 100);
        ikona.position = CGPointMake(-20, 0);
        ikona.zRotation = M_PI_2;
        ikona.name = @"ikona";
        ikona.zPosition=0;
        [okvir addChild:ikona];
        
        SKSpriteNode *shadow2 = [SKSpriteNode spriteNodeWithImageNamed:popisIkona[i]];
        shadow2.size = ikona.size;
        shadow2.position = CGPointMake(-25, -5);
        shadow2.blendMode = SKBlendModeAlpha;
        shadow2.colorBlendFactor = 1;
        shadow2.color = [SKColor blackColor];
        shadow2.zPosition=-1;
        shadow2.zRotation = M_PI_2;
        shadow2.alpha = .25;
        [okvir addChild:shadow2];
        
        SKSpriteNode *check = [SKSpriteNode spriteNodeWithImageNamed:@"check"];
        check.size = CGSizeMake(25, 25);
        check.position = CGPointMake(okvir.size.width/2-30, 0);
        check.name = @"check";
        check.alpha =0;
        if(bojaKajaka == i) {check.alpha =1;}else{check.alpha =0;}
        check.zPosition=2;
        [okvir addChild:check];
        
    }
    NSURL *playPlop = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"plop" ofType:@"mp3"]];
    plopSounds = [[AVAudioPlayer alloc]initWithContentsOfURL:playPlop error:nil];
    plopSounds.volume = 0.8;
    [plopSounds prepareToPlay];
    
}

-(void) obrisiCheck:(SKNode *)mnod{
    
    for( SKNode *cnod in self.children)
    {
        NSString *ostatak = [cnod.name substringToIndex: [cnod.name length] - 1];
        if ([ostatak isEqualToString:@"okvir"]) {
            for(SKNode *dnod in cnod.children)
            {
                if ([dnod.name isEqualToString: @"check"]) {
                    dnod.alpha = 0;
                }
                
            }
            
        }
        
    }
    for( SKNode *cnod in mnod.children)
    {
        if ([cnod.name isEqualToString:@"check"]) {
            cnod.alpha = 1;
        }
        
    }
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [plopSounds play];
    for (UITouch *touch in touches) {
        CGPoint p = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:p];
        
        if ([node.name isEqualToString:@"back"]) {
            SKScene *igra = [[GameScene alloc]initWithSize:self.size];
            igra.scaleMode = SKSceneScaleModeAspectFill;
            SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
            [self.view presentScene:igra transition:tranzicija];
        }
        
        if ([node.name isEqualToString:@"okvir0"]) {
            bojaKajaka = 0;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir1"]) {
            bojaKajaka = 1;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir2"]) {
            bojaKajaka = 2;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir3"]) {
            bojaKajaka = 3;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir4"]) {
            bojaKajaka = 4;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir5"]) {
            bojaKajaka = 5;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir6"]) {
            bojaKajaka = 6;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir7"]) {
            bojaKajaka = 7;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        
        
    }
}


@end

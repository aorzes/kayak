//
//  fallScene.m
//  Kayak
//
//  Created by Anton Orzes on 31.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import "izbornikScene.h"

@implementation izbornikScene

-(void)SaveGame {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:mapa forKey:@"mapa"];
    [defaults synchronize];
    
}
-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    mapa = [defaults integerForKey:@"mapa"];
    ukupnoNovaca =[defaults integerForKey:@"ukupnoNovaca"];
    
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
    
    SKLabelNode *ukupnoLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    ukupnoLabel.text=[NSString stringWithFormat:@"Total money: %ld$",(long)ukupnoNovaca];
    ukupnoLabel.fontSize = 16;
    ukupnoLabel.position = CGPointMake(self.size.width/2, quick.position.y-40);
    ukupnoLabel.zPosition=3;
    [self addChild:ukupnoLabel];
    
    NSArray *popisIkona = @[@"staza1ico", @"staza2ico", @"staza3ico", @"staza4ico", @"staza5ico"];
    
    float velicina = (self.size.height - 200) / 5;
    float polozaj = self.size.height - 150;
    for (int i=0; i<5; i++) {
        SKSpriteNode *okvir = [SKSpriteNode spriteNodeWithImageNamed:@"iOkvir"];
        okvir.size = CGSizeMake(self.size.width/3, velicina-10);
        okvir.position = CGPointMake(self.size.width/2, polozaj);
        polozaj -= velicina;
        okvir.name = [NSString stringWithFormat:@"okvir%d",i];
        okvir.zPosition=3;
        [self addChild:okvir];
        
        SKSpriteNode *ikona = [SKSpriteNode spriteNodeWithImageNamed:popisIkona[i]];
        ikona.size = CGSizeMake(okvir.size.width/2, okvir.size.height-10);
        ikona.position = CGPointMake(-20, 0);
        ikona.name = @"ikona";
        ikona.zPosition=-1;
        [okvir addChild:ikona];
        
        SKSpriteNode *check = [SKSpriteNode spriteNodeWithImageNamed:@"check"];
        check.size = CGSizeMake(25, 25);
        check.position = CGPointMake(okvir.size.width/2-30, 0);
        check.name = @"check";
        check.alpha =0;
        if(mapa == i) {check.alpha =1;}else{check.alpha =0;}
        check.zPosition=2;
        [okvir addChild:check];
        
        SKSpriteNode *lokot = [SKSpriteNode spriteNodeWithImageNamed:@"lokot"];
        lokot.size = CGSizeMake(25, 25);
        lokot.position = CGPointMake(okvir.size.width/2-30, 0);
        lokot.name = @"lokot";
        lokot.alpha =1;
        if(mapa == 1) {lokot.alpha =0;}else{lokot.alpha =1;}
        if (ukupnoNovaca>=i*150) {
            lokot.alpha =0;
        }
        else
        {
            lokot.alpha =1;
        }
        lokot.zPosition=2;
        [okvir addChild:lokot];
        
        SKLabelNode *cijenaLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        cijenaLabel.text=[NSString stringWithFormat:@"%d$",i*150];
        cijenaLabel.fontSize = 16;
        cijenaLabel.position = CGPointMake(0, -5);
        cijenaLabel.zPosition=1;
        [lokot addChild:cijenaLabel];

        
    }
    
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
            mapa = 0;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir1"] && ukupnoNovaca>=150) {
            mapa = 1;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir2"] && ukupnoNovaca>=300) {
            mapa = 2;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir3"] && ukupnoNovaca>=450) {
            mapa = 3;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        if ([node.name isEqualToString:@"okvir4"] && ukupnoNovaca>=600) {
            mapa = 4;
            [self SaveGame];
            [self obrisiCheck:node];
        }
        
        
    }
}

@end

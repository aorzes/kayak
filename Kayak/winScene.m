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
    najboljeVrijeme = [defaults floatForKey:@"najboljeVrijeme"];
    brojKrugova = [defaults integerForKey:@"brojKrugova"];
    novac = [defaults integerForKey:@"novac"];
    ukupnoNovaca = [defaults integerForKey:@"ukupnoNovaca"];
}

-(void)SaveGame {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:najboljeVrijeme forKey:@"najboljeVrijeme"];
    [defaults synchronize];
    
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    [self LoadGame];
    UIColor *bojaNajboljeg = [UIColor redColor];
    UIColor *bojaNovog = [UIColor whiteColor];
    BOOL blinkaj = false;
    if (najboljeVrijeme==0 || ukupnoVrijeme/brojKrugova<najboljeVrijeme)
    {
        najboljeVrijeme = ukupnoVrijeme/brojKrugova;
        bojaNajboljeg = [UIColor whiteColor];
        bojaNovog = [UIColor redColor];
        [self SaveGame];
        blinkaj = true;
    }
    
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"winPodloga"];
    podloga.size = CGSizeMake(self.size.width, self.size.height);
    podloga.position = CGPointMake(self.size.width/2, self.size.height/2);
    podloga.name = @"podloga";
    podloga.zPosition=0;
    [self addChild:podloga];
    
    newGame = [SKSpriteNode spriteNodeWithImageNamed:@"newGame"];
    newGame.size = CGSizeMake(self.size.width/3, 50);
    newGame.position = CGPointMake(self.size.width/2, self.size.height - 80);
    newGame.name = @"start";
    newGame.zPosition=2;
    [self addChild:newGame];

    SKSpriteNode *pehar = [SKSpriteNode spriteNodeWithImageNamed:@"pehar"];
    pehar.size = CGSizeMake(100, 150);
    pehar.position = CGPointMake(self.size.width/2, 140);
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

    SKAction *povecaj = [SKAction scaleTo:1.5 duration:1.0];
    SKAction *smanji = [SKAction scaleTo:1.0 duration:0.5];
    SKAction *zajedno = [SKAction sequence:@[povecaj,smanji]];
    SKAction *ponavljaj = [SKAction repeatActionForever:zajedno];
    
    SKLabelNode *pokruguLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pokruguLabel.text=[NSString stringWithFormat:@"Per lap: %.2f",ukupnoVrijeme/brojKrugova];
    pokruguLabel.fontColor = bojaNovog;
    pokruguLabel.colorBlendFactor = 1;
    pokruguLabel.fontSize = 16;
    pokruguLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-160);
    pokruguLabel.zPosition=3;
    [self addChild:pokruguLabel];
    
    if (blinkaj) {
        [pokruguLabel runAction:ponavljaj];
    }
    
    SKLabelNode *novacLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    novacLabel.text=[NSString stringWithFormat:@"Money: %ld $",(long)novac];
    novacLabel.fontSize = 16;
    novacLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-180);
    novacLabel.zPosition=3;
    [self addChild:novacLabel];
    
    SKLabelNode *ukupnonovacLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    ukupnonovacLabel.text=[NSString stringWithFormat:@"Total money: %ld $",(long)ukupnoNovaca];
    ukupnonovacLabel.fontSize = 16;
    ukupnonovacLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-200);
    ukupnonovacLabel.zPosition=3;
    [self addChild:ukupnonovacLabel];
    
    SKLabelNode *najboljeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    najboljeLabel.text=[NSString stringWithFormat:@"Best time: %.2f",najboljeVrijeme];
    najboljeLabel.fontColor = bojaNajboljeg;
    najboljeLabel.colorBlendFactor = 1;
    najboljeLabel.fontSize = 16;
    najboljeLabel.position = CGPointMake(self.size.width/2, self.frame.size.height-220);
    najboljeLabel.zPosition=3;
    [self addChild:najboljeLabel];
    
    fbook = [SKSpriteNode spriteNodeWithImageNamed:@"Facebook"];
    fbook.size = CGSizeMake(45, 45);
    fbook.position = CGPointMake(60, 60);
    fbook.name = @"fbook";
    fbook.zPosition=2;
    [self addChild:fbook];
    
    twit = [SKSpriteNode spriteNodeWithImageNamed:@"twiter"];
    twit.size = CGSizeMake(45, 45);
    twit.position = CGPointMake(self.size.width - 60, 60);
    twit.name = @"twit";
    twit.zPosition=2;
    [self addChild:twit];
    
   }

-(UIImage*)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (void)facebookShare{
    
    UIImage *faceImage=[self snapshot];
    SLComposeViewController *mySLComposeSheet;
    mySLComposeSheet=[[SLComposeViewController alloc] init];
    mySLComposeSheet=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    //[mySLComposeSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/marble-magic/id903395615?l=hr&ls=1&mt=8"]];
    [mySLComposeSheet setInitialText:@""];
    [mySLComposeSheet addImage:faceImage];
    UIViewController *vc=self.view.window.rootViewController;
    [vc presentViewController: mySLComposeSheet animated:YES completion:NULL];
    
}
- (void)twitterShare{
    
    UIImage *twittImage=[self snapshot];
    SLComposeViewController *mySLComposeSheet;
    mySLComposeSheet=[[SLComposeViewController alloc] init];
    mySLComposeSheet=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    //[mySLComposeSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/highchicken/id835898711?mt=8"]];
    [mySLComposeSheet setInitialText:@""];
    [mySLComposeSheet addImage:twittImage];
    UIViewController *vc=self.view.window.rootViewController;
    [vc presentViewController: mySLComposeSheet animated:YES completion:NULL];
    
}
-(void)sakrij{
    newGame.alpha = 0;
    fbook.alpha = 0;
    twit.alpha = 0;


}

-(void)vrati{
    newGame.alpha = 1;
    fbook.alpha = 1;
    twit.alpha = 1;
    
    
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
        if ([node.name isEqualToString:@"fbook"]) {
            SKAction *makni = [SKAction sequence:@[[SKAction performSelector:@selector(sakrij) onTarget:self],[SKAction waitForDuration:0.05],
                    [SKAction performSelector:@selector(facebookShare) onTarget:self],[SKAction performSelector:@selector(vrati) onTarget:self]]];
            [self runAction:makni];
           
            
        }
        if ([node.name isEqualToString:@"twit"]) {
            
            SKAction *makni = [SKAction sequence:@[[SKAction performSelector:@selector(sakrij) onTarget:self],[SKAction waitForDuration:0.05],
                                                   [SKAction performSelector:@selector(twitterShare) onTarget:self],[SKAction performSelector:@selector(vrati) onTarget:self]]];
            [self runAction:makni];
            
        }

    }
}

@end

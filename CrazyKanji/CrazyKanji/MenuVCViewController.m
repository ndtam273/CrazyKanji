//
//  MenuVCViewController.m
//  CrazyKanji
//
//  Created by Nguyen Duc Tam on 7/14/14.
//  Copyright (c) 2014 FX. All rights reserved.
//

#import "MenuVCViewController.h"
#include <stdlib.h>
#import "AFViewShaker.h"

#import "GADBannerView.h"
#import "GADRequest.h"

#define ADMOB_ID @"ca-app-pub-6305511942273552/7596626226"

@interface MenuVCViewController (){
   
    // Main view
    __weak IBOutlet UIButton    *_btnSection60;
    __weak IBOutlet UIButton    *_btnSection70;
    __weak IBOutlet UIButton    *_btnPc1;
    __weak IBOutlet UIButton    *_btnN5;
    __weak IBOutlet UIView      *_mainView;
    __weak IBOutlet UILabel     *_lblMainBestScore;
    
    
    
    
    // Kanji View
    
   __weak IBOutlet UILabel   *_lblKanji;
   __weak IBOutlet UILabel   *_lblAmHan;
   __weak IBOutlet UIView    *_KanjiView;
   __weak IBOutlet UILabel   *_lblScore;
    
    __weak IBOutlet UIView   *_topTimeView;
    
    __weak IBOutlet UIButton *_btnRight;
    __weak IBOutlet UIButton *_btnWrong;
    
    
    //Game Over View
    
   __weak IBOutlet UIView    *_gameOverView;
   __weak IBOutlet UILabel   *_lblNewScore;
   __weak IBOutlet UILabel   *_lblBestScore;
    
    
    //Dictionary
    NSDictionary   *dict70Bo;
    NSDictionary   *dict60Chu;
    NSDictionary   *dictPC1;
    NSDictionary   *dicN2;
    NSInteger       section;
    
    // Check
    BOOL          isRight;
    BOOL          isFail;
    NSInteger     score;
    NSInteger     bestScore;

    
    BOOL _isLoadAdmob;
}

@property (weak, nonatomic) IBOutlet GADBannerView  *bannerView;

// Main View Action

- (IBAction)goSection60  :(id)sender;
- (IBAction)goSection70  :(id)sender;
- (IBAction)goSectionPC1 :(id)sender;
- (IBAction)goN2         :(id)sender;

// Kanji View Action
- (IBAction)right:(id)sender;
- (IBAction)wrong:(id)sender;

// GameOver View Action

- (IBAction)replay  :(id)sender;
- (IBAction)training:(id)sender;

@end

@implementation MenuVCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // get best score from NSUserDefault
    NSUserDefaults *prefs  = [NSUserDefaults standardUserDefaults];
	bestScore              = [prefs integerForKey:@"bestScore"];
    _lblMainBestScore.text = [NSString stringWithFormat:@"%ld",(long)bestScore];
    [self configView];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // get best score from NSUserDefault
    NSUserDefaults *prefs    = [NSUserDefaults standardUserDefaults];
	bestScore                = [prefs integerForKey:@"bestScore"];
    _lblMainBestScore.text   = [NSString stringWithFormat:@"%ld",(long)bestScore];
    
     NSLog (@"best score: %ld",(long)bestScore);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action

//  go to 60 basic kanji
- (IBAction)goSection60:(id)sender {
    section = 2;
    [self.view bringSubviewToFront:_KanjiView];
    [self nextScreenWithDict:dict60Chu];
}

// go to 70 kanji element
- (IBAction)goSection70:(id)sender {
    section = 1;
    [self.view bringSubviewToFront:_KanjiView];
    [self nextScreenWithDict:dict70Bo];
}

// go to pc kanji set
- (IBAction)goSectionPC1:(id)sender {
    section = 3;
    [self.view bringSubviewToFront:_KanjiView];
    [self nextScreenWithDict:dictPC1];
}

// to to N2 kanji set
- (IBAction)goN2:(id)sender {
    section = 4;
    [self.view bringSubviewToFront:_KanjiView];
    [self nextScreenWithDict:dicN2];
}

// choose right
- (IBAction)right:(id)sender {
    
    if(isRight == YES) {
        
        isFail  = NO;
        
    }
    else {
        
        isFail = YES;
        
    }
    [_btnWrong setEnabled:YES];
    [_btnRight setEnabled:NO];
}

// choose wrong
- (IBAction)wrong:(id)sender {
   
    if (isRight == NO) {
        
        isFail = NO;
        
    }
    else {
       
        isFail = YES;
        
    }
    [_btnWrong setEnabled:NO];
    [_btnRight setEnabled:YES];
}

// replay game
- (IBAction)replay:(id)sender{
    _gameOverView.hidden = YES;
    [self.view bringSubviewToFront:_mainView];
    score                     =  0;
    _lblScore.text            = [NSString stringWithFormat:@"%ld",(long)score];
}

// training , not implement yet
- (IBAction)training:(id)sender {
    _gameOverView.hidden = YES;
}

#pragma mark - Method 


// show gameView
- (void)topViewshow {
    [UIView animateWithDuration:2.0 animations:^{
        // animation code block
        
        _topTimeView.frame  = CGRectMake(0, 0, 320, 5);
        
        
    } completion:^(BOOL finished) {
        if (isFail == YES) {
            [self overGame];
        }
        else {
            if (section == 1) {
                [self nextScreenWithDict:dict70Bo];
            }
            else if (section == 2) {
                [self nextScreenWithDict:dict60Chu];
            }
            else if (section == 3) {
                [self nextScreenWithDict:dictPC1];
            }
            else if (section == 4) {
                [self nextScreenWithDict:dicN2];
            }
            score++;
            _lblScore.text            = [NSString stringWithFormat:@"%ld",(long)score];

        }
        
    }
     ];
}





// ultinity function for viewWillAppear

- (void) configView {
   
    
   
    
    _gameOverView.hidden              = YES;
    _gameOverView.layer.cornerRadius  = 10.0;
    _gameOverView.layer.masksToBounds = NO;
    _gameOverView.layer.borderWidth   = 1.0;
    
    
    score                     =  0;
    _lblScore.text            = [NSString stringWithFormat:@"%ld",(long)score];
   
    NSString *plistPath       = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    dict70Bo                  = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSString *plistPath1      = [[NSBundle mainBundle] pathForResource:@"Data1" ofType:@"plist"];
    dict60Chu                 = [NSDictionary dictionaryWithContentsOfFile:plistPath1];
    
    NSString *plistPath2      = [[NSBundle mainBundle] pathForResource:@"Data2" ofType:@"plist"];
    dictPC1                   = [NSDictionary dictionaryWithContentsOfFile:plistPath2];
    
    NSString *plistPath3      = [[NSBundle mainBundle] pathForResource:@"N2List" ofType:@"plist"];
    dicN2                     = [NSDictionary dictionaryWithContentsOfFile:plistPath3];
    
    
    
    //ADMOD
    //load ADMOB
    self.bannerView.delegate            = self;
    self.bannerView.adUnitID            = ADMOB_ID;
    self.bannerView.rootViewController  = self;
    
    GADRequest *request                 = [GADRequest request];
    //request.testDevices                 = @[ GAD_SIMULATOR_ID];
    [self.bannerView loadRequest:request];
    
}

// show next gameView
- (void) nextScreenWithDict:(NSDictionary*) dict {
    
    isFail = YES;
    [_btnWrong setEnabled:YES];
    [_btnRight setEnabled:YES];
    //Animation View
    _topTimeView.frame = CGRectMake(-320, 0, 320, 5);
    
    
    // animation
    
    
      [self topViewshow];
   
   
   
    
    
    // random kanji

    NSArray *kanjiArray = [dict allKeys];
   int random           = arc4random() % kanjiArray.count;
    _lblKanji.text      = kanjiArray[random];
    
    // random background Color
    
    CGFloat hue        = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color     = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
   
    _KanjiView.backgroundColor = color;
    
    // random Am Han
    NSArray *amhanArray = [dict allValues];
    int random1         = arc4random()%6;
   
    // if right
    if (random1 == 0  || random1 == 4 || random == 2) {
        _lblAmHan.text = [amhanArray objectAtIndex:random];
               isRight = YES;
    }
    else {
        int random2    = arc4random()%amhanArray.count;
        _lblAmHan.text = [amhanArray objectAtIndex:random2];
        if(_lblAmHan.text == [amhanArray objectAtIndex:random]) {
            isRight = YES;
        }
        else {
            isRight = NO;
        }
        
    }
    
    
    
        
   
}

// Game over
- (void) overGame {
   
    
    AFViewShaker *viewShaker  = [[AFViewShaker alloc] initWithView:self.view];
    [viewShaker shake];
    [self bestScore];
    _lblNewScore.text             = [NSString stringWithFormat:@"%ld",(long)score];
    _lblBestScore.text            = [NSString stringWithFormat:@"%ld",(long)bestScore];
    _lblMainBestScore.text        = [NSString stringWithFormat:@"%ld",(long)bestScore];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:bestScore forKey:@"bestScore"];
    _lblMainBestScore.text        = [NSString stringWithFormat:@"%ld",(long)bestScore];
       NSLog(@"best score: %ld",(long)bestScore);
    
    _gameOverView.hidden      = NO;
    [_btnRight setEnabled:NO];
    [_btnWrong setEnabled:NO];
   
   
    
}

// Show best score
- (void) bestScore {
    
    if (score > bestScore){
        bestScore = score;
       
    }
    
}

// ???
- (void) runtime {
    
}




#pragma mark - ADMOB
- (void)adViewDidReceiveAd:(GADBannerView *)view;
{
}
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
}

@end

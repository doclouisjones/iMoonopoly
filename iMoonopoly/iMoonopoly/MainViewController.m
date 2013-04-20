//
//  MainViewController.m
//  iMoonopoly
//
//  Created by Luigi Castiglione on 20/04/2013.
//  Copyright (c) 2013 Luigi Castiglione. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


//VIEWS
UIView *startView;
    UIButton *newGameButton;
    UIButton *continueGameButton;
    UIButton *creditsButton;
    UILabel *verLabel;
UIView *playerInfoView;
    UITextField *playerNameField;
    UITextField *playerConpanyNameField;
    UITextField *playerLocationField;
    UIButton *playerInfoNextButton;
    UIButton *playerInfoPreviousButton;
UIView *locationSelectView;
    NSArray *locationButtons;
    UIButton *locationInfoNextButton;
    UIButton *locationInfoPreviousButton;
UIView *creditsView;
    UITextField *creditsInfo;
UIView *gameView;



//
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

- (void)viewDidLoad
{
    //
    float myH = self.view.bounds.size.width;    //?!
    float myW = self.view.bounds.size.height;   //?!
    NSLog(@" %f", myW);
    
    //BUILD SUBVIEWS
    
    //StarView
    startView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *startViewbackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/background_StartView"]];
    [startViewbackground setFrame:CGRectMake(0, 0, myW, myH)];
    [startView addSubview:startViewbackground];
    //Buttons
    float startViewButtonW = 200;
    float startViewButtonH = 30;
    //
    newGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [newGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, 40, startViewButtonW, startViewButtonH)];
    [newGameButton setTitle:NSLocalizedString(@"L_newGame", @"New Game") forState:UIControlStateNormal];
	[newGameButton addTarget:self action:@selector(TBD) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:newGameButton];
    //
    continueGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [continueGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, 80, startViewButtonW, startViewButtonH)];
    [continueGameButton setTitle:NSLocalizedString(@"L_continueGame", @"Continue Game") forState:UIControlStateNormal];
	[continueGameButton addTarget:self action:@selector(TBD) forControlEvents:UIControlEventTouchUpInside];
    [continueGameButton setHidden:YES];
    [startView addSubview:continueGameButton];
    //
    creditsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creditsButton setFrame:CGRectMake(myW-80-10, myH-20-10, 80, 20)];
    [creditsButton setTitle:NSLocalizedString(@"L_credits", @"Credits") forState:UIControlStateNormal];
	[creditsButton addTarget:self action:@selector(TBD) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:creditsButton];

    
    //
    verLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, myH-25-10, 200, 25)];
    [verLabel setTextColor:[UIColor whiteColor]];
    [verLabel setBackgroundColor:[UIColor clearColor]];
    [verLabel setText:[NSLocalizedString(@"L_versionLabel", @"Ver.:") stringByAppendingFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    [startView addSubview:verLabel];
    
    //
    [self.view addSubview:startView];
    
    //
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

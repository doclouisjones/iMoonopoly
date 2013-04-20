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
//Note: all views are built (programmatically) within the VC
UIView *startView;  //Main Menu
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
    UIView *toolBarGameView;
    UIButton *homeGameViewButton;
    UIScrollView *mapScrollView;
    NSMutableArray *buildingsButtons;  //note: buildings are put in UIButtons!


//DATA
//
NSXMLParser *xmlParser;
//
NSString *playerName;
NSString *playerCompany;
NSString *playerLocation;
//
float playerFounds=0.0; //$
//
int selectedLocation=1;   //e.g. 1=Equator, 2=Pole, 3=Whatever!
//
NSMutableArray *buildingsArray;
NSDictionary *oneBuilding;



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
    float myW = 0.0;
    float myH = 0.0;

    //FIX ROTATION ISSUE
    if ([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height) {
        myW = [[UIScreen mainScreen] bounds].size.height;
        myH = [[UIScreen mainScreen] bounds].size.width;
    } else {
        myW = [[UIScreen mainScreen] bounds].size.width;
        myH = [[UIScreen mainScreen] bounds].size.width;
    }
    [self.view setFrame:CGRectMake(0, 0, myW, myH)];
    
    
    
    //DATA - PRE
	//
    //TODO, if any
    
    
    
    //BUILD SUBVIEWS
    
    //StarView
    //
    startView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *startViewbackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/background_StartView"]];
    [startViewbackground setFrame:CGRectMake(0, 0, myW, myH)];
    [startView addSubview:startViewbackground];
    //
    float startViewButtonsTop = 40;
    float startViewButtonsGap = 10;
    float startViewButtonW = 200;
    float startViewButtonH = 50;
    //
    newGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [newGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, startViewButtonsTop, startViewButtonW, startViewButtonH)];
    [newGameButton setTitle:NSLocalizedString(@"L_newGame", @"New Game") forState:UIControlStateNormal];
	[newGameButton addTarget:self action:@selector(GoToStartView) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:newGameButton];
    //
    continueGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [continueGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, startViewButtonsTop + startViewButtonsGap + startViewButtonH, startViewButtonW, startViewButtonH)];
    [continueGameButton setTitle:NSLocalizedString(@"L_continueGame", @"Continue Game") forState:UIControlStateNormal];
	[continueGameButton addTarget:self action:@selector(GoToGameView) forControlEvents:UIControlEventTouchUpInside];
    //TODO [continueGameButton setHidden:YES];
    [startView addSubview:continueGameButton];
    //
    creditsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [creditsButton setFrame:CGRectMake(myW-80-10, myH-30-10, 80, 30)];
    [creditsButton setTitle:NSLocalizedString(@"L_credits", @"Credits") forState:UIControlStateNormal];
	[creditsButton addTarget:self action:@selector(TBD) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:creditsButton];
    //
    verLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, myH-25-5, 200, 25)];
    [verLabel setTextColor:[UIColor whiteColor]];
    [verLabel setBackgroundColor:[UIColor clearColor]];
    [verLabel setText:[NSLocalizedString(@"L_versionLabel", @"Ver.:") stringByAppendingFormat:@"%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    [startView addSubview:verLabel];
    //
    [self.view addSubview:startView];

    
    //player Info View
    //TODO
    
    
    //location selection View
    //TODO
    
    
    //game View
    //
    gameView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *backgroundGameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/background_GameView"]];
    [backgroundGameView setFrame:CGRectMake(0, 0, myW, myH)];
    [gameView addSubview:backgroundGameView];
    //
    //ToolBar
    //Note: toolbar is a verital bar
    // for now will be placed on the right side
    // in the future, one can have the option to move it on the left side for left-handed users
    //
    float gameViewButtonSizeW = 50.0;
    float gameViewButtonSizeH = 50.0;
    float gameViewButtonBorder = 5.0;
    //
    toolBarGameView = [[UIView alloc] initWithFrame: CGRectMake(myW - (gameViewButtonSizeW+gameViewButtonBorder*2), 0, gameViewButtonSizeW+gameViewButtonBorder*2, myH)];
    [toolBarGameView setBackgroundColor:[UIColor blackColor]];
    //
    homeGameViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeGameViewButton setBackgroundColor:[UIColor clearColor]];
    [homeGameViewButton setBackgroundImage:[UIImage imageNamed:@"images/button_main_menu"] forState:UIControlStateNormal];
    [homeGameViewButton setFrame:CGRectMake(gameViewButtonBorder, gameViewButtonBorder, gameViewButtonSizeW, gameViewButtonSizeH)];
    [homeGameViewButton addTarget:self action:@selector(GoToStartView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarGameView addSubview:homeGameViewButton];
    //
    [gameView addSubview:toolBarGameView];
    //
    //map sub-view
        UIImageView *containedMap = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images/background_location_1.jpg"]] autorelease];
        //mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myW, myH)];
        mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myW - toolBarGameView.frame.size.width, myH)];
        [mapScrollView setBackgroundColor:[UIColor blackColor]];
        [mapScrollView setBounces:NO];
        [mapScrollView addSubview:containedMap];
        [mapScrollView setContentSize:containedMap.frame.size];
        [gameView addSubview:mapScrollView];
    //buildings
        //TODO
    //
    [gameView setHidden:YES];
    [self.view addSubview:gameView];
    
    
    //DATA - AFTER
	//Note: this is done here beacuse he needs first to create the actual UI items to populate
    [self BuildBuildings];

    
    //
    [super viewDidLoad];

    
    //DEBUG:
    [self GoToGameView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate {
    NSLog(@"shouldAutorotate");
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    NSLog(@"supportedInterfaceOrientations");
    return UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft;
    //return UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSLog(@"shouldAutorotateToInterfaceOrientation");
    // Return YES for supported orientations
	return (interfaceOrientation == (UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationLandscapeLeft));
}



//VIEWS MANAGEMENT
- (void) HideAllView {
    [startView setHidden:YES];
    [playerInfoView setHidden:YES];
    [locationSelectView setHidden:YES];
    [gameView setHidden:YES];
}

- (void) GoToPlayerInfoView {
    //TODO
}

- (void) GoToStartView {
    [self HideAllView];
    [startView setHidden:NO];
}

- (void) GoToLocationSelectionView {
    //TODO
}

- (void) GoToGameView {
    [self HideAllView];
    [gameView setHidden:NO];
}

- (void) SetupGameView {
    
}



//Buildings management
- (void) BuildBuildings {
    
    NSLog(@" BuildBuildings ");
    
    //and sorry for the pan
    buildingsArray = [NSMutableArray new];
    
    //parse xml
    xmlParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"buildings" ofType: @"xml"]]];
    [xmlParser setDelegate:self];

    //call xml
    BOOL success = [xmlParser parse];
    NSLog(@" Parsed? %i", success);
    
}

- (void) DrawBuildings {
    
    NSLog(@" DrawBuildings ");
    
    int i;
    UIButton *aButton;
    UIImage *buildingImage;
    NSString *image_file_name;
    
    //
    buildingsButtons = [NSMutableArray array];
    
    //
    for (i=0; i<buildingsArray.count; i++) {
        
        NSLog(@" create building %i ", i);

        //identify image file
        image_file_name = [buildingsArray[i] valueForKey:@"name"];
        //image_file_name = [image_file_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //remove spaces
        image_file_name = [image_file_name stringByReplacingOccurrencesOfString:@" " withString:@""];   //remove spaces: this one works
        image_file_name = [image_file_name lowercaseString];
        image_file_name = [@"images/ref_" stringByAppendingString:image_file_name];
        NSLog(@" ...with image: %@", image_file_name);
        
        
        //retrieve image
        buildingImage = [UIImage imageNamed:image_file_name];
        
        //
        aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setBackgroundColor:[UIColor clearColor]];
        [aButton setBackgroundImage:buildingImage forState:UIControlStateNormal];
        //DEBUG [aButton setFrame:CGRectMake(0, 0, buildingImage.size.width, buildingImage.size.height)];
        [aButton setFrame:CGRectMake(rand() % 960, rand() % 540, buildingImage.size.width, buildingImage.size.height)];
        
        //store building/button
        [buildingsButtons addObject:aButton];
        
        
        //add building/button to map
        [mapScrollView addSubview:buildingsButtons[i]];
        
        //
        //[aButton release];
        //aButton = nil;
        
    }
        
}


//XML Parser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"building"]) {

        //new building found in the XML. let's add it to the array
        NSLog(@" New building. let's add it to the array.");

        //
        //Extract the attribute here and add it to it
        //[buildingsArray addObject:[attributeDict objectForKey:@"name"]];
        oneBuilding = [NSDictionary dictionaryWithDictionary:attributeDict];
        
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    /*TODO
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
     */
	//NSLog(@"Processing Value: %@", currentElementValue);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"buildings"])
		return;
	
	if([elementName isEqualToString:@"building"]) {
       
        [buildingsArray addObject:oneBuilding];
        //[oneBuilding release];
		//oneBuilding = nil;
        
    }
	//[currentElementValue release];
	//currentElementValue = nil;
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {    
	NSLog(@"parserDidEndDocument:");
    [self DrawBuildings];
}

@end

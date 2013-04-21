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
UIView *buildingDetailsView;
    UIButton *closeDetailsView;
    UIImageView *buildingDetailsImage;
    UITextView *buildingDetailsDescription;
    float buildingDetailsImageWidth, buildingDetailsImageHeight;
    float buildingDetailsImageBorder;
    UIButton *buildingDetailsBuildButton;
    UILabel *buildingDetailsConstructionLevel;
    UISwitch *buildingDetailsProductionSwitch;
    UILabel *buildingDetailsProductionLabel;


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
int currentSelectedBuildIndex=-1;
//
NSMutableArray *buildingsArray;
NSMutableDictionary *oneBuilding;


//MUSIC
AVAudioPlayer *myMusicPlayer;


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
 
    //start music
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sounds/moonloop_music" ofType:@"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    myMusicPlayer =	[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [myMusicPlayer setDelegate:self];
    [fileURL release];
    [myMusicPlayer prepareToPlay];
    [myMusicPlayer play];

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
    
    
    //check for iPhone5
    NSString *iPhone5Suffix= @"";
    if (myW==568) iPhone5Suffix = @"-568h";

    
    //DATA - PRE
	//
    //TODO, if any
    
    
    
    //BUILD SUBVIEWS
    
    //StarView
    //
    startView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIImageView *startViewbackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"images/background_StartView" stringByAppendingString:iPhone5Suffix]]];
    [startViewbackground setFrame:CGRectMake(0, 0, myW, myH)];
    [startView addSubview:startViewbackground];
    //
    float startViewButtonsTop = 160;
    float startViewButtonsGap = 10;
    float startViewButtonW = 200;
    float startViewButtonH = 50;
    //
    //newGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[newGameButton setTitle:NSLocalizedString(@"L_newGame", @"New Game") forState:UIControlStateNormal];
    newGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newGameButton setBackgroundImage:[UIImage imageNamed:@"images/button_newgame"] forState:UIControlStateNormal];
    [newGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, startViewButtonsTop, startViewButtonW, startViewButtonH)];
    [newGameButton addTarget:self action:@selector(GoToStartView) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:newGameButton];
    //
    //continueGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[continueGameButton setTitle:NSLocalizedString(@"L_continueGame", @"Continue Game") forState:UIControlStateNormal];
    continueGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [continueGameButton setBackgroundColor:[UIColor clearColor]];
    [continueGameButton setBackgroundImage:[UIImage imageNamed:@"images/button_continue"] forState:UIControlStateNormal];
    [continueGameButton setFrame:CGRectMake((myW-startViewButtonW)/2, startViewButtonsTop + startViewButtonsGap + startViewButtonH, startViewButtonW, startViewButtonH)];
	[continueGameButton addTarget:self action:@selector(GoToGameView) forControlEvents:UIControlEventTouchUpInside];
    //TODO [continueGameButton setHidden:YES];
    [startView addSubview:continueGameButton];
    //
    //creditsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[creditsButton setTitle:NSLocalizedString(@"L_credits", @"Credits") forState:UIControlStateNormal];
    creditsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [creditsButton setBackgroundImage:[UIImage imageNamed:@"images/button_credits"] forState:UIControlStateNormal];
    [creditsButton setFrame:CGRectMake(myW-80-10, myH-30-10, 80, 30)];
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
    UIImageView *backgroundGameView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"images/background_GameView" stringByAppendingString:iPhone5Suffix]]];
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
    [toolBarGameView setAlpha:.6];
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
        mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myW, myH)];
        //mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, myW - toolBarGameView.frame.size.width, myH)];
        [mapScrollView setBackgroundColor:[UIColor blackColor]];
        [mapScrollView setBounces:NO];
        [mapScrollView addSubview:containedMap];
        [mapScrollView setContentSize:containedMap.frame.size];
        [gameView addSubview:mapScrollView];
    //buildings
        //see later
    //
    [gameView bringSubviewToFront:toolBarGameView];
    //
    [gameView setHidden:YES];
    [self.view addSubview:gameView];
    
    
    //building details view
    //float floatingViewBorder = 20.0;
    //buildingDetailsView = [[UIView alloc] initWithFrame:CGRectMake(floatingViewBorder, floatingViewBorder, myW - floatingViewBorder*2, myH - floatingViewBorder*2)];
    buildingDetailsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, myW, myH)];
    [buildingDetailsView setHidden:YES];
    [buildingDetailsView setBackgroundColor:[UIColor grayColor]];
    UIImageView *backgroundDetails = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"images/background_GameView" stringByAppendingString:iPhone5Suffix]]];
    [buildingDetailsView addSubview:backgroundDetails];
    [backgroundDetails setFrame:CGRectMake(0, 0, buildingDetailsView.frame.size.width, buildingDetailsView.frame.size.height)];
    [self.view addSubview:buildingDetailsView];
        //
        closeDetailsView = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeDetailsView setBackgroundColor:[UIColor clearColor]];
        [closeDetailsView setBackgroundImage:[UIImage imageNamed:@"images/CloseButton"] forState:UIControlStateNormal];
        //[closeDetailsView setFrame: CGRectMake(buildingDetailsView.frame.origin.x-13, buildingDetailsView.frame.origin.y-13, 25, 25)];
        [closeDetailsView setFrame: CGRectMake(myW-40, 15, 25, 25)];
        [closeDetailsView addTarget:self action:@selector(CloseDetailsView) forControlEvents:UIControlEventTouchUpInside];
        [closeDetailsView setHidden:YES];
        [self.view addSubview:closeDetailsView];
        //
        buildingDetailsImageWidth = 280;
        buildingDetailsImageHeight = 200;
        buildingDetailsImageBorder = 10;
        buildingDetailsImage = [[UIImageView alloc] initWithFrame:CGRectMake(buildingDetailsImageBorder, buildingDetailsImageBorder, buildingDetailsImageWidth, buildingDetailsImageHeight)];
        //DEBUG [detailBuildingImage setBackgroundColor:[UIColor blueColor]];
        [buildingDetailsView addSubview:buildingDetailsImage];
        //
        buildingDetailsDescription = [[UITextView alloc] initWithFrame:CGRectMake(buildingDetailsImageBorder,
                                                                             buildingDetailsImageBorder*2 + buildingDetailsImageHeight,
                                                                             buildingDetailsView.frame.size.width-20,
                                                                             buildingDetailsView.frame.size.height-220-10)];
        //DEBUG [buildingDetailsDescription setBackgroundColor:[UIColor redColor]];
        [buildingDetailsDescription setBackgroundColor:[UIColor clearColor]];
        [buildingDetailsDescription setTextColor:[UIColor whiteColor]];
        [buildingDetailsDescription setFont:[UIFont italicSystemFontOfSize:16]];
        [buildingDetailsView addSubview:buildingDetailsDescription];
        //
        buildingDetailsConstructionLevel = [[UILabel alloc] initWithFrame:CGRectMake(buildingDetailsImageBorder*2 + buildingDetailsImageWidth,
                                                                                 buildingDetailsImageBorder + 90,
                                                                                 180,
                                                                                 25)];
        [buildingDetailsConstructionLevel setBackgroundColor:[UIColor clearColor]];
        [buildingDetailsConstructionLevel setTextColor:[UIColor whiteColor]];
        [buildingDetailsConstructionLevel setText:@"Building level: 0"];
        [buildingDetailsView addSubview:buildingDetailsConstructionLevel];
        //
        buildingDetailsBuildButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buildingDetailsBuildButton setTitle:NSLocalizedString(@"L_ConstructBuilding", "Construct building") forState:UIControlStateNormal];
        [buildingDetailsBuildButton setFrame:CGRectMake(buildingDetailsConstructionLevel.frame.origin.x,
                                                        buildingDetailsImageBorder + 130,
                                                        160,
                                                        25)];
        [buildingDetailsBuildButton addTarget:self action:@selector(buildingLevelUp) forControlEvents:UIControlEventTouchUpInside];
        [buildingDetailsView addSubview:buildingDetailsBuildButton];
        //
        buildingDetailsProductionSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(buildingDetailsConstructionLevel.frame.origin.x,
                                                                                    buildingDetailsImageBorder + 50,
                                                                                    40,
                                                                                    40)];
        [buildingDetailsView addSubview:buildingDetailsProductionSwitch];
        //
        buildingDetailsProductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(buildingDetailsProductionSwitch.frame.origin.x + buildingDetailsProductionSwitch.frame.size.width + 5,
                                                                                   buildingDetailsProductionSwitch.frame.origin.y,
                                                                                   100, 26)];
        [buildingDetailsProductionLabel setBackgroundColor:[UIColor clearColor]];
        [buildingDetailsProductionLabel setTextColor:[UIColor whiteColor]];
        [buildingDetailsProductionLabel setText:NSLocalizedString(@"L_Production", "Production")];
        [buildingDetailsView addSubview:buildingDetailsProductionLabel];

    
    
    //DATA - AFTER
	//Note: this is done here beacuse he needs first to create the actual UI items to populate
    [self BuildBuildings];

    
    //
    [super viewDidLoad];

    
    //DEBUG:
    //[self GoToGameView];
    
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

- (void) ShowBuildingDetailsForIndex: (int) my_index {
    
    //set view

    //image
    //identify image file
    NSString *image_file_name;
    image_file_name = [buildingsArray[my_index] valueForKey:@"name"];
    image_file_name = [image_file_name stringByReplacingOccurrencesOfString:@" " withString:@"_"];   //remove spaces: this one works
    image_file_name = [image_file_name lowercaseString];
    image_file_name = [@"images/ref_" stringByAppendingString:image_file_name];
    //actual image
    UIImage *imageBuilding = [UIImage imageNamed:image_file_name];
    //resize preview
    [buildingDetailsImage setFrame:CGRectMake(buildingDetailsImageBorder + (buildingDetailsImageWidth-imageBuilding.size.width)/2,
                                              buildingDetailsImageBorder + (buildingDetailsImageHeight-imageBuilding.size.height)/2,
                                              imageBuilding.size.width, imageBuilding.size.height)];
    [buildingDetailsImage setImage:imageBuilding];
    
    //dscription
    [buildingDetailsDescription setText:[buildingsArray[my_index] valueForKey:@"info"]];
    
    //level
    [buildingDetailsConstructionLevel setText:[NSLocalizedString(@"L_BuildingLevel", @"Building level:") stringByAppendingFormat:@"%i", [[buildingsArray[my_index] valueForKey:@"BuildingLevel"] integerValue]]];

    //show view
    [buildingDetailsView setHidden:NO];
    [closeDetailsView setHidden:NO];
    [self.view bringSubviewToFront:closeDetailsView];
    
}

- (void) CloseDetailsView {
    [buildingDetailsView setHidden:YES];
    [closeDetailsView setHidden:YES];
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
        image_file_name = [image_file_name stringByReplacingOccurrencesOfString:@" " withString:@"_"];   //remove spaces: this one works
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
        //DEBUG [aButton setFrame:CGRectMake(rand() % 960, rand() % 540, buildingImage.size.width, buildingImage.size.height)];
        [aButton setFrame:CGRectMake([[buildingsArray[i] valueForKey:@"x"] floatValue],
                                     [[buildingsArray[i] valueForKey:@"y"] floatValue],
                                      buildingImage.size.width,
                                      buildingImage.size.height)];
        [aButton setTag:i]; //reference to itself (see OpenBuildingDetails:)
        [aButton addTarget:self action:@selector(OpenBuildingDetails:) forControlEvents:UIControlEventTouchUpInside];
        
        //store building/button
        [buildingsButtons addObject:aButton];
        
        //add building/button to map
        if (i>0) [buildingsButtons[i] setAlpha:.5]; //DEBUG
        //DEBUG if (i>4) [buildingsButtons[i] setAlpha:.0];
        [mapScrollView addSubview:buildingsButtons[i]];
        
        //
        //[aButton release];
        //aButton = nil;
        
    }
        
}

- (void) OpenBuildingDetails: (id) sender {

    //Note, a Button called this
    //Which button? check the tag property
    UIButton *senderButton = sender;
    NSLog(@" PRESSED ON %i", senderButton.tag);

    //store index to current selectedBuilding
    currentSelectedBuildIndex = senderButton.tag;
    
    //
    [self ShowBuildingDetailsForIndex:currentSelectedBuildIndex];
    
}

- (void) buildingLevelUp {
    NSLog(@" Level Up Building: %i", currentSelectedBuildIndex);

    //retrieve old building level
    int my_level = [[buildingsArray[currentSelectedBuildIndex] valueForKey:@"BuildingLevel"] integerValue];
    my_level++;
    [buildingsArray[currentSelectedBuildIndex] setValue:[NSNumber numberWithInt:my_level] forKey:@"BuildingLevel"];
    
    //update detaield view
    [buildingDetailsConstructionLevel setText:[NSLocalizedString(@"L_BuildingLevel", @"Building level:") stringByAppendingFormat:@"%i", my_level]];
    
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
        oneBuilding = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
        
        //live properties
        [oneBuilding setValue:[NSNumber numberWithInt:0] forKey:@"BuildingLevel"];
        
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


//MUSIC
- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) player successfully: (BOOL) flag {
    if (flag == YES) {
        [myMusicPlayer play];
    }
}


@end

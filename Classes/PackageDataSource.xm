//
//  PackageDataSource.m
//  nitoTV
//
//  Created by Tom Cool & Kevin Bradley on 2/26/11.
//  Copyright 2011 nito. All rights reserved.
//

#import "packageManagement.h"
#import "../SMFClasses/SMFCommonTools.h"

/*
#import "queryMenu.h"
#import "PackageDataSource.h"
#import "nitoInstallManager.h"
#import "nitoSourceController.h"
#import "nitoMoreMenu.h"
#import <SMFramework/SMFComplexProcessDropShadowControl.h>
#import <SMFramework/SMFramework.h>

@implementation PackageDataSource

@class queryMenu;
@synthesize packageData, imageURL, rawCoverArt, provider, installed, currentMode, listActionMode;
*/



static int currentMode;
static int listActionMode;
static BOOL installed;


static char const * const kNitoPKGDataKey = "nPKGData";
static char const * const kNitoPKGImageURLKey = "nPKGImageURL";
static char const * const kNitoPKGRawCoverArtKey = "nPKGRawCoverArt";
static char const * const kNitoPKGProviderKey = "nPKGProvider";

%subclass PackageDataSource : SMFMoviePreviewController

%new - (void)setListActionMode:(int)value
{
	listActionMode = value;
}

%new -(int)listActionMode
{
	return listActionMode;
}

%new - (void)setCurrentPackageMode:(int)value
{
	currentMode = value;
}

%new -(int)currentPackageMode
{
	return currentMode;
}

%new -(void)setInstalled:(BOOL)value
{
	installed = value;
}

%new - (NSDictionary *)packageData
{
	return [self associatedValueForKey:(void*)kNitoPKGDataKey];
}

%new - (void)setPackageData:(NSDictionary *)value
{
	[self associateValue:value withKey:(void*)kNitoPKGDataKey];
}

%new - (NSString *)imageURL
{
	return [self associatedValueForKey:(void*)kNitoPKGImageURLKey];
}

%new - (void)setImageURL:(NSString *)value
{
	[self associateValue:value withKey:(void*)kNitoPKGImageURLKey];
}

%new - (id)rawCoverArt {
	return [self associatedValueForKey:(void*)kNitoPKGRawCoverArtKey];
}

%new - (void)setRawCoverArt:(id)value
{
	[self associateValue:value withKey:(void*)kNitoPKGRawCoverArtKey];
}

%new - (id)provider
{
	return [self associatedValueForKey:(void*)kNitoPKGProviderKey];
}

%new - (void)setProvider:(id)value
{
	[self associateValue:value withKey:(void*)kNitoPKGProviderKey];
}

/*
 
 Package: com.nito.nitotv
 Status: install ok installed
 Section: Utilities
 Installed-Size: 1380
 Maintainer: nito
 Architecture: iphoneos-arm
 Version: 0.6.4-91
 Depends: beigelist, mobilesubstrate, com.nito.gs
 Description: Release six, weather, RSS, basic deb installer, featured packages, revamped search, package deletion (featured packages only).
 Name: nitoTV
 Website: nitosoft.com
 Author: nito
 
 
 */

%new - (BOOL)rowSelectable:(long)row	
{
	return YES;
}


%new - (NSDictionary *)parsedPackageList
{
		//NSString *endFile = @"/Installed.plist";
	NSString *endFile = [packageManagement installedLocation];
	NSDictionary *parsedDict = [NSDictionary dictionaryWithContentsOfFile:endFile];
	return parsedDict;
}

%new - (BOOL)packageInstalled:(NSString *)currentPackage
{
	
	NSDictionary *packageList = [self parsedPackageList];
	if ([packageList objectForKey:currentPackage] != nil)
	{
		id currentDict = [packageList objectForKey:currentPackage];
		if ([[currentDict allKeys] containsObject:@"Version"])
			return YES;
		else
			return NO;
		
	}
	
	return NO;
}

	//SMFComplexProcessDropShadowControl

%new -(void)process:(id)p ended:(NSString *)s
{
	id installCon = [[[self stack] controllersOfClass:%c(nitoInstallManager)] objectAtIndex:0];
	[packageManagement updatePackageList];
	[[installCon list] reload];
		//NSLog(@"process: %@ ended: %@ returnStatus: %i", p, s, [p returnCode]); 
	switch ((int)listActionMode) {

		case kPackageInstallMode:
				//	NSLog(@"kPackageInstallMode");
			if ([p returnCode] == 0)
			{
				[p setTitle:@"Installation/Upgrade successful"];
				[p setSubtitle:@"Press Menu to exit"];
			} else {
				[p setTitle:@"Installation failed"];
				[p setSubtitle:@"Press Menu to exit"];
			}
			break;
	
		case KPackageRemoveMode:
			
			if ([p returnCode] == 0)
			{
				[p setTitle:@"Removal success"];
				[p setSubtitle:@"Press Menu to exit"];
			} else {
				[p setTitle:@"Removal failed"];
				[p setSubtitle:@"Press Menu to exit"];
			}
			
			break;
	}
	
}

%new - (void)installQueue:(NSString *)queueFile withSender:(id)sender
{
	
	id consoleController = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper queue %@", queueFile];
	[consoleController setAp:command];
	[consoleController setTitle:@"Installing Queue..."];
	[consoleController setShowsProgressBar:FALSE];
	[consoleController setIsAnimated:TRUE];
	[consoleController setSender:sender];
	[consoleController addToController:self];

	[consoleController release];
	
}

%new - (void)installQueue:(NSString *)queueFile
{
	id consoleController = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper queue %@", queueFile];
	[consoleController setAp:command];
	[consoleController setTitle:@"Installing Queue..."];
	[consoleController setShowsProgressBar:FALSE];
		[consoleController setIsAnimated:TRUE];
	[consoleController addToController:self];
	[consoleController release];
}

%new - (void)showRemoveDialogNotification:(NSNotification *)n
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self performSelectorOnMainThread:@selector(showRemoveDialog:) withObject:[n userInfo] waitUntilDone:NO];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

%new - (void)showRemoveDialog:(NSDictionary *)removeDict
{
	
	NSString *packageToRemove = [removeDict valueForKey:@"Package"];
	NSString *theTitle = BRLocalizedString(@"Delete Package?", @"alert dialog for deleting playlist");
	NSString *secondaryString = [packageManagement displayDependentsForPackage:packageToRemove];
	NSString *primaryInfo = nil;
	if ([secondaryString length] > 0)
	{
		primaryInfo = [NSString stringWithFormat:BRLocalizedString(@"The following packages depend upon %@, do you wish to delete all of them?",@"primary text for the alert on removing packages"), packageToRemove];
		
	}
	int alertResult = (int)[objc_getClass("BROptionAlertControl") postAlertWithTitle:theTitle primaryText:primaryInfo secondaryText:secondaryString firstButton:BRLocalizedString(@"Cancel", @"Cancel") secondButton:BRLocalizedString(@"Delete", @"Delete") thirdButton:nil defaultFocus:0];
	
	
	
		//NSLog(@"showUpdateDialog result: %i", alertResult);
	
	switch (alertResult) {
			
		case 1: //remove
			[self performSelector:@selector(finalizeRemove:) withObject:removeDict afterDelay:1];
				//[self finalizeRemove:packageToRemove];
			break;
	}	

}

%new - (void)finalizeRemove:(NSDictionary *)removeDict
{
	NSString *customFile = [removeDict valueForKey:@"Package"];
	id sender = [removeDict valueForKey:@"Sender"];
	id consoleController  = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper remove %@", customFile];
	[consoleController setAp:command];
	[consoleController setIsAnimated:TRUE];
	[consoleController setSender:sender];
	[consoleController setTitle:[NSString stringWithFormat:@"Removing %@...", customFile]];
	[consoleController setShowsProgressBar:FALSE];
	[consoleController addToController:self];
	[consoleController release];
}




%new - (void)removePackage:(NSString *)customFile withSender:(id)sender
{
	
	[self performSelector:@selector(removeDialog:) withObject:customFile afterDelay:4];
		//[self performSelectorOnMainThread:@selector(removeDialog:) withObject:customFile waitUntilDone:NO];
		//[self removeDialog:customFile];
}

%new - (void)removePackage:(NSString *)customFile
{
	id consoleController  = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper remove %@", customFile];
	[consoleController setAp:command];
	[consoleController setIsAnimated:TRUE];
	[consoleController setTitle:[NSString stringWithFormat:@"Removing %@...", customFile]];
	[consoleController setShowsProgressBar:FALSE];
	[consoleController addToController:self];
	[consoleController release];
}

%new - (void)newUberInstaller:(NSString *)customFile
{	
	
	id consoleController  = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper install %@ 2", customFile];
	[consoleController setAp:command];
	[consoleController setIsAnimated:TRUE];
		//[consoleController setShadowStyle:0];
	[consoleController setTitle:[NSString stringWithFormat:@"Installing %@...", customFile]];
	[consoleController setShowsProgressBar:FALSE];
	[consoleController addToController:self];
	
}

%new - (void)newUberInstaller:(NSString *)customFile withSender:(id)sender
{	
	
	id consoleController  = [[objc_getClass("SMFComplexProcessDropShadowControl") alloc] init];
	[consoleController setDelegate:self];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/nitoHelper install %@ 2", customFile];
	[consoleController setAp:command];
	[consoleController setIsAnimated:TRUE];
	if (sender != nil)
	{
		[consoleController setSender:sender];
	}
		//[consoleController setShadowStyle:0];
	[consoleController setTitle:[NSString stringWithFormat:@"Installing %@...", customFile]];
	[consoleController setShowsProgressBar:FALSE];
	[consoleController addToController:self];
	
}

%new - (void)showPopupFrom:(id)me withSender:(id)sender
{
	id c = [[objc_getClass("nitoMoreMenu") alloc] initWithSender:sender addedTo:me];
	[c addToController:me];
	[c release];
}

//- (void)showPopupFrom:(id)me withSender:(id)sender
//{
//	SMFListDropShadowControl *c = [[SMFListDropShadowControl alloc]init];
//	[c setCDelegate:me];
//	[c setSender:sender];
//	[c setIsAnimated:TRUE];
//	[c setCDatasource:me];
//	[c addToController:me];
//}

%new - (void)showPopupFrom:(id)me
{
	id c = [[objc_getClass("SMFListDropShadowControl") alloc]init];
	[c setCDelegate:me];
	[c setIsAnimated:TRUE];
	[c setCDatasource:me];
	[c addToController:me];
		//[c release];
}

%new - (NSArray *)parsedPackageArray
{
	
	NSString *packageFile = @"/tmp/pkginfo";
	NSString *packageString = [NSString stringWithContentsOfFile:packageFile encoding:NSUTF8StringEncoding error:nil];
	NSArray *packageArray = [packageString componentsSeparatedByString:@"\n\n"];
	NSString *mainLine = [packageArray objectAtIndex:0];
	NSArray *lineArray = [mainLine componentsSeparatedByString:@"\n"];
	return (lineArray);
	
}
%new - (NSDictionary *)packageInfoFromArray:(NSArray *)packageList
{
	NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] init];

	for (id currentItem in packageList)
	{
		NSArray *itemArray = [currentItem componentsSeparatedByString:@": "];
		if ([itemArray count] >= 2)
		{
			
			[mutableDict setObject:[itemArray objectAtIndex:1] forKey:[itemArray objectAtIndex:0]];
		}
		
	}
	
	return [mutableDict autorelease];
}

- (void)dealloc
{
	
		//	[packageData release];
		//[imageURL release];
		//[provider release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	%orig;
}

- (void)controlWasDeactivated
{
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	%orig;
}

- (void)controlWasActivated
{
	NSLog(@"controlWasActivated");
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRemoveDialogNotification:) name:@"RemoveDialog" object:nil];
	%orig;
}

%new - (id)initWithPackageInfo:(NSDictionary *)packageInfo
{
	
	self = [self init];

	NSString *packageId = [packageInfo valueForKey:@"Package"];
	installed = [self packageInstalled:packageId];
	[self setPackageData:packageInfo];
		//packageData = packageInfo;
	
	return ( self );
}

%new - (id)initWithPackage:(NSString *)packageId usingImage:(id)theImage
{
	self = [self init];
	[[NSFileManager defaultManager] removeItemAtPath:@"/tmp/pkginfo" error:nil];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/apt-cache show %@ 1>/tmp/pkginfo", packageId];
	//NSArray *packageArray = [[SMFCommonTools sharedInstance] returnForProcess:command];
	system([command UTF8String]);
	NSArray *packageArray = [self parsedPackageArray];

	if (theImage != nil)
	{
		if ([theImage respondsToSelector:@selector(isPowerOfTwo)])
		{
			[self setRawCoverArt:theImage];
		} else {
			[self setImageURL:theImage];
		}
	}
		
	installed = [self packageInstalled:packageId];
	currentMode = kPKGFavoritesListMode;
	[self setPackageData:[self packageInfoFromArray:packageArray]];
	
	return (self);
	
}

%new - (void)updatePackageData:(NSString *)packageId usingImage:(id)theImage
{
	[[NSFileManager defaultManager] removeItemAtPath:@"/tmp/pkginfo" error:nil];
	NSString *command = [NSString stringWithFormat:@"/usr/bin/apt-cache show %@ 1>/tmp/pkginfo", packageId];

		//NSArray *packageArray = [[SMFCommonTools sharedInstance] returnForProcess:command];
	system([command UTF8String]);
	NSArray *packageArray = [self parsedPackageArray];
	
	if (theImage != nil)
	{
		if ([theImage respondsToSelector:@selector(isPowerOfTwo)])
		{
			[self setRawCoverArt:theImage];
		} else {
			[self setImageURLLtheImage];
		}
	}
	
	installed = [self packageInstalled:packageId];
		//packageData = [self packageInfoFromArray:packageArray];
	[self setPackageData:[self packageInfoFromArray:packageArray]];
	[self reload];
	[self setFocusedControl:[[self buttons] objectAtIndex:0]];
}


%new -(NSString *)shelfTitle
{
	switch (currentMode) {
					
		case kPKGFavoritesListMode:
			return @"Featured";
		
		case kPKGSearchListMode:
			return @"Search Results";
		
		case kPKGRepoListMode:
			return [[self delegate] currentRepoString];
			
		case kPKGInstalledListMode:
			return @"Installed";

	}
	return @"Featured";
}

/*
 
 there are part of a protocol, i dont actually know if its possible to dynamically subclass AND adhere to a protocol
 
 */

%new -(NSString *)title
{
    return [[self packageData] valueForKey:@"Name"];
}
%new -(NSString *)subtitle
{
    return [[self packageData] valueForKey:@"Package"];
}
%new -(NSString *)summary
{
    return [[self packageData] valueForKey:@"Description"];
}

%new - (NSArray *)headers
{
	return [NSArray arrayWithObjects:@"Author",@"Version",@"Section",@"Dependencies",nil];
}

%new -(NSArray *)dependencies
{

	id dependString =[[self packageData] valueForKey:@"Depends"];
	
	if ([dependString respondsToSelector:@selector(length)])
	{
		if ([dependString length] > 0)
			return [dependString componentsSeparatedByString:@", "];
	} else if ([dependString respondsToSelector:@selector(count)]) {
		
		return dependString;
	}

	return nil;
}

%new -(NSArray *)columns
{
    NSArray *author = [NSArray arrayWithObjects:[[self packageData] valueForKey:@"Author"],nil];
    NSArray *section = [NSArray arrayWithObjects:[[self packageData] valueForKey:@"Section"],nil];
    NSArray *depends = [self dependencies];
    NSArray *version = [NSArray arrayWithObjects:[[self packageData] valueForKey:@"Version"], nil];
    NSArray *objects = [NSArray arrayWithObjects:author,version,section,depends,nil];
    return objects;
}
%new -(NSString *)rating
{

	NSString *package = [self subtitle];
	NSArray *packageItems = [package componentsSeparatedByString:@"."];
	if ([packageItems count] > 1)
	{
		NSString *middle = [packageItems objectAtIndex:1];
		if ([middle isEqualToString:@"tomcool"])
		{
			return @"TV-COOL";
		}
	}


	return @"TV-NITO";
}
%new -(id)coverArt
{
	if ([self rawCoverArt] != nil)
	{
		return [self rawCoverArt];
	}
	if ([self imageURL] != nil)
	{
		return [objc_getClass("BRImage") imageWithURL:[NSURL URLWithString:[self imageURL]]];
	}

    return [[NitoTheme sharedTheme] packageImage];
}
	//@"com.nito.query"

%new - (NSArray *)searchDataStore
{
	Class queryClass = objc_getClass("queryMenu");
	id queryObject = [[[self stack] controllersOfClass:queryClass] lastObject];
	
	NSArray *names = [queryObject names];
	NSMutableArray *assetArray = [[NSMutableArray alloc] init];
	NSEnumerator *assetEnum = [names objectEnumerator];
	id theObject = nil;
	while ((theObject = [assetEnum nextObject]))
	{
		
		NSString *imagePath = [[NSBundle bundleForClass:[NitoTheme class]] pathForResource:@"package" ofType:@"png" inDirectory:@"Images"];
		
		id  asset = [[objc_getClass("SMFPhotoMediaAsset") alloc] init];
        [asset setFullURL:imagePath];
        [asset setThumbURL:imagePath];
        [asset setCoverArtURL:imagePath];
        [asset setIsLocal:YES];
		[asset setTitle:theObject];
		[assetArray addObject:asset];
		[asset release];
	}
	
	
	return [assetArray autorelease];
}

%new - (NSArray *)repoDataStore
{
	
	NSArray *ogArray = [[self delegate] sourceArray];
	NSArray *repoItems = nil;
	
	if ([ogArray count] > 1000)
	{
		NSLog(@"really big source! count: %i, slimmed to 1K", [ogArray count]);
		repoItems = [ogArray subarrayWithRange:NSMakeRange(0, 1000)];

	} else {
		
		NSLog(@"much more manageable: %i", [ogArray count]);
		
		repoItems = ogArray;

	}

		//NSLog(@"repoItems: %@", repoItems);
	NSMutableArray *assetArray = [[NSMutableArray alloc] init];
	NSEnumerator *assetEnum = [repoItems objectEnumerator];
	id theObject = nil;
	while ((theObject = [assetEnum nextObject]))
	{
		BOOL isLocal = NO;
		NSString *packageID = [theObject valueForKey:@"Package"];
		NSString *imagePath = [theObject valueForKey:@"imageUrl"];
		if (imagePath == nil)
		{
			isLocal = YES;
			imagePath = [[NSBundle bundleForClass:[NitoTheme class]] pathForResource:@"package" ofType:@"png" inDirectory:@"Images"];
		}
		
		id  asset = [[objc_getClass("SMFPhotoMediaAsset") alloc] init];
        [asset setFullURL:imagePath];
        [asset setThumbURL:imagePath];
        [asset setCoverArtURL:imagePath];
        [asset setIsLocal:isLocal];
		[asset setTitle:packageID];
		[assetArray addObject:asset];
		[asset release];
	}
	
	
	return [assetArray autorelease];
}

%new - (NSArray *)installedDataStore
{
	NSArray *installedArray = [packageManagement parsedPackageArray];
	NSMutableArray *assetArray = [[NSMutableArray alloc] init];
	NSEnumerator *assetEnum = [installedArray objectEnumerator];
	id theObject = nil;
	while ((theObject = [assetEnum nextObject]))
	{
		BOOL isLocal = NO;
		NSString *packageID = [theObject valueForKey:@"Package"];
		NSString *imagePath = [theObject valueForKey:@"imageUrl"];
		if (imagePath == nil)
		{
			isLocal = YES;
			imagePath = [[NSBundle bundleForClass:[NitoTheme class]] pathForResource:@"package" ofType:@"png" inDirectory:@"Images"];
		}
		
		id  asset = [[objc_getClass("SMFPhotoMediaAsset") alloc] init];
        [asset setFullURL:imagePath];
        [asset setThumbURL:imagePath];
        [asset setCoverArtURL:imagePath];
        [asset setIsLocal:isLocal];
		[asset setTitle:packageID];
		[assetArray addObject:asset];
		[asset release];
	}
	
	
	return [assetArray autorelease];
}

%new - (NSArray *)favoriteDataStore
{
	NSArray *favorites = [objc_getClass("nitoInstallManager") nitoPackageArray];
		//NSLog(@"favorites: %@", favorites);
	NSMutableArray *assetArray = [[NSMutableArray alloc] init];
	NSEnumerator *assetEnum = [favorites objectEnumerator];
	id theObject = nil;
	while ((theObject = [assetEnum nextObject]))
	{
		BOOL isLocal = NO;
		NSString *packageID = [theObject valueForKey:@"url"];
		NSString *imagePath = [theObject valueForKey:@"imageUrl"];
		if (imagePath == nil)
		{
			isLocal = YES;
			imagePath = [[NSBundle bundleForClass:[NitoTheme class]] pathForResource:@"package" ofType:@"png" inDirectory:@"Images"];
		}
			
		id  asset = [[objc_getClass("SMFPhotoMediaAsset") alloc] init];
        [asset setFullURL:imagePath];
        [asset setThumbURL:imagePath];
        [asset setCoverArtURL:imagePath];
        [asset setIsLocal:isLocal];
		[asset setTitle:packageID];
		[assetArray addObject:asset];
			[asset release];
	}
	

	return [assetArray autorelease];
}

%new - (void)queuePopupWithPackage:(NSString *)thePackage
{
	id image = [[NitoTheme sharedTheme] packageImage];
	NSString *installMessage = [NSString stringWithFormat:@"%@ added to queue", thePackage];
	NSArray *a = [NSArray arrayWithObjects:installMessage,@"Continuing queuing or press 'Install' to execute queue",nil];
	id popup=[SMFCommonTools popupControlWithLines:a andImage:image];
	[SMFCommonTools showPopup:popup];
}

%new - (void)removeQueuePopupWithPackage:(NSString *)thePackage
{
	id image = [[NitoTheme sharedTheme] packageImage];
	NSString *installMessage = [NSString stringWithFormat:@"%@ un-queued", thePackage];
	NSArray *a = [NSArray arrayWithObjects:installMessage,@"Continuing queuing or press 'Install' to execute queue",nil];
	id popup=[SMFCommonTools popupControlWithLines:a andImage:image];
	[SMFCommonTools showPopup:popup];
}

%new -(id)providerForShelf //no more brdatastore!! :(
{
	
	Class brds = objc_getClass("BRDataStore");
	if (brds == nil)
	{
		NSLog(@"no more BRDataStore :(, returning nil at providerForShelf");
		return nil;
	}
	id photoType = [objc_getClass("BRMediaType") photo];
    NSSet *_set = [NSSet setWithObject:photoType];
    NSPredicate *_pred = [NSPredicate predicateWithFormat:@"mediaType == %@",photoType];
    id store = [[brds alloc] initWithEntityName:@"Hello" predicate:_pred mediaTypes:_set];
	NSArray *assets = nil;
	switch (currentMode) {
	
		case kPKGFavoritesListMode:
			
			assets = [self favoriteDataStore];
			
			break;
	
		case kPKGRepoListMode:
			
			assets = [self repoDataStore];
			
			break;
			
		case kPKGSearchListMode:
			
			assets = [self searchDataStore];
			
			break;
			
		case kPKGInstalledListMode:
			
			assets = [self installedDataStore];
			
			break;
		
		default:
			assets = nil;
				//assets = [SMFPhotoMethods mediaAssetsForPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"Posters" ofType:@""]];
			break;
	
	}
	
	
 
    for (id a in assets) {
        [store addObject:a];
    }
    
    
    id tcControlFactory = [objc_getClass("BRPosterControlFactory") factory];
    id _provider    = [objc_getClass("BRPhotoDataStoreProvider") providerWithDataStore:store controlFactory:tcControlFactory];
    [self setProvider:_provider];
	[store release];
    return _provider; 
}
-(NSArray *)buttons
{
	Class bti = objc_getClass("BRThemeInfo");
	Class brbc = objc_getClass("BRButtonControl");
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    id b = [brbc actionButtonWithImage:[[bti sharedTheme]previewActionImage] 
													   subtitle:@"Install" 
														  badge:nil];
    [buttons addObject:b];
    
    
   
	if (currentMode == kPKGFavoritesListMode)
	{
		b = [brbc actionButtonWithImage:[[bti sharedTheme]queueActionImage] 
										  subtitle:@"Queue" 
											 badge:nil];
		[buttons addObject:b];
	}
	
    
    b = [brbc actionButtonWithImage:[[bti sharedTheme]deleteActionImage] 
									  subtitle:@"Remove" 
										 badge:nil];
	if (installed == FALSE)
	{
		[b setButtonEnabled:FALSE];
	}
    [buttons addObject:b];

	
	b = [brbc actionButtonWithImage:[[bti sharedTheme] moreActionImage] 
									  subtitle:@"More" 
										 badge:nil];
	
    [buttons addObject:b];
    return [buttons autorelease];
    
}

%new -(void)controller:(id)c selectedControl:(id)ctrl
{
			NSLog(@"here: %@", ctrl);
	if ([ctrl respondsToSelector:@selector(subtitle)])
	{
			NSLog(@"button subtitle: %@", [[ctrl subtitle]string]);
	}	
		if ([ctrl respondsToSelector:@selector(selectedControl)])
		{
			NSLog(@"selectedControl: %@", [[[ctrl selectedControl]title]string ]);
		}
	
	 
}

%end
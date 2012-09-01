/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "Lowtide-Structs.h"
#import "MPAssetKeyDelegate.h"
#import "LTMarimbaPhotoPlayer.h"
#import <BackRow/BRMediaPlayer.h>

@class BRMarimbaSlideshowControl, NSDictionary, NSString, BRControl, NSArray, BRImageManager, NSTimer, BRPhotoMediaCollection, BRAsyncTask;

@interface LTMarimbaPhotoPlayer : BRMediaPlayer <MPAssetKeyDelegate> {
	BRControl* _tempVisuals;
	NSTimer* _spinnerTimer;
	BRAsyncTask* _preloadImageTask;
	NSString* _assetIDBeingLoaded;
	BRMarimbaSlideshowControl* _visuals;
	BRPhotoMediaCollection* _collection;
	BRMediaPlayer* _audioPlayer;
	id _musicServerID;
	id _musicPlaylistID;
	ATVDataServerRef _musicServerRef;
	ATVMediaCollectionRef _musicPlaylistRef;
	ATVMediaQueryRef _playlistsQuery;
	ATVMediaQueryRef _songsQuery;
	SEL _musicQueryToRun;
	NSDictionary* _slideshowPlaybackOptions;
	NSArray* _orderedPhotoAssets;
	NSTimer* _screensaverTickleTimer;
	int _state;
	int _numPreloadAttemptsToMake;
	int _numPreloadSuccesses;
	int _indexOfNextImageToPreload;
	long _startIndex;
	int _imageSizeToLoad;
	BOOL _initialImagePrefetchInProgress;
	BOOL _playbackInitiated;
	BOOL _shuffleSet;
	BOOL _shuffle;
	BOOL _repeatModeSet;
	int _repeatMode;
	BOOL _muted;
	BOOL _weOwnMusicPlayback;
	BRImageManager* _preferredImageManager;
	BOOL _preloadingDisabled;
	BOOL _substitute;
	int _substituteIndex;
	BOOL _preloadingComplete;
	BOOL _marimbaVisualsOnDisplay;
	BOOL _musicPrefetchInProgress;
	BOOL _documentSetupComplete;
	float _lastRemovedEffectsTime;
}
+(id)contentTypes;
-(id)init;
-(void)dealloc;
-(BOOL)stopsActiveAudioPlayer;
-(BOOL)reverseTouchSwipeBehavior;
-(BOOL)setMediaAtIndex:(long)index inCollection:(id)collection error:(id*)error;
-(id)collection;
-(id)media;
-(BOOL)setState:(int)state error:(id*)error;
-(int)playerState;
-(BOOL)playingVisualContent;
-(id)visuals;
-(void)setPlayerSpecificOptions:(id)options;
-(id)playerSpecificOptions;
-(void)setShufflePlayback:(BOOL)playback;
-(BOOL)shufflePlayback;
-(void)setRepeatMode:(int)mode;
-(int)repeatMode;
-(BOOL)supportsRepeatModes;
-(void)previousMedia;
-(void)nextMedia;
-(BOOL)supportsVolumeControl;
-(void)setVolume:(float)volume;
-(float)volume;
-(void)setMuted:(BOOL)muted;
-(BOOL)muted;
-(id)absolutePathForAssetKey:(id)assetKey;
-(id)absolutePathForAssetKey:(id)assetKey andSize:(CGSize)size;
-(id)absolutePathForStillAssetAtPath:(id)path andSize:(CGSize)size;
-(CGImageRef)retainedCGImageForAssetKey:(id)assetKey andSize:(CGSize)size;
@end

@interface LTMarimbaPhotoPlayer (NotificationHandlers)
-(void)_newPhotoPlayerPlaying:(id)playing;
-(void)_marimbaSlideshowPlaybackFinished:(id)finished;
-(void)_marimbaSlideshowWillRepeat:(id)_marimbaSlideshow;
-(void)_playerMediaCued:(id)cued;
-(void)_playerError:(id)error;
-(void)_musicServerConnectionNotification:(id)notification;
@end

@interface LTMarimbaPhotoPlayer (PlaybackControl)
-(void)_setNewMedia:(id)media;
-(void)_setNewState:(int)state;
-(BOOL)_handleStopActionWithError:(id*)error;
-(BOOL)_handlePauseActionWithError:(id*)error;
-(BOOL)_handlePlayActionWithError:(id*)error;
@end

@interface LTMarimbaPhotoPlayer (Private)
-(void)_reorderImages;
-(void)_spinnerTimerFired;
-(void)_setupDocument;
-(void)_startSlideshowIfReady;
-(void)_applyPlayerSpecificOptions;
-(void)_applyDocumentChangesAfterTransition:(id)transition;
-(void)_setSlideshowTheme;
-(void)_setTransition;
-(void)_setTimePerSlide;
-(void)_setMusic;
-(void)_runPlaylistsQuery;
-(void)_setPlaylistsQuery:(ATVMediaQueryRef)query;
-(ATVDataClientRef)_dataClient;
-(void)_playlistsQueryComplete;
-(void)_runSongsQuery;
-(void)_setSongsQuery:(ATVMediaQueryRef)query;
-(void)_songsQueryComplete;
-(void)_tickleScreensaver:(id)screensaver;
-(id)_pathForLocalAssetID:(id)localAssetID;
-(int)_indexOfAssetPathInOrderedAssets:(id)orderedAssets;
-(int)_preloadSuccessThresholdForStyle:(id)style;
@end

@interface LTMarimbaPhotoPlayer (Preloading)
-(void)_preloadNextImage;
-(void)_updatePreloadingStateForLastPlayed:(id)lastPlayed;
-(void)_triggerPreloadOfNextImage;
-(void)_imageWritten:(id)written;
-(void)_loadFailed:(id)failed;
-(void)_startPreloadTask;
-(void)_beginMusicPrefetchFromPlayerOptions;
-(void)_beginMusicPrefetchFromDefaults;
-(void)_beginMusicPrefetch;
-(void)_cancelMusicPrefetch;
@end

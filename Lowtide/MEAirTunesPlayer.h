/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "Lowtide-Structs.h"
#import <BackRow/BRMediaPlayer.h>
#import "MEAirTunesPlayer.h"

@class NSTimer, MEAirTunesMediaProvider, MEAirTunesMediaAsset;

@interface MEAirTunesPlayer : BRMediaPlayer {
	float _position;
	int _state;
	int _stateBeforeSeek;
	MEAirTunesMediaProvider* _provider;
	MEAirTunesMediaAsset* _asset;
	NSTimer* _progressNotificationTimer;
	BOOL _enabled;
	BOOL _waitingForIdleNotification;
	SCDynamicStoreRef _dynStoreRef;
	CFRunLoopSourceRef _dynStoreRunLoopSource;
	SCPreferencesRef _prefsRef;
}
+(id)contentTypes;
+(BOOL)handlesVideoForType:(id)type;
+(BOOL)allowMultiplePlayers;
-(id)init;
-(void)dealloc;
-(void)enable;
-(void)disable;
-(void)resume;
-(void)zeroPlayer;
-(BOOL)setMediaAtIndex:(long)index inTrackList:(id)trackList error:(id*)error;
-(id)media;
-(BOOL)setState:(int)state error:(id*)error;
-(int)playerState;
-(double)duration;
-(void)setElapsedTime:(double)time;
-(double)elapsedTime;
-(void)resetToBeginning;
-(void)previousMedia;
-(void)nextMedia;
@end

@interface MEAirTunesPlayer (Notifications)
-(void)_registerForNotifications;
-(void)_setPreferences;
-(void)_setAllowPlayback:(BOOL)playback;
-(void)_startPlaybackProgressNotifications;
-(void)_stopPlaybackProgressNotifications;
-(void)_sendProgressNotification:(id)notification;
-(void)_daemonUpdatedStatus;
-(void)_daemonUpdatedMetaData;
-(void)_daemonUpdatedArtwork;
-(void)_daemonUpdatedProgress;
-(void)_daemonPostedDACPError;
-(void)_notificationDACPError:(id)error;
-(void)_notificationOnOffToggleDidChange:(id)_notificationOnOffToggle;
-(void)_notificationPasswordDidChange:(id)_notificationPassword;
-(void)_notificationDeviceNamedChanged:(id)changed;
-(void)_notificationOtherPlayers:(id)players;
-(void)_notificationSWUpdateApplyStarted:(id)started;
-(void)_notificationSWUpdateApplyFailed:(id)failed;
-(BOOL)_setDaemonPreference:(id)preference value:(id)value;
@end

@interface MEAirTunesPlayer (PlaybackControl)
-(BOOL)_handleStopActionWithError:(id*)error;
-(BOOL)_handlePauseActionWithError:(id*)error;
-(BOOL)_handlePlayActionWithError:(id*)error;
-(BOOL)_handleRateChangeState:(int)state withError:(id*)error;
-(void)_setNewState:(int)state;
@end

@interface MEAirTunesPlayer (Rules)
-(BOOL)_isAllowedToPlay;
@end

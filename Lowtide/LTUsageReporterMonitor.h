/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "LTUsageReporterMonitor.h"
#import <BackRow/BRSingleton.h>

@protocol BRMediaAsset;

@interface LTUsageReporterMonitor : BRSingleton {
	id<BRMediaAsset> _currentAsset;
	unsigned _playbackStalledCount;
}
+(id)singleton;
+(void)setSingleton:(id)singleton;
-(void)dealloc;
-(id)init;
@end

@interface LTUsageReporterMonitor (Private)
-(void)_resetPlaybackStalledCountAndAssetFromPlayerIfNeeded:(id)playerIfNeeded;
@end

@interface LTUsageReporterMonitor (Notifications)
-(void)_currentAssetPlaybackStalled:(id)stalled;
-(void)_currentAssetPlaybackChanged:(id)changed;
-(void)_homeSharesChanged:(id)changed;
@end

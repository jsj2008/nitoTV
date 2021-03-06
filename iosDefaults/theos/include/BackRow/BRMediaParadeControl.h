/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/BackRow.framework/BackRow
 */

#import "BackRow-Structs.h"
#import "BRControl.h"

@class BRMediaParadeLayer, BRMediaParadeProvider;

@interface BRMediaParadeControl : BRControl {
@private
	BRMediaParadeLayer *_layer;	// 40 = 0x28
	BRMediaParadeProvider *_provider;	// 44 = 0x2c
	BOOL _waitingForQueue;	// 48 = 0x30
	BOOL _pumpPrimed;	// 49 = 0x31
}
- (id)init;	// 0x315ac23d
- (void)_queueReady:(id)ready;	// 0x315ad5c1
- (void)_startFeeding;	// 0x315ad5e9
- (void)_startFeedingWhenQueueReady;	// 0x315acc35
- (void)controlWasActivated;	// 0x315acbc1
- (void)controlWasDeactivated;	// 0x315ae099
- (void)dealloc;	// 0x315ad3f1
- (void)setDeletterboxAssetArtwork:(BOOL)artwork;	// 0x315acb81
- (void)setImageProxies:(id)proxies;	// 0x315eeae1
@end


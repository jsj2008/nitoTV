/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/BackRow.framework/BackRow
 */

#import "BackRow-Structs.h"
#import "BRControl.h"

@class NSMutableDictionary, NSArray, BRWaitSpinnerControl, NSString, BRImage;

__attribute__((visibility("hidden")))
@interface BRTransportLayer : BRControl {
@private
	BOOL _zeroDuration;	// 38 = 0x26
	float _percentComplete;	// 40 = 0x28
	NSRange _downloadedRange;	// 44 = 0x2c
	int _currentState;	// 52 = 0x34
	NSString *_currentChapter;	// 56 = 0x38
	NSMutableDictionary *_cachedImages;	// 60 = 0x3c
	CGRect _leftEndCapBounds;	// 64 = 0x40
	CGRect _rightEndCapBounds;	// 80 = 0x50
	BRImage *_leftEndCap;	// 96 = 0x60
	BRImage *_rightEndCap;	// 100 = 0x64
	CGRect _leftProgressEndCapBounds;	// 104 = 0x68
	CGRect _rightProgressEndCapBounds;	// 120 = 0x78
	BRImage *_leftProgressEndCap;	// 136 = 0x88
	BRImage *_rightProgressEndCap;	// 140 = 0x8c
	BRImage *_leftProgressUnbufferedEndCap;	// 144 = 0x90
	CGRect _rightUnbufferedFillBounds;	// 148 = 0x94
	BRImage *_rightUnbufferedFill;	// 164 = 0xa4
	CGRect _whiteFillBounds;	// 168 = 0xa8
	BRImage *_whiteFill;	// 184 = 0xb8
	CGRect _emptyBufferBounds;	// 188 = 0xbc
	BRImage *_emptyBuffer;	// 204 = 0xcc
	CGRect _blueAlreadyPlayedBounds;	// 208 = 0xd0
	BRImage *_blueAlreadyPlayed;	// 224 = 0xe0
	CGRect _chapterMarkerBounds;	// 228 = 0xe4
	NSArray *_chapterMarkers;	// 244 = 0xf4
	float _temporaryMarkerPositionPercentage;	// 248 = 0xf8
	BOOL _showChapterMarkers;	// 252 = 0xfc
	CGRect _playheadBounds;	// 256 = 0x100
	BRImage *_playhead;	// 272 = 0x110
	CGSize _dynamicBounds;	// 276 = 0x114
	CGSize _staticBounds;	// 284 = 0x11c
	BRWaitSpinnerControl *_spinner;	// 292 = 0x124
}
@property(assign) BOOL showChapterMarks;	// G=0x31606009; S=0x31606041; converted property
- (id)init;	// 0x315a9485
- (id)_cachedImageForName:(id)name;	// 0x315a967d
- (void)_drawChapterMarkersInContext:(CGContextRef)context;	// 0x31606101
- (id)_loadImageForName:(id)name;	// 0x315a96dd
- (void)_updateDynamicFrames;	// 0x315a978d
- (void)_updateLeftEnd;	// 0x315a9b71
- (void)_updateStaticFrames;	// 0x315a9c7d
- (void)dealloc;	// 0x315ab875
- (void)drawInContext:(CGContextRef)context;	// 0x315aaf45
- (void)layoutSubcontrols;	// 0x31606019
- (float)playheadPosition;	// 0x315aaec1
- (CGRect)rightEndCapFrame;	// 0x315aae49
- (void)setChapterMarkers:(id)markers withTemporaryMarker:(float)temporaryMarker;	// 0x31606061
- (void)setDownloadedRange:(NSRange)range;	// 0x315a9741
- (void)setPercentComplete:(float)complete;	// 0x315aa751
// converted property setter: - (void)setShowChapterMarks:(BOOL)marks;	// 0x31606041
- (void)setState:(int)state;	// 0x315aa31d
- (void)setZeroDuration:(BOOL)duration;	// 0x316060c5
// converted property getter: - (BOOL)showChapterMarks;	// 0x31606009
@end


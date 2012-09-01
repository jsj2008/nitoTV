/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/BackRow.framework/BackRow
 */

#import "BRControlFactory.h"

@class BRMediaType;

@interface BRMediaPreviewControlFactory : NSObject <BRControlFactory> {
@private
	BRMediaType *_missingType;	// 4 = 0x4
	BOOL _deletterboxArtwork;	// 8 = 0x8
	BOOL _shouldShowMetadata;	// 9 = 0x9
	BOOL _showMetadataImmediately;	// 10 = 0xa
}
@property(retain) BRMediaType *missingType;	// G=0x315d7821; S=0x315d7aa9; converted property
@property(assign) BOOL previewShouldShowMetadata;	// G=0x315d7841; S=0x315d7831; converted property
@property(assign) BOOL previewShouldShowMetadataImmediately;	// G=0x315d7861; S=0x315d7851; converted property
@property(assign) BOOL shouldDeletterboxArtwork;	// G=0x315d7881; S=0x315d7871; converted property
+ (id)factory;	// 0x315d7c59
- (id)init;	// 0x315d7bf1
- (id)_coverArtControllerForAssets:(id)assets;	// 0x315d79a9
- (id)_filterProxies:(id)proxies;	// 0x315d7c99
- (id)_metadataControllerForAsset:(id)asset;	// 0x315d791d
- (id)_paradeControllerForAssets:(id)assets;	// 0x315d7891
- (id)controlForData:(id)data currentControl:(id)control requestedBy:(id)by;	// 0x315d8275
- (void)dealloc;	// 0x315d7ba9
// converted property getter: - (id)missingType;	// 0x315d7821
- (id)previewControlForAsset:(id)asset;	// 0x315d7b6d
- (id)previewControlForAssets:(id)assets;	// 0x315d7e81
- (id)previewControlForImageProxies:(id)imageProxies;	// 0x315d8129
- (id)previewControlForImageProxy:(id)imageProxy;	// 0x315d7ae1
// converted property getter: - (BOOL)previewShouldShowMetadata;	// 0x315d7841
// converted property getter: - (BOOL)previewShouldShowMetadataImmediately;	// 0x315d7861
// converted property setter: - (void)setMissingType:(id)type;	// 0x315d7aa9
// converted property setter: - (void)setPreviewShouldShowMetadata:(BOOL)showMetadata;	// 0x315d7831
// converted property setter: - (void)setPreviewShouldShowMetadataImmediately:(BOOL)showMetadataImmediately;	// 0x315d7851
// converted property setter: - (void)setShouldDeletterboxArtwork:(BOOL)deletterboxArtwork;	// 0x315d7871
// converted property getter: - (BOOL)shouldDeletterboxArtwork;	// 0x315d7881
@end

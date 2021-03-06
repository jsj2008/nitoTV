/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "BRImageProxy.h"
#import <Foundation/NSObject.h>

@class MEAirTunesMediaAsset;

@interface MEAirTunesImageProxy : NSObject <BRImageProxy> {
	MEAirTunesMediaAsset* _asset;
}
+(id)imageProxyWithAsset:(id)asset;
-(id)initWithAsset:(id)asset;
-(void)dealloc;
-(id)imageIDForImageSize:(int)imageSize;
-(id)imageForImageSize:(int)imageSize;
-(id)defaultImageForImageSize:(int)imageSize;
-(BOOL)supportsImageForImageSize:(int)imageSize;
-(void)cancelImageRequestsForImageSizes:(int)imageSizes;
-(id)object;
@end


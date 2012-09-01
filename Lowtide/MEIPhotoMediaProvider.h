/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "MEITunesBaseMediaProvider.h"
#import "MEIPhotoMediaProvider.h"
#import "Lowtide-Structs.h"

@class NSMutableArray;

@interface MEIPhotoMediaProvider : MEITunesBaseMediaProvider {
	ITImageLibrary* _imageLibrary;
	NSMutableArray* _photoCollections;
	NSMutableArray* _photoAssets;
	unsigned long long _pairingGUID;
}
-(id)initWithLibrary:(id)library;
-(void)dealloc;
-(ITImageLibrary*)imageLibrary;
-(BOOL)isLocal;
-(id)mediaTypes;
-(void)photoDatabaseUpdated;
-(int)load;
-(int)unload;
-(id)mediaForEntityName:(id)entityName;
-(id)providerLabel;
-(void)setPairingGUID:(unsigned long long)guid;
-(unsigned long long)pairingGUID;
@end

@interface MEIPhotoMediaProvider (Private)
-(void)_loadLibrary:(ITImageLibrary*)library;
@end

/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import <Foundation/NSObject.h>

@class NSString;

@interface LTFairPlayInfo : NSObject {
	id _sessionToken;
	NSString* _keyBagPath;
}
+(id)infoWithToken:(id)token keyBagPath:(id)path;
-(id)initWithToken:(id)token keyBagPath:(id)path;
-(void)dealloc;
-(id)description;
-(id)sessionToken;
-(id)keyBagPath;
@end


/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import <BackRow/BRAccount.h>
#import "MEITunesAccount.h"

@class NSDate, NSDictionary;

@interface MEITunesAccount : BRAccount {
	NSDate* _lastAuthenticationDate;
	NSDictionary* _authDictionary;
}
+(void)initialize;
-(void)dealloc;
-(id)type;
-(BOOL)isPasswordRequired;
-(BOOL)isAuthenticated;
-(void)resetAccountOptions;
-(void)authenticate;
@end

@interface MEITunesAccount (Protected)
-(id)_encryptPassword:(id)password;
-(id)_decryptPassword:(id)password;
@end

@interface MEITunesAccount (Private)
-(void)_setAuthDictionary:(id)dictionary;
@end

@interface MEITunesAccount (Notifications)
-(void)authenticationSucceeded:(id)succeeded;
-(void)authenticationFailed:(id)failed;
-(void)authenticationCancelled:(id)cancelled;
@end

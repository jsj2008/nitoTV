/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "MEITunesAccount.h"


@interface MEITunesStoreAccount : MEITunesAccount {
	BOOL _oneClickTX;
}
-(id)initWithAccountName:(id)accountName;
-(id)initWithCoder:(id)coder;
-(BOOL)shouldAskForPassword:(int)password;
-(void)encodeWithCoder:(id)coder;
-(void)setAutomaticAuthentication:(BOOL)authentication;
-(id)metadataValueForKey:(id)key;
-(id)type;
@end

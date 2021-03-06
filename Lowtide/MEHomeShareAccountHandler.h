/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "Lowtide-Structs.h"
#import <Foundation/NSObject.h>
#import "BRHomeShareHandler.h"


@interface MEHomeShareAccountHandler : NSObject <BRHomeShareHandler> {
}
-(void)enableHomeSharing;
-(void)enableHomeSharingWithAccountName:(id)accountName andPassword:(id)password;
-(void)disableHomeSharing;
-(BOOL)hasHomeShareAccount;
-(BOOL)isHomeSharingEnabled;
-(id)homeSharingGroupIDIsEnabled:(id*)enabled;
-(id)homeShareAccount;
-(long)pairForHomeShareStreamingWithHost:(ATVDataServerRef)host;
-(unsigned long long)pairingGUIDForServer:(ATVDataServerRef)server;
@end


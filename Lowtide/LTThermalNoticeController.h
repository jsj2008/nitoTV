/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

#import "LTThermalNoticeController.h"
#import <BackRow/BRViewController.h>

@class NSTimer;

@interface LTThermalNoticeController : BRViewController {
	NSTimer* _activityTimer;
}
-(id)init;
-(BOOL)brEventAction:(id)action;
-(void)wasPopped;
@end

@interface LTThermalNoticeController (Private)
-(void)_simulateActivity:(id)activity;
@end

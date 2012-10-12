//
//  SMFProgressBarControl.m
//  SoftwareMenuFramework
//
//  Created by Alan Quatermain on 19/04/07.
//  Copyright 2007 AwkwardTV. All rights reserved.
//
//  Updated by nito 08-20-08 - works in 2.x
//  Updated by Thomas 2-2-10 - allows for different aspect Ratios


//#import "SMFProgressBarControl.h"
//@implementation SMFProgressBarControl


static char const * const kSMFWidgetKey = "progressWidget";
static float _maxValue = 100.0f;
static float _minValue = 0.0f;


%subclass SMFProgressBarControl : BRControl

- (id) init
{
	self = %orig;
	
	Class brpbw = %c(BRProgressBarWidget);
	if (brpbw == nil) brpbw = objc_getClass("BRProgressBarWidget");
	
    id widget = [[brpbw alloc] init];
	
	[self setWidget:widget];
	
	if ([self respondsToSelector:@selector(addControl:)])
	{
		[self addControl: widget];

	} else { //should respond to addSubview:
		
		[self addSubview: widget];
	}
	
   
    // defaults
    _maxValue = 100.0f;
    _minValue = 0.0f;
	
    return self;
}

- (id)widget { return [self associatedValueForKey:(void*)kSMFWidgetKey]; }

- (void)setWidget:(id)theWidget { [self associateValue:theWidget withKey:(void*)kSMFWidgetKey]; }

- (void) dealloc
{
  //  [_widget release];
    
	
    %orig;
}

- (void) setFrame: (CGRect) frame
{
    %orig;
	
    CGRect widgetFrame;// = CGRectZero;
    widgetFrame.origin.x = 0.0f;
    widgetFrame.origin.y = 0.0f;
    widgetFrame.size.width = frame.size.width;
    widgetFrame.size.height = ceilf( frame.size.width * 0.1f );
    if (frame.size.height>widgetFrame.size.height) {
        widgetFrame.origin.y=widgetFrame.origin.y+ceilf((frame.size.height-widgetFrame.size.height)/2.f);
    }
    [[self widget] setFrame: widgetFrame];
}



- (void) setMaxValue: (float) maxValue
{
    @synchronized(self)
    {
        _maxValue = maxValue;
    }
}

- (float) maxValue
{
    return ( _maxValue );
}

- (void) setMinValue: (float) minValue
{
    @synchronized(self)
    {
        _minValue = minValue;
    }
}

- (float) minValue
{
    return ( _minValue );
}

- (void) setCurrentValue: (float) currentValue
{
    @synchronized(self)
    {
        float range = _maxValue - _minValue;
        float value = currentValue - _minValue;
        float percentage = (value / range) * 100.0f;
        [[self widget] setPercentage: percentage];
    }
}

- (float) currentValue
{
    float result = 0.0f;

    @synchronized(self)
    {
        float percentage = [[self widget] percentage];
        float range = _maxValue - _minValue;
        result = (percentage / 100.0f) * range;
    }

    return ( result );
}

- (void) setPercentage: (float) percentage
{
    [[self widget] setPercentage: percentage];
}

- (float) percentage
{
    return ( [[self widget] percentage] );
}

%end

//@end
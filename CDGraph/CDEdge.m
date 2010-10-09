//
//  CDEdge.m
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

#import "CDEdge.h"


@implementation CDEdge

-(id)init {
	[super init];
	weight = 0.0;
	return self;
}

-(void)dealloc
{
	[source autorelease];
	[target autorelease];
	[super dealloc];
}

@synthesize source;

@synthesize target;

@synthesize weight;

@end

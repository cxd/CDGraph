//
//  TestObject.m
//  CDGraph
//
//  Created by Chris Davey on 10/12/08.
//  Copyright 2008 none. All rights reserved.
//

#import "TestObject.h"


@implementation TestObject

-(void)dealloc
{
	[data autorelease];	
	[super dealloc];
}

@synthesize data;

@end

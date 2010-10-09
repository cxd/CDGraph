//
//  StackNode.m
//  CDGraph
//
//  Created by Chris Davey on 4/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDLinkedNode.h"


@implementation CDLinkedNode

@synthesize data;
@synthesize link;

-(id)init
{
	[super init];
	return self;
}

-(id)initWithData:(NSObject *)objData
{
	[super init];
	data = objData;
	[data retain];
	return self;
}

-(void)dealloc
{
	[data autorelease];
	[link autorelease];
	[super dealloc];
}



@end

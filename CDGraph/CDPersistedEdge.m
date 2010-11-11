//
//  CDPersistedEdge.m
//  CDGraph
//
//  Created by Chris Davey on 10/11/10.
//  Copyright 2010 none. All rights reserved.
//

#import "CDPersistedEdge.h"


@implementation CDPersistedEdge

@synthesize sourceIdx;
@synthesize targetIdx;
@synthesize data;

-(id)init {
	self = [super init];
	return self;
}

-(void)dealloc {

	if (self.data != nil)
	{
		[self.data autorelease];
	}
	[super dealloc];
}

-(void) encodeWithCoder: (NSCoder *) encoder
{
	[encoder encodeInt:self.sourceIdx forKey:@"sourceIdx"];
	[encoder encodeInt:self.targetIdx forKey:@"targetIdx"];
	[encoder encodeObject:self.data forKey:@"data"];
}


-(id) initWithCoder: (NSCoder *) decoder
{
	self.sourceIdx = [decoder decodeIntForKey:@"sourceIdx"];
	self.targetIdx = [decoder decodeIntForKey:@"targetIdx"];
	self.data = [decoder decodeObjectForKey:@"data"];
	return self;
}

@end

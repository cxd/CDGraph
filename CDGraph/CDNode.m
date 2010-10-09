//
//  CDNode.m
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

#import "CDNode.h"


@implementation CDNode

/**
 Public data accessor.
 **/
@synthesize data;

/**
 Public neighbours accessor.
 **/
@synthesize neighbours;

/*
 Public visited accessor.
 */
@synthesize visited;

-(id)init {
	[super init];
	neighbours = [[NSMutableArray alloc] init];
	[neighbours retain];
	return self;
}

-(void)dealloc {
	if ([neighbours count] > 0)
	{
		for(CDNode *node in neighbours)
		{
			[neighbours removeObject:(id)node];
			[node autorelease];
		}
	}
	[neighbours release];
	[data autorelease];
	[super dealloc];
}

-(id)initWithData:(NSObject *)userData
{
	[self init];
	self.data = userData; 
	[self.data retain];
	return self;
}

-(void)addNeighbour:(CDNode *)node {
	[neighbours addObject:(id)node];
	[node retain];
}

-(void)removeNeighbour:(CDNode *)node {
	[neighbours removeObject:(id)node];
	[node autorelease];
}

-(CDNode*)findNeighbour:(NSObject *)objData {
	for(CDNode* neighbour in neighbours) {
		if ([neighbour.data isEqual:(id)objData]) {
			return neighbour;
		}
	}
	return nil;
}

// implementations for NSCoder
-(void) encodeWithCoder: (NSCoder *)encoder
{
	[encoder encodeObject: (id) data forKey: @"data"];
	[encoder encodeObject:(id)neighbours forKey: @"neighbours"];
}

-(id) initWithCoder: (NSCoder *) decoder
{
	data = [[decoder decodeObjectForKey:@"data"] retain];
	neighbours = [[decoder decodeObjectForKey:@"neighbours"] retain];
	return self;
}

// implementation of NSCopying using the archiver
-(id) copyWithZone: (NSZone *)zone
{
	NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:(id)self];
	CDNode * copy = [NSKeyedUnarchiver unarchiveObjectWithData: archive];
	return copy;
}



@end

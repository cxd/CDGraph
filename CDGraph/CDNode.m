//
//  CDNode.m
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the CDGraphLib nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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
}

-(id) initWithCoder: (NSCoder *) decoder
{
	data = [[decoder decodeObjectForKey:@"data"] retain];
	neighbours = [[NSMutableArray alloc] init];
	[neighbours retain];
	return self;
}

// implementation of NSCopying using the archiver
-(id) copyWithZone: (NSZone *)zone
{
	NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:(id)self];
	CDNode * copy = [NSKeyedUnarchiver unarchiveObjectWithData: archive];
	return [copy retain];
}



@end

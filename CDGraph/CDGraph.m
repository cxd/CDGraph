//
//  CDGraph.m
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

#import "CDGraph.h"
#import "CDEdge.h"

@implementation CDGraph


@synthesize nodes;

@synthesize edges;

@synthesize isBidirectional;

-(id)init {
	[super init];
	self.nodes = [[NSMutableArray alloc] init];
	self.edges = [[NSMutableArray alloc] init];
	return self;
}

-(void)dealloc 
{
	[self.edges removeAllObjects];
	[self.edges autorelease];
	[self.nodes removeAllObjects];
	[self.nodes autorelease];
	[super dealloc];
	
}


-(CDNode *)add:(NSObject *)objData {
	id node = [[CDNode alloc] init];
	[node setData:(id) objData];
	// add it to the array.
	[self.nodes addObject:node];
	return [node autorelease];
}

/**
 Remove a node where the predicate is true for the node data element.
 **/
-(CDNode *)remove:(NSPredicate *) predicate {
	CDNode* match = [self find:predicate];
	if (match != nil) {
		// disconnect the node from any neighbours it might have.
		for(CDNode *neighbour in match.neighbours)
		{
			[self disconnect:match to:neighbour];	
		}
		[self.nodes removeObject:(id)match];
	}
	return match;
}

/**
 Remove an existing node.
 The node supplied to this method must be a member of the nodes in the graph.
 **/
-(BOOL)removeNode:(CDNode *)node {
	CDNode *match = nil;
	for(CDNode *n in self.nodes)
	{
		if ([n isEqual:(id)node])
		{
			match = n;
			break;
		}
	}
	if (match == nil) return NO;
	// disconnect the node from any neighbours it might have.
	NSArray *connections = [NSArray arrayWithArray:match.neighbours];
	for(CDNode *neighbour in connections)
	{
		[self disconnect:match to:neighbour];	
	}
	// remove all incoming edges.
	connections = [self findIncomingEdges:match];
	for(CDEdge *edge in connections)
	{
		[self disconnect:edge.source to:edge.target];	
	}
	[self.nodes removeObject:(id)match];
	return YES;
}

-(CDNode*)find:(NSPredicate *)predicate {
	CDNode *test;
	for(test in self.nodes) {
		if ([predicate evaluateWithObject:(id)test.data]) {
			return test;
		}
	}
	return nil;
}

/**
 Find a node using testing for whether the id of the supplied
 object is equal to the data objects id in the node.
 **/
-(CDNode*)findNodeFor:(id)data
{
	for(CDNode *node in self.nodes)
	{
		if ([node.data isEqual:(id)data])
			return node;
	}
	return nil;
}


-(CDEdge *)connect:(CDNode *)nodeFrom to:(CDNode *)nodeTo {
	CDEdge *edge = [[CDEdge alloc] init];
	edge.source = nodeFrom;
	edge.target = nodeTo;
	[self.edges addObject:(id)edge];
	[nodeFrom addNeighbour:(CDNode *) nodeTo];
	CDEdge* tmp =(CDEdge*) edge;
	[edge autorelease];
	if (self.isBidirectional) {
		edge = [[CDEdge alloc] init];
		edge.source = nodeTo;
		edge.target = nodeFrom;
		[self.edges addObject:(id)edge];
		[nodeTo addNeighbour:(CDNode*)nodeFrom];
		[edge autorelease];
	}
	return (CDEdge*)tmp;
}

-(CDEdge*)disconnect:(CDNode *)nodeFrom to:(CDNode *)nodeTo {
	CDEdge *edge = [self findEdge:nodeFrom to:nodeTo];
	if (edge == nil) return nil;
	CDEdge* tmp = (CDEdge*)edge;
	[nodeFrom.neighbours removeObject:(id)nodeTo];
	[self.edges removeObject:(id)edge];
	if (self.isBidirectional) {
		edge = [self findEdge:nodeTo to:nodeFrom];
		if (edge == nil) return tmp;
		[nodeTo.neighbours removeObject:(id)nodeFrom];
		[self.edges removeObject:(id)edge];
	}
	return tmp;
}

-(CDEdge*)findEdge:(CDNode *)nodeFrom to:(CDNode *)nodeTo {
	for(CDEdge *edge in self.edges) {
		if (([edge.source isEqual:(id)nodeFrom])&&
			([edge.target isEqual:(id)nodeTo])) {
			return edge;	
		}
	}
	return nil;
}

/**
 Find the index of the given node.
 **/
-(int)findIndex:(CDNode *)node
{
	int i = 0;
	for(CDNode *other in self.nodes)
	{
		if ([other isEqual:(id)node])
			return i;
		i++;
	}
	return -1;
}

/**
 Find all edges from this node.
 **/
-(NSMutableArray *)findEdges:(CDNode *)nodeFrom
{
	NSMutableArray *set = [[NSMutableArray alloc] init];
	for(CDEdge * edge in self.edges)
	{
		if ([edge.source isEqual:(id)nodeFrom])
		{
			[set addObject:edge];	
		}
	}
	return [set autorelease];
}

/**
 Locate the set of incoming connections from other nodes.
 **/
-(NSMutableArray *)findIncomingEdges:(CDNode *)target
{
	NSMutableArray *set = [[NSMutableArray alloc] init];
	for(CDEdge * edge in self.edges)
	{
		if ([edge.target isEqual:(id)target])
		{
			[set addObject:edge];	
		}
	}
	return [set autorelease];
}


// NSCoding protocol implementation.
-(void) encodeWithCoder: (NSCoder *) encoder
{
	[encoder encodeBool: self.isBidirectional forKey: @"isBidirectional"];
	// save all nodes.
	[encoder encodeObject: (id) self.nodes forKey: @"nodes"];
	// create a set of persisted edges.
	int i=0;
	NSMutableArray *adjacentSet = [[NSMutableArray alloc] init];
	for(CDNode *node in self.nodes)
	{
		[adjacentSet addObjectsFromArray:
		 [self convertNeigboursForEncoding:node atIndex:i]];
		i++;
	}
	[encoder encodeObject:adjacentSet forKey:@"adjacentSet"];
	[adjacentSet autorelease];
}

/**
 Convert all the neighbours into a persistent edge.
 **/
-(NSMutableArray *)convertNeigboursForEncoding:(CDNode *)node atIndex:(int)n
{
	NSMutableArray *set = [[NSMutableArray alloc] init];
	for(CDNode *next in node.neighbours)
	{
		int i = [self findIndex:next];
		if (i < 0)
			continue;
		CDPersistedEdge *edge = [[CDPersistedEdge alloc] init];
		edge.sourceIdx = n;
		edge.targetIdx = i;
		[set addObject:edge];
		[edge autorelease];
	}
	return [set autorelease];
}

-(id) initWithCoder: (NSCoder *) decoder 
{

	self.isBidirectional = [decoder decodeBoolForKey: @"isBidirectional"];
	self.nodes = [[decoder decodeObjectForKey: @"nodes"] retain];
	self.edges = [[NSMutableArray alloc] init];
	NSMutableArray* adjacentSet = [decoder decodeObjectForKey:@"adjacentSet"];
	for(CDPersistedEdge *p in adjacentSet)
	{
		CDNode *source = [self.nodes objectAtIndex:p.sourceIdx];
		CDNode *dest = [self.nodes objectAtIndex:p.targetIdx];
		[self connect:source to:dest];
	}
	return self;
}

// implementation of NSCopying using archiver to create a deep copy.
-(id)copyWithZone: (NSZone *) zone
{
	NSData *archive = [NSKeyedArchiver archivedDataWithRootObject: self];
	CDGraph *copy = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	return [copy retain];
}

@end




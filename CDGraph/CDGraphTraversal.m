//
//  CDGraphTraversal.m
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the CDGraphLib nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "CDGraphTraversal.h"

/**
 Objective-C does not define method accessor modifiers.
 Instead use a Category to group private methods outside of the header file.
 This way private implementation is not exported with the interface.
 **/
@interface CDGraphTraversal(Private)
/**
 Perform depth first traversal
 **/
-(void)traverseDepthFirst;
/**
 Perform breadth first traversal.
 **/
-(void)traverseBreadthFirst;
@end


@implementation CDGraphTraversal

@synthesize order;

@synthesize visitorInstance;

@synthesize graph;

-(id)init
{
	order = DepthFirst;
	return self;
}

-(void)dealloc
{
	[self.graph autorelease];
	[super dealloc];	
}

-(void)traverse:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *)g
{
	visitorInstance = visitor;
	self.graph = g;
	switch (order) {
		case DepthFirst:
			[self traverseDepthFirst];
			break;
		default:
			[self traverseBreadthFirst];
			break;
	}
}

-(void)traverse:(CDTraverseOrder) o visitorInstance:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *) g
{
	self.order = order;
	[self traverse: visitor graphInstance:g];
}


-(void)traverseDepthFirst
{
	if ([self.graph.nodes count] == 0)
		return;
	CDNode *walker;
	CDNode *node;
	for(node in self.graph.nodes)
	{
		node.visited = NO;	
	}
	NSMutableSet *set = [[NSMutableSet alloc] init];
	CDStack *stack = [[CDStack alloc] init];
	
	for(node in self.graph.nodes)
	{
		// process nodes that have not been included.
		if (node.visited)
			continue;
		if ([set containsObject:(id)node])
			continue;
		[stack push:node];
		[set addObject:(id)node];
		while(![stack isEmpty])
		{
			walker = (CDNode*)[stack pop];
			[visitorInstance visit:walker];
			walker.visited = YES;
			CDNode *peer;
			for(peer in walker.neighbours)
			{
				if ([set containsObject:(id)peer])
					continue;
				if (peer.visited)
					continue;
				[stack push:peer];
				[set addObject:(id)peer];
			}
		}
	}
	[set removeAllObjects];
	[stack autorelease];
	[set autorelease];
}

-(void)traverseBreadthFirst
{
	if ([self.graph.nodes count] == 0)
		return;
	CDNode *node;
	for(node in self.graph.nodes)
	{
		node.visited = NO;	
	}
	NSMutableSet *set = [[NSMutableSet alloc] init];
	
	CDQueue *queue = [[CDQueue alloc] init];
	
	for(node in graph.nodes)
	{
		if (node.visited)
			continue;
		if ([set containsObject:(id)node])
			continue;
		[queue enqueue:node];
		[set addObject:(id)node];
		while(![queue isEmpty])
		{
			CDNode *current = (CDNode *)[queue dequeue];	
			[visitorInstance visit:current];
			current.visited = YES;
			for(CDNode *next in current.neighbours)
			{
				if (next.visited)
					continue;
				if ([set containsObject: next])
					continue;
				[queue enqueue:next];
				[set addObject:(id)next];
			}
		}
		
	}
	[queue clear];
	[set removeAllObjects];
	[set autorelease];
	[queue autorelease];
}


@end

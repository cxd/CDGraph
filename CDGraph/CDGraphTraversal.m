//
//  CDGraphTraversal.m
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
//  Copyright 2009 none. All rights reserved.
//

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
	[graph autorelease];
	[super dealloc];	
}

-(void)traverse:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *)g
{
	visitorInstance = visitor;
	graph = g;
	[graph retain];
	switch (order) {
		case DepthFirst:
			[self traverseDepthFirst];
			break;
		default:
			[self traverseBreadthFirst];
			break;
	}
	[graph autorelease];
}

-(void)traverse:(CDTraverseOrder) o visitorInstance:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *) g
{
	self.order = order;
	[self traverse: visitor graphInstance:graph];
}


-(void)traverseDepthFirst
{
	if ([graph.nodes count] == 0)
		return;
	CDNode *walker;
	CDNode *node;
	for(node in self.graph.nodes)
	{
		node.visited = NO;	
	}
	NSMutableSet *set = [[NSMutableSet alloc] init];
	[set retain];
	CDStack *stack = [[CDStack alloc] init];
	[stack retain];
	
	for(node in walker.neighbours)
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
	[stack release];
	[set release];
}

-(void)traverseBreadthFirst
{
	if ([graph.nodes count] == 0)
		return;
	CDNode *node;
	for(node in self.graph.nodes)
	{
		node.visited = NO;	
	}
	NSMutableSet *set = [[NSMutableSet alloc] init];
	[set retain];
	
	CDQueue *queue = [[CDQueue alloc] init];
	[queue retain];
	
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
	[set release];
	[queue release];
}


@end

//
//  CDGraph.m
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

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
	for(CDEdge* edge in self.edges)
	{
		[edge autorelease];	
	}
	[self.edges removeAllObjects];
	[self.edges autorelease];
	for(CDNode* node in self.nodes)
	{
		[node autorelease];	
	}
	[self.nodes removeAllObjects];
	[self.nodes autorelease];
	[super dealloc];
	
}


-(CDNode *)add:(NSObject *)objData {
	id node = [[CDNode alloc] init];
	[node retain];
	[node setData:(id) objData];
	// add it to the array.
	[self.nodes addObject:node];
	return node;
}

/**
 Remove a node where the predicate is true for the node data element.
 **/
-(CDNode *)remove:(NSPredicate *) predicate {
	CDNode* match = [self find:predicate];
	if (match != nil) {
		[match autorelease];
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
	[edge retain];
	edge.source = nodeFrom;
	edge.target = nodeTo;
	[self.edges addObject:(id)edge];
	[nodeFrom addNeighbour:(CDNode *) nodeTo];
	CDEdge* tmp =(CDEdge*) edge;
	if (self.isBidirectional) {
		edge = [[CDEdge alloc] init];
		edge.source = nodeTo;
		edge.target = nodeFrom;
		[self.edges addObject:(id)edge];
		[nodeTo addNeighbour:(CDNode*)nodeFrom];
	}
	return (CDEdge*)tmp;
}

-(CDEdge*)disconnect:(CDNode *)nodeFrom to:(CDNode *)nodeTo {
	CDEdge *edge = [self findEdge:nodeFrom to:nodeTo];
	if (edge == nil) return nil;
	CDEdge* tmp = (CDEdge*)edge;
	[nodeFrom.neighbours removeObject:(id)nodeTo];
	[self.edges removeObject:(id)edge];
	[edge release];
	if (self.isBidirectional) {
		edge = [self findEdge:nodeTo to:nodeFrom];
		if (edge == nil) return tmp;
		[nodeTo.neighbours removeObject:(id)nodeFrom];
		[self.edges removeObject:(id)edge];
		[edge release];
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
	return set;
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
	return set;
}


// NSCoding protocol implementation.
-(void) encodeWithCoder: (NSCoder *) encoder
{
	[encoder encodeBool: self.isBidirectional forKey: @"isBidirectional"];
	[encoder encodeObject: (id) self.nodes forKey: @"nodes"];
	[encoder encodeObject: (id) self.edges forKey: @"edges"];
}

-(id) initWithCoder: (NSCoder *) decoder 
{

	self.isBidirectional = [decoder decodeBoolForKey: @"isBidirectional"];
	self.nodes = [[decoder decodeObjectForKey: @"nodes"] retain];
	self.edges = [[decoder decodeObjectForKey: @"edges"] retain];
	return self;
}

// implementation of NSCopying using archiver to create a deep copy.
-(id)copyWithZone: (NSZone *) zone
{
	NSData *archive = [NSKeyedArchiver archivedDataWithRootObject: self];
	CDGraph *copy = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
	return copy;
}

@end




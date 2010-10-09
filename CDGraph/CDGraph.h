//
//  CDGraph.h
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDNode.h"
#import "CDEdge.h"

/*
 TODO: implement alloc and dealloc methods
 to initialise arrays and release arrays containing existing data.
 */

@interface CDGraph : NSObject <NSCoding, NSCopying> {

	NSMutableArray *nodes;
	
	NSMutableArray *edges;
	
	BOOL isBidirectional;
	
}

@property(retain) NSMutableArray *nodes;

@property(retain) NSMutableArray *edges;

@property(assign) BOOL isBidirectional;

-(void)dealloc;

-(CDNode *)add:(NSObject *)objData;

/**
 Remove a node where the predicate is true for the node data element.
 **/
-(CDNode *)remove:(NSPredicate *)predicate;

/**
 Remove an existing node.
 **/
-(BOOL)removeNode:(CDNode *)node;

/**
 Find a node using a predicate.
 **/
-(CDNode*)find:(NSPredicate *)predicate;

/**
 Find a node using testing for whether the id of the supplied
 object is equal to the data objects id in the node.
 **/
-(CDNode*)findNodeFor:(id)data;

-(CDEdge*)connect:(CDNode *)nodeFrom to:(CDNode *)nodeTo;

-(CDEdge*)disconnect:(CDNode *)nodeFrom to:(CDNode *)nodeTo;

-(CDEdge*)findEdge:(CDNode *)nodeFrom to:(CDNode *)nodeTo;

/**
 Find all edges from this node.
 **/
-(NSMutableArray *)findEdges:(CDNode *)nodeFrom;

/**
 Locate the set of incoming connections from other nodes.
 **/
-(NSMutableArray *)findIncomingEdges:(CDNode *)target;

-(void) encodeWithCoder: (NSCoder *) encoder;
-(id) initWithCoder: (NSCoder *) decoder;
-(id) copyWithZone: (NSZone *)zone;

@end

//
//  CDGraph.h
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

#import <Foundation/Foundation.h>
#import "CDNode.h"
#import "CDEdge.h"
#import "CDPersistedEdge.h"


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
 Find a node using a block predicate.
 **/
-(CDNode *)findWith:(BOOL (^)(CDNode *node)) predicate;

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

/**
 Convert all the neighbours into a persistent edge.
 **/
-(NSMutableArray *)convertNeigboursForEncoding:(CDNode *)node atIndex:(int)n;
@end

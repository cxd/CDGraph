//
//  CDPersistedEdge.h
//  CDGraph
//
//  Created by Chris Davey on 10/11/10.
//  Copyright 2010 none. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 The persisted edge is used when writing the graph to a file.
 Instead of storing the object resources for edges themselves
 the graph will save a persisted edge class
 that will allow the graph to be reconstructed when it is read back into memory.
 **/
@interface CDPersistedEdge : NSObject<NSCoding> {

	/**
	 The source node index.
	 **/
	int sourceIdx;
	
	/**
	 Target node index
	 **/
	int targetIdx;
	
	/**
	 Any additional data stored for the edge.
	 **/
	NSObject* data;
	
}

/**
 The source node index.
 **/
@property(assign) int sourceIdx;

/**
 Target node index
 **/
@property(assign) int targetIdx;

/**
 Any additional data stored for the edge.
 **/
@property(retain) NSObject* data;


-(void) encodeWithCoder: (NSCoder *) encoder;
-(id) initWithCoder: (NSCoder *) decoder;

@end

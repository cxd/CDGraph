//
//  CDNode.h
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDNode : NSObject <NSCoding, NSCopying> {

	/**
	 A unique identifier for the node.
	 **/
	int uniqueId;
	
	/**
	 Data instance in node.
	 **/
	NSObject *data;
	
	/**
	 Collection of neighbours.
	 **/
	NSMutableArray *neighbours;
	
	/**
	 A flag to indicate whether a node has been visited.
	 **/
	BOOL visited;
	
}

@property(assign) NSObject *data;
@property(assign) NSMutableArray *neighbours;
@property(assign) BOOL visited;
-(void)dealloc;
-(id)initWithData:(NSObject *)userData;
-(void)addNeighbour:(CDNode *)node;
-(void)removeNeighbour:(CDNode *)node;
-(CDNode*)findNeighbour:(NSObject *)userData;


-(void) encodeWithCoder: (NSCoder *) encoder;
-(id) initWithCoder: (NSCoder *) decoder;
-(id) copyWithZone: (NSZone *)zone;

@end

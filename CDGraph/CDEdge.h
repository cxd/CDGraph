//
//  CDEdge.h
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
//  Copyright 2008 none. All rights reserved.
//

#import "CDNode.h"

@interface CDEdge : NSObject {

	CDNode *source;
	
	CDNode *target;
	
	double weight;
	
}

/**
 * Source node.
 **/
@property(assign) CDNode *source;
/**
 * Target node.
 **/
@property(assign) CDNode *target;
/**
 * Weight of connection between nodes.
 **/
@property(assign) double weight;

-(void)dealloc;

@end

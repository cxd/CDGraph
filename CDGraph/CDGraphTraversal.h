//
//  CDGraphTraversal.h
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDGraphVisitor.h"
#import "CDNode.h"
#import "CDGraph.h"
#import "CDStack.h"
#import "CDQueue.h"
#import "CDEnums.h"


@interface CDGraphTraversal : NSObject {
	CDTraverseOrder order;
	id <CDGraphVisitor> visitorInstance;
	CDGraph * graph;	
}


@property(assign) CDTraverseOrder order;
@property(assign) CDGraph * graph;
@property(assign) id <CDGraphVisitor> visitorInstance;

-(void)dealloc;

/**
 Traverse the graph g with the supplied visitor.
 **/
-(void)traverse:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *)g;

/**
 Traverse graph g, with supplied visitor in supplied CDTraverseOrder 
 **/
-(void)traverse:(CDTraverseOrder)o visitorInstance:(id <CDGraphVisitor>) visitor graphInstance:(CDGraph *)g;

@end

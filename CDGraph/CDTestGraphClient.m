//
//  CDTestGraphClient.m
//  CDGraph
//
//  Created by Chris Davey on 22/01/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDTestGraphClient.h"


@implementation CDTestGraphClient


-(BOOL)testGraphFind
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CDGraph *graph = [[CDGraph alloc] init];
	[graph retain];
	TestObject *test = [[TestObject alloc] init];
	test.data = @"TestA";
	[test retain];
	[graph add: test];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"data == %@", @"TestA"];
	CDNode *match = [graph find: predicate];
	BOOL result = [match.data isEqual:(id)test];
	[graph release];
	[test release];
	[pool drain];
	return result;
}


-(BOOL)testFindEdges
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CDGraph* graph = [[CDGraph alloc] init];
	TestObject *cityA = [[TestObject alloc] init];
	TestObject *cityB = [[TestObject alloc] init];
	TestObject *cityC = [[TestObject alloc] init];
	cityA.data = @"Brisbane";
	cityB.data = @"Sydney";
	cityC.data = @"Melbourne";
	[graph add: cityA];
	[graph add: cityB];
	[graph add:cityC];
	CDNode *nodeA = [graph find:[NSPredicate predicateWithFormat: @"data == %@", cityA.data]];
	CDNode *nodeB = [graph find:[NSPredicate predicateWithFormat: @"data == %@", cityB.data]];
	CDNode *nodeC = [graph find:[NSPredicate predicateWithFormat: @"data == %@", cityC.data]];
	[graph connect: nodeA to:nodeB];
	[graph connect: nodeB to:nodeC];
	CDEdge *edgeA = [graph findEdge:nodeA to:nodeB];
	CDEdge *edgeB = [graph findEdge:nodeB to:nodeC];
	CDEdge *noEdge = [graph findEdge:nodeA to:nodeC];
	BOOL result = (edgeA != nil);
	BOOL resultB = (edgeB != nil);
	BOOL resultC = (noEdge == nil);
	[pool drain];
	return (result && resultB && resultC);
}


@end

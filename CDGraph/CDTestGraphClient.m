//
//  CDTestGraphClient.m
//  CDGraph
//
//  Created by Chris Davey on 22/01/09.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the CDGraphLib nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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

//
//  CDQueue.m
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the CDGraphLib nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

#import "CDQueue.h"


@implementation CDQueue

-(void)dealloc
{
	[self clear];
	[super dealloc];
}

/**
 Append an item to the end of the queue.
 **/
-(void)enqueue: (NSObject *)data
{
	if (root == nil)
	{
		root = [[CDLinkedNode alloc] initWithData:(id)data];
		return;
	}
	root.link = [[CDLinkedNode alloc] initWithData:(id)data];
	[root.link retain];
}

/**
 Remove an object from the front of the queue.
 **/
-(NSObject *)dequeue {

	if (root == nil) 
		return nil;
	CDLinkedNode *tmp = root;
	root = root.link;
	[tmp release];
	return tmp.data;
}

/**
 Retrieve an object form the front of the queue without dequeuing it.
 **/
-(NSObject *)front
{
	if (root == nil)
		return nil;
	return root.data;
}

/**
 Retrieve an object from the back of the queue without dequeuing it.
 **/
-(NSObject *)back
{
	if (root == nil) 
		return nil;
	CDLinkedNode *last = root;
	while(last.link != nil)
	{
		last = last.link;	
	}
	return last.data;
}

/**
 Get the number of items in the queue.
 **/
-(int)count
{
	if (root == nil) return 0;
	CDLinkedNode *tmp = root;
	int cnt = 1;
	while(tmp.link != nil)
		++cnt;
	return cnt;
}

/**
 Remove all items from the queue.
 **/
-(void)clear {
	while(root != nil)
		[self dequeue];
}

/**
 Determine if the queue is empty
 **/
-(BOOL)isEmpty
{
	return (root == nil);
}

@end

//
//  CDQueue.m
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
//  Copyright 2009 none. All rights reserved.
//

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

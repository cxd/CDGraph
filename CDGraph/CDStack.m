//
//  Stack.m
//  CDGraph
//
//  Created by Chris Davey on 4/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDStack.h"


@implementation CDStack


-(void)dealloc
{
	[self clear];
	[super dealloc];
}

-(void)push:(NSObject *)data 
{
	[data retain];
	CDLinkedNode *tmp = [[CDLinkedNode alloc] initWithData:(id)data];
	[tmp retain];
	if (root == nil)
	{
		root = tmp;
		return;
	}
	tmp.link = root;
	root = tmp;
}

-(NSObject *)pop
{
	CDLinkedNode *tmp = root;
	root = tmp.link;
	NSObject* data = tmp.data;
	[data autorelease];
	[tmp release];
	return data;
}

-(NSObject *)top
{
	return root.data;
}

-(int) count
{
	CDLinkedNode *next = root;
	int cnt = 0;
	while(next != nil)
	{
		cnt++;
		next = next.link;
	}
	return cnt;
}

-(void)clear
{
	while(root != nil)
	{
		[self pop];
	}
}

-(BOOL)isEmpty
{
	return (root == nil);	
}

@end

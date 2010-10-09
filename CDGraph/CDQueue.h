//
//  CDQueue.h
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CDLinkedNode.h"

@interface CDQueue : NSObject {

	CDLinkedNode * root;
}

-(void)dealloc;

/**
 Append an item to the end of the queue.
 **/
-(void)enqueue: (NSObject *)data;

/**
 Remove an object from the front of the queue.
 **/
-(NSObject *)dequeue;

/**
 Retrieve an object form the front of the queue without dequeuing it.
 **/
-(NSObject *)front;

/**
 Retrieve an object from the back of the queue without dequeuing it.
 **/
-(NSObject *)back;

/**
 Get the number of items in the queue.
 **/
-(int)count;

/**
 Remove all items from the queue.
 **/
-(void)clear;

/**
 Determine if the queue is empty
 **/
-(BOOL)isEmpty;

@end

//
//  Stack.h
//  CDGraph
//
//  Created by Chris Davey on 4/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDLinkedNode.h"

@interface CDStack : NSObject {
	CDLinkedNode* root;
}

-(void)dealloc;
/**
 Push object data onto the top of the stack.
 **/
-(void)push:(NSObject *)data;
/**
 Pop the object data off the top of the stack.
 **/
-(NSObject *)pop;
/**
 Peak at the data at the top of the stack.
 **/
-(NSObject *)top;
/**
 Return a count of the number of items in the stack.
 **/
-(int) count;
/**
 Clear the stack.
 **/
-(void)clear;
/**
 Determine if the stack is empty.
 **/
-(BOOL)isEmpty;

@end

//
//  CDNode.h
//  Untitled
//
//  Created by Chris Davey on 7/08/08.
/**
 Copyright (c) 2010, Chris Davey
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the CDGraphLib nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

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

@property(retain) NSObject *data;
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

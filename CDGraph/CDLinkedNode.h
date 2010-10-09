//
//  CDLinkedNode.h
//  CDGraph
//
//  Created by Chris Davey on 4/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDLinkedNode : NSObject {

	NSObject *data;
	CDLinkedNode * link;
}

@property(assign) NSObject *data;
@property(assign) CDLinkedNode *link;

-(id)initWithData:(NSObject *)objData;
-(void)dealloc;

@end

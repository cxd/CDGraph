//
//  TestObject.h
//  CDGraph
//
//  Created by Chris Davey on 10/12/08.
//  Copyright 2008 none. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TestObject : NSObject {
	NSString *data;
}

-(void)dealloc;

/**
 Data property.
 **/
@property(assign) NSString *data;


@end

//
//  CDGraphVisitor.h
//  CDGraph
//
//  Created by Chris Davey on 7/02/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDNode.h"

@protocol CDGraphVisitor 
	-(void) visit:(CDNode *) node;
@end

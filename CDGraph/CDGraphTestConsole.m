//
//  CDGraphTestConsole.m
//  CDGraph
//
//  Created by Chris Davey on 19/01/09.
//  Copyright 2009 none. All rights reserved.
//

#import "CDGraphTestConsole.h"


@implementation CDGraphTestConsole

-(void)runTests
{
	CDTestGraphClient *client = [[CDTestGraphClient alloc]init];
	[client retain];
	NSString *result = ([client testGraphFind] == YES) ? @"SUCCESS" : @"FAIL";
	[result retain];
	NSLog(@"Test 1 Result is %@", result);
	result = ([client testFindEdges] == YES) ? @"SUCCESS" : @"FAIL";
	NSLog(@"Test 2 Result is %@", result);
	[result release];
	[client release];
}

int main(int argc, const char * argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	CDGraphTestConsole *console = [[CDGraphTestConsole alloc] init];
	[console runTests];
	
	[pool drain];
	
}

@end

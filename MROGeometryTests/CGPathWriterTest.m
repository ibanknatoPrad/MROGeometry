//
// CGPathWriterTC.m
//
// Created by Marcus Rohrmoser on 15.10.10.
// Copyright 2010 Marcus Rohrmoser mobile Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface CGPathWriterTC : XCTestCase {}
@end

#import "CGPathWriter.h"
#import "PathParser.h"

@implementation CGPathWriterTC

-(void)testWrite
{
	CGMutablePathRef p = CGPathCreateMutable();
	CGPathMoveToPoint(p, NULL, 1, 2);
	CGPathAddLineToPoint(p, NULL, 3, 4);
	CGPathAddCurveToPoint(p, NULL, 5, 6, 7, 8, 9, 10);

	char *buf = CGPathToCString(p, 0, 0);

	// file:///Users/Developer.SnowLeopard/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_1.iOSLibrary.docset/Contents/Resources/Documents/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/occ/instm/NSString/initWithBytesNoCopy:length:encoding:freeWhenDone:
	// initWithBytesNoCopy:length:encoding:freeWhenDone:
	XCTAssertEqualObjects(@"M1.000000,2.000000L3.000000,4.000000C5.000000,6.000000,7.000000,8.000000,9.000000,10.000000", ([NSString stringWithCString:buf encoding:NSASCIIStringEncoding]), @"");

	free(buf);
	CGPathRelease(p);
}


-(void)testReadWrite
{
	NSString *ps = @"M1.000000,2.000000L3.000000,4.000000C5.000000,6.000000,7.000000,8.000000,9.000000,10.000000";
	PathParser *pp = [alloc (PathParser)init];
	NSError *err = nil;
	CGPathRef p = [pp parseString:ps trafo:NULL error:&err];
	XCTAssertNil(err, @"");

	char *buf = CGPathToCString(p, 0, 0);
	// file:///Users/Developer.SnowLeopard/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_1.iOSLibrary.docset/Contents/Resources/Documents/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/occ/instm/NSString/initWithBytesNoCopy:length:encoding:freeWhenDone:
	// initWithBytesNoCopy:length:encoding:freeWhenDone:
	XCTAssertEqualObjects(ps, ([NSString stringWithCString:buf encoding:NSASCIIStringEncoding]), @"");
	free(buf);

	CGPathRelease(p);
	[pp release];
}


@end

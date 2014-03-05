//
// CGPathWriterTC.m
//
// Created by Marcus Rohrmoser on 15.10.10.
// Copyright 2010-2014 Marcus Rohrmoser mobile Software. All rights reserved.
//

#import <XCTest/XCTest.h>

@implementation XCTestCase(Helpers)

-(NSString *)contentOfFile:(NSString *)name ofType:(NSString *)type
{
	NSError *err = nil;
	Class clz = [self class];
	XCTAssertNotNil(NSStringFromClass(clz), @"ouch", nil);
	NSBundle *b = [NSBundle bundleForClass:clz];
	NSString *res = [NSString stringWithFormat:@"%@.%@", NSStringFromClass(clz), name, nil];
	NSString *path = [b pathForResource:res ofType:type];
	NSString *clob = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
	XCTAssertNil(err, @"Issue reading %@.%@: %@", res, type, err, nil);
	XCTAssertNotNil(clob, @"Issue reading %@.%@", path, type, nil);
	return clob;
}


@end


@interface CGPathWriterTest : XCTestCase
@end

#import "CGPathWriter.h"
#import "CGPathReader.h"
#import "PathParser.h"

@implementation CGPathWriterTest

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
	PathParser *pp = [[PathParser alloc] init];
	NSError *err = nil;
	CGPathRef p = [pp newCGPathWithNSString:ps trafo:NULL error:&err];
	XCTAssertNil(err, @"");

	char *buf = CGPathToCString(p, 0, 0);
	// file:///Users/Developer.SnowLeopard/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiOS4_1.iOSLibrary.docset/Contents/Resources/Documents/documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html#//apple_ref/occ/instm/NSString/initWithBytesNoCopy:length:encoding:freeWhenDone:
	// initWithBytesNoCopy:length:encoding:freeWhenDone:
	XCTAssertEqualObjects(ps, ([NSString stringWithCString:buf encoding:NSASCIIStringEncoding]), @"");
	free(buf);

	CGPathRelease(p);
}


/** http://www.w3.org/TR/SVG11/paths.html#PathDataCubicBezierCommands
 */
-(void)testPathDataCubicBezierCommands
{
	NSString *d = @"M100,200 C100,100 250,100 250,200\nS400,300 400,200";
	NSError *err = nil;
	CGPathRef p = CGPathCreateFromSVGPath(d, NULL, &err);
	XCTAssertNil(err, @"");
	CGPathRelease(p);
}


@end

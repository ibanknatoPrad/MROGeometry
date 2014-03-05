//
// PathParser.h
//
// Created by Marcus Rohrmoser on 11.03.10.
// Copyright 2010-2014 Marcus Rohrmoser mobile Software. All rights reserved.
//

#import "RagelParser.h"
#import <CoreGraphics/CGPath.h>
#import <CoreGraphics/CGAffineTransform.h>


/** Parser for <a href="http://www.w3.org/TR/SVG11/paths.html#PathDataBNF">SVG path elements</a>.
 *
 * The implementation is generated via <a href="http://www.complang.org/ragel/">Ragel</a>
 * from PathParser.rl.
 *
 * <b>DO NOT EDIT PathParser.m MANUALLY!!!</b>
 *
 * See also https://lib2geom.svn.sourceforge.net/svnroot/lib2geom/lib2geom/trunk/src/2geom/svg-path-parser.rl
 */
@interface PathParser : RagelParser {}

/** Do the actual parsing. Stateless and reentrant.
 * @param data content of a svg path element's 'd' attribute.
 * @param trafo may be NULL
 * @param errPtr out parameter to report parsing problems.
 * @return a retained core graphics path.
 */
-(CGPathRef)newCGPathWithNSString:(NSString *)data trafo:(const CGAffineTransform *)trafo error:(NSError **)errPtr;


/** Do the actual parsing. Stateless and reentrant.
 * @param data content of a svg path element's 'd' attribute.
 * @param length number of max. baytes to read
 * @param errPtr out parameter to report parsing problems.
 * @return a retained core graphics path.
 */
-(CGPathRef)newCGPathWithCString:(const char *)data length:(size_t)length trafo:(const CGAffineTransform *)trafo error:(NSError **)errPtr;


@end

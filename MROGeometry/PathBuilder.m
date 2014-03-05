//
// PathBuilder.m
//
// Created by Marcus Rohrmoser on 11.03.10.
// Copyright 2010-2014 Marcus Rohrmoser mobile Software. All rights reserved.
//

#import "PathBuilder.h"

#if 0
#ifdef MRLogD
#undef MRLogD
#endif
// No Logging
#define MRLogD(x, ...)
#endif

@interface PathBuilder()
{
	const CGAffineTransform *trafo;
	CGMutablePathRef gp;
	// last control point for the smooth curveTo and quadTo
	CGPoint o;
	// last point
	CGPoint p;
}
@end


/**
 * @todo CGPathAddArc
 * @todo CGPathAddRelativeArc
 */
@implementation PathBuilder

-(id)initWithTrafo:(const CGAffineTransform *)trafo_
{
	if( self = [super init] ) {
		trafo = trafo_;
		gp = CGPathCreateMutable();
		o.x = o.y = NAN;
		p = CGPointZero;
	}
	return self;
}


-(void)dealloc
{
	CGPathRelease(gp);
}


-(void)closePath
{
	CGPathCloseSubpath(gp);
}


-(void)cubicToAbsolute:(BOOL)abs x1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2 x3:(CGFloat)x3 y3:(CGFloat)y3
{
	MRLogD(@"%d (%f,%f) (%f,%f) (%f,%f)", abs, x1, y1, x2, y2, x3, y3);
	if( !abs ) {
		x1 += p.x;
		y1 += p.y;
		x2 += p.x;
		y2 += p.y;
		x3 += p.x;
		y3 += p.y;
	}
	CGPathAddCurveToPoint(gp, trafo, x1, y1, x2, y2, x3, y3);
	o.x = x2;
	o.y = y2;
	p.x = x3;
	p.y = y3;
}


-(void)lineToAbsolute:(BOOL)abs x:(CGFloat)x y:(CGFloat)y
{
	MRLogD(@"%d", abs);
	if( !abs ) {
		x += p.x;
		y += p.y;
	}
	CGPathAddLineToPoint(gp, trafo, x, y);
	o.x = o.y = NAN;
	p.x = x;
	p.y = y;
}


-(void)hlineToAbsolute:(BOOL)abs x:(CGFloat)x
{
	MRLogD(@"%d", abs);
	[self lineToAbsolute:abs x:x y:(abs ? p.y:0)];
}


-(void)moveToAbsolute:(BOOL)abs x:(CGFloat)x y:(CGFloat)y
{
	MRLogD(@"%d (%f,%f)", abs, x, y);
	if( !abs ) {
		x += p.x;
		y += p.y;
	}
	CGPathMoveToPoint(gp, trafo, x, y);
	o.x = o.y = NAN;
	p.x = x;
	p.y = y;
}


-(void)quadToAbsolute:(BOOL)abs x1:(CGFloat)x1 y1:(CGFloat)y1 x2:(CGFloat)x2 y2:(CGFloat)y2
{
	MRLogD(@"%d", abs);
	if( !abs ) {
		x1 += p.x;
		y1 += p.y;
		x2 += p.x;
		y2 += p.y;
	}
	CGPathAddQuadCurveToPoint(gp, trafo, x1, y1, x2, y2);
	o.x = x1;
	o.y = y1;
	p.x = x2;
	p.y = y2;
}


/**
 * @see http://www.w3.org/TR/SVG11/implnote.html#PathElementImplementationNotes
 */
-(void)smoothCubicToAbsolute:(BOOL)abs x2:(CGFloat)x2 y2:(CGFloat)y2 x3:(CGFloat)x3 y3:(CGFloat)y3
{
	MRLogD(@"%d (%f,%f) (%f,%f)", abs, x2, y2, x3, y3);
	const CGFloat x1 = p.x + (p.x - o.x);
	const CGFloat y1 = p.y + (p.y - o.y);
	if( !abs ) {
		x2 += p.x;
		y2 += p.y;
		x3 += p.x;
		y3 += p.y;
	}
	[self cubicToAbsolute:YES x1:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3];
}


-(void)smoothQuadToAbsolute:(BOOL)abs x2:(CGFloat)x2 y2:(CGFloat)y2
{
	MRLogD(@"%d", abs);
	CGFloat x1;
	CGFloat y1;
	if( abs ) {
		x1 = 2 * p.x - o.x;
		y1 = 2 * p.y - o.y;
	} else {
		// @todo verify!
		x1 = p.x - o.x;
		y1 = p.y - o.y;
	}
	[self quadToAbsolute:abs x1:x1 y1:y1 x2:x2 y2:y2];
}


/** returns an unretained reference! */
-(CGPathRef)toPath
{
	return gp;
}


-(void)vlineToAbsolute:(BOOL)abs y:(CGFloat)y
{
	MRLogD(@"%d", abs);
	[self lineToAbsolute:abs x:(abs ? p.x:0) y:y];
}


@end

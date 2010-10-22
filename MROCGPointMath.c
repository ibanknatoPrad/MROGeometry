/*
 *  MROCGPointMath.c
 *
 *  Created by Marcus Rohrmoser on 21.09.10.
 *  Copyright 2010 Marcus Rohrmoser mobile Software. All rights reserved.
 *
 */

#include "MROCGPointMath.h"
#include <math.h>

/// unused
CGPoint CGPointSwapXY(CGPoint p)
{
	CGFloat t = p.x;
	p.x = p.y;
	p.y = (320 - 1) - t;
	return p;
}


CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
	return CGPointMake(a.x + b.x, a.y + b.y);
}


CGPoint CGPointMinus(const CGPoint a, const CGPoint b)
{
	return CGPointMake(a.x - b.x, a.y - b.y);
}


CGPoint CGPointScale(const CGFloat f, const CGPoint a)
{
	return CGPointMake(f * a.x, f * a.y);
}


#if !defined(SQR)
#define SQR(x) ( (x) * (x) )
#else
#error "SQR already defined."
#endif


CGFloat CGPointAbsSqr(const CGPoint a)
{
	return SQR(a.x) + SQR(a.y);
}


CGFloat CGPointAbs(const CGPoint a)
{
	return sqrt( CGPointAbsSqr(a) );
}


#if !defined(ABS)
#define ABS(A)  ({ __typeof__(A) __a = (A); __a < 0 ? -__a : __a; } \
		 )
#else
#error "ABS already defined."
#endif


int CGPointDistanceSmallerThan(const CGPoint a, const CGPoint b, const CGFloat radius)
{
	CGFloat dx = a.x - b.x;
	dx = ABS(dx);
	if ( dx > radius )
		return 0 == 1;
	CGFloat dy = a.y - b.y;
	dy = ABS(dy);
	if ( dy > radius )
		return 0 == 1;
	return SQR(dx) + SQR(dy) < SQR(radius);
}
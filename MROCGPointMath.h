/*
 *  MROCGPointMath.h
 *
 *  Created by Marcus Rohrmoser on 21.09.10.
 *  Copyright 2010 Marcus Rohrmoser mobile Software. All rights reserved.
 *
 */

#include <CoreGraphics/CGGeometry.h>

CGPoint CGPointAdd(const CGPoint a, const CGPoint b);

CGPoint CGPointMinus(const CGPoint a, const CGPoint b);

CGPoint CGPointScale(const CGFloat f, const CGPoint a);

CGFloat CGPointAbsSqr(const CGPoint a);

CGFloat CGPointAbs(const CGPoint a);

int CGPointDistanceSmallerThan(const CGPoint a, const CGPoint b, const CGFloat radius);
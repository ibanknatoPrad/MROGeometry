
# MROGeometry

Some C / Objective-C helpers related to

- [CGPoint](http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CGGeometry/Reference/reference.html%23//apple_ref/doc/uid/TP30000955-CH2g-C016211),
- [CGAffineTransform](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGAffineTransform/Reference/reference.html%23//apple_ref/doc/c_ref/CGAffineTransform),
- [CGPath](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html) and
- [SVG path](http://www.w3.org/TR/SVG/paths.html).

## [Makefile](MROGeometry/blob/master/Makefile)

Generate C state machines and pdf docs from [Ragel](http://www.complang.org/ragel/) sources.

## [CGPathReader.h](MROGeometry/blob/master/CGPathReader.h)

Parse a [SVG path](http://www.w3.org/TR/SVG/paths.html) and return a retained 
[CGPathRef](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html).

See [PathParser.h](MROGeometry/blob/master/PathParser.h)

## [CGPathWriter.h](MROGeometry/blob/master/CGPathWriter.h)

Write a very simple, non-optimized form of [SVG path](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF).

## [MROCGPointMath.h](MROGeometry/blob/master/MROCGPointMath.h)

Simple [CGPoint](http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CGGeometry/Reference/reference.html%23//apple_ref/doc/uid/TP30000955-CH2g-C016211)
math:

- add,
- subtract,
- scale (multiply x and y with a number),
- dot product,
- distance square and distance.

## [NSCoder_MROCGPath.h](MROGeometry/blob/master/NSCoder_MROCGPath.h)

Persist a [CGPathRef](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html)
using the [SVG path](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF) format as ASCII/C String.
 
## [PathParser.h](MROGeometry/blob/master/PathParser.h)

Parse a [SVG path](http://www.w3.org/TR/SVG/paths.html) and return a retained CGPathRef.

Uses the [Ragel](http://www.complang.org/ragel/)-generate state machine 
[PathParser.rl](MROGeometry/blob/master/PathParser.rl) directly based on the [W3C BNF path grammar](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF)
for parsing.

## [TrafoParser.h](MROGeometry/blob/master/TrafoParser.h)

Parse a [SVG transform attribute](http://www.w3.org/TR/SVG/coords.html#TransformAttribute) and 
return a [CGAffineTransform](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGAffineTransform/Reference/reference.html%23//apple_ref/doc/c_ref/CGAffineTransform).

Uses the [Ragel](http://www.complang.org/ragel/)-generate state machine 
[TrafoParser.rl](MROGeometry/blob/master/TrafoParser.rl) directly based on the W3C grammar for parsing.

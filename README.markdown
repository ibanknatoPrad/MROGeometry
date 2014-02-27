
# MROGeometry

Some C / Objective-C helpers related to

- [CGPoint](http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CGGeometry/Reference/reference.html%23//apple_ref/doc/uid/TP30000955-CH2g-C016211),
- [CGAffineTransform](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGAffineTransform/Reference/reference.html%23//apple_ref/doc/c_ref/CGAffineTransform),
- [CGPath](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html) and
- [SVG path](http://www.w3.org/TR/SVG/paths.html).

## [CGPathReader.h](MROGeometry/MROGeometry/CGPathReader.h)

Parse a [SVG path](http://www.w3.org/TR/SVG/paths.html) and return a retained 
[CGPathRef](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html).

See [PathParser.h](MROGeometry/MROGeometry/PathParser.h)

## [CGPathWriter.h](MROGeometry/MROGeometry/CGPathWriter.h)

Write a very simple, non-optimized form of [SVG path](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF).

## [MROCGPointMath.h](MROGeometry/MROGeometry/MROCGPointMath.h)

Simple [CGPoint](http://developer.apple.com/library/mac/#documentation/GraphicsImaging/Reference/CGGeometry/Reference/reference.html%23//apple_ref/doc/uid/TP30000955-CH2g-C016211)
math:

- add,
- subtract,
- scale (multiply x and y with a number),
- dot product,
- distance square and distance.

## [NSCoder_MROCGPath.h](MROGeometry/MROGeometry/NSCoder_MROCGPath.h)

Persist a [CGPathRef](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGPath/Reference/reference.html)
using the [SVG path](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF) format as ASCII/C String.
 
## [PathParser.h](MROGeometry/MROGeometry/PathParser.h)

Parse a [SVG path](http://www.w3.org/TR/SVG/paths.html) and return a retained CGPathRef.

Uses the [Ragel](http://www.complang.org/ragel/)-generate state machine 
[PathParser.rl](MROGeometry/MROGeometry/PathParser.rl) directly based on the [W3C BNF path grammar](http://www.w3.org/TR/SVG11/paths.html#PathDataBNF)
for parsing.

## [TrafoParser.h](MROGeometry/MROGeometry/TrafoParser.h)

Parse a [SVG transform attribute](http://www.w3.org/TR/SVG/coords.html#TransformAttribute) and 
return a [CGAffineTransform](http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Reference/CGAffineTransform/Reference/reference.html%23//apple_ref/doc/c_ref/CGAffineTransform).

Uses the [Ragel](http://www.complang.org/ragel/)-generate state machine 
[TrafoParser.rl](MROGeometry/MROGeometry/TrafoParser.rl) directly based on the W3C grammar for parsing.


## Global Macros

There are some macros I use all over the place. Instead including the same header in every source
file I list them here (usually I put them into the common header *.pch):

<pre>
// http://blog.mro.name/2010/06/xcode-missing-deprecated-warnings/
#define alloc(c)        ( (c *)[c alloc] )

#ifndef DEBUG
// Ensure DEBUG is defined properly
  #if NS_BLOCK_ASSERTIONS
//#error Define -DDEBUG=0 in Project Settings->GCC 4.2 Language->Other C Flags
	#define DEBUG 0
  #else
    #error Define -DDEBUG=1 in Project Settings->GCC 4.2 Language->Other C Flags
  #endif
#endif

#if DEBUG
  #ifdef NS_BLOCK_ASSERTIONS
    #error Don't define -DNS_BLOCK_ASSERTIONS=0 in Project Settings->GCC 4.2 Language->Other C Flags
  #endif
// Do Logging
  #define MRLogD(x, ...) NSLog(@"%s " x, __FUNCTION__, ## __VA_ARGS__)
#else
  #ifndef NS_BLOCK_ASSERTIONS
    #error Define -DNS_BLOCK_ASSERTIONS=1 in Project Settings->GCC 4.2 Language->Other C Flags
  #endif
  #if !NS_BLOCK_ASSERTIONS
    #error Define -DNS_BLOCK_ASSERTIONS=1 in Project Settings->GCC 4.2 Language->Other C Flags
  #endif
// No Logging
  #define MRLogD(x, ...)                            /* NSLog(x,##__VA_ARGS__) */
  #define NSLog(x, ...)                             /* NSLog(x,##__VA_ARGS__) */
#endif
</pre>

## [Makefile](MROGeometry/Makefile)

Generate C state machines and pdf docs from [Ragel](http://www.complang.org/ragel/) sources.

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=mro&url=https://github.com/mro/MROGeometry&title=MROGeometry&language=&tags=github&category=software) 

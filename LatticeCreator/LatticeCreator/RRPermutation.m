// $Id: RRPermutation.m,v 1.1 2008/08/22 15:56:20 royratcliffe Exp $
//
// Copyright © 2008, Roy Ratcliffe, Lancaster, United Kingdom
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//------------------------------------------------------------------------------
//
// $Log: RRPermutation.m,v $
// Revision 1.1  2008/08/22 15:56:20  royratcliffe
// Permutation enumerator, initial revision
//

#import "RRPermutation.h"

#import "RRFactorial.h"

@implementation RRPermutation

+ (RRPermutation *)permutationWithSize:(NSUInteger)theSize
{
	return [(RRPermutation *)[self alloc] initWithSize:theSize];
}

// designated initialiser
- (id)initWithSize:(NSUInteger)theSize rank:(NSUInteger)theRank
{
	if ((self = [super init]))
	{
		size = theSize;
		rank = theRank;
		// Rank steps by one, starting at zero, ending at RRFactorial(size) - 1;
		// no need to store this value because RRFactorial does all the storing
		// for us in its secret cache.
	}
	return self;
}

- (id)initWithSize:(NSUInteger)theSize
{
	return [self initWithSize:theSize rank:0];
}

#pragma mark Accessors

- (NSUInteger)size
{
	return size;
}

- (NSUInteger)rank
{
	return rank;
}

- (NSUInteger)last
{
	return RRFactorial(size) - 1;
}

- (void)setRank:(NSUInteger)newRank
{
	rank = newRank;
}

#pragma mark Enumerator

- (id)nextObject
{
	return rank < RRFactorial(size) ? [self unrankIndices:rank++] : nil;
}

- (NSArray *)unrankIndices:(NSUInteger)m
{
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:size];
	NSUInteger i;
	for (i = 0; i < size; i++)
	{
		[result addObject:[NSNumber numberWithUnsignedInteger:0]];
	}
	for (i = 0; i < size; i++)
	{
		NSUInteger f = RRFactorial(i);
		NSUInteger x = m % (f * (i + 1));
		m -= x;
		x /= f;
		[result replaceObjectAtIndex:size - i - 1 withObject:[NSNumber numberWithUnsignedInteger:x]];
		// At this point, Florian decrements x in preparation for the following
		// comparisons with values from the result array. This assumes that x
		// can be negative however. In our case, it cannot because we implement
		// indices using NSUInteger (unsigned) as is the Foundation framework's
		// wont for array indices. To abviate the decrement, the subsequent test
		// becomes greater-than-or-equal-to instead of greater-than. Problem
		// solved, and simplifies the code too.
		// x -= 1;
		NSUInteger j;
		for (j = size - i; j < size; j++)
		{
			NSUInteger y = [[result objectAtIndex:j] unsignedIntegerValue];
			if (y >= x)
			{
				[result replaceObjectAtIndex:j withObject:[NSNumber numberWithUnsignedInteger:y + 1]];
			}
		}
	}
	return result;
}

@end

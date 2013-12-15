// $Id: RRPermutation.h,v 1.1 2008/08/22 15:56:20 royratcliffe Exp $
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
// $Log: RRPermutation.h,v $
// Revision 1.1  2008/08/22 15:56:20  royratcliffe
// Permutation enumerator, initial revision
//

#import <Foundation/Foundation.h>

@interface RRPermutation : NSEnumerator
{
	NSUInteger size, rank;
}

+ (RRPermutation *)permutationWithSize:(NSUInteger)theSize;

- (id)initWithSize:(NSUInteger)theSize rank:(NSUInteger)theRank;
- (id)initWithSize:(NSUInteger)theSize;

- (NSUInteger)size;
- (NSUInteger)rank;
- (NSUInteger)last;

- (void)setRank:(NSUInteger)newRank;
	// Rank ranges from 0 to factorial of size, less one, i.e. last. Use
	// setRank:0 to reset a permutation enumerator.

- (id)nextObject;
	// Send nextObject repeatedly to get the next array of permutation
	// indices. Answers nil after the last. Note that you cannot reset the
	// enumeration using the enumerator interface, although permutation
	// internals allow it.

// Following methods are generally for internal use and might be considered
// private. Nevertheless, feel free to access them for testing and debugging or
// other purposes if you wish. They are query methods, operations without side
// effects on enumerator state. So no pitfalls to avoid.

- (NSArray *)unrankIndices:(NSUInteger)m;

@end

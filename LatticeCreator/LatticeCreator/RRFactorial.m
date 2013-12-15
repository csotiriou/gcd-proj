// $Id: RRFactorial.m,v 1.4 2008/08/22 06:33:45 royratcliffe Exp $
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
// $Log: RRFactorial.m,v $
// Revision 1.4  2008/08/22 06:33:45  royratcliffe
// Without dynamic allocation, the outer n >= i condition becomes redundant
//
// Revision 1.3  2008/08/21 19:03:41  royratcliffe
// Switched to MIT license
//
// Revision 1.2  2008/08/21 17:24:28  royratcliffe
// Eliminates dependence on memory allocation and obviates exception handling
// for allocation failure and boundary overflow
//
// Revision 1.1  2008/08/21 16:33:17  royratcliffe
// Factorial of n, n!
//

#import "RRFactorial.h"

NSUInteger RRFactorial(NSUInteger n)
{
	// Use preprocessor macros to determine the maximum value of n computable
	// within the limits prescribed by NSUInteger, whose bit-width depends on
	// architecture: either 64 or 32 bits.
#if __LP64__ || NS_BUILD_32_LIKE_64
#define N 20 // 20! = 2,432,902,008,176,640,000
#else
#define N 12 // 12! = 479,001,600
#endif
	if (n > N) return NSUIntegerMax;
	static NSUInteger f[N + 1];
	static NSUInteger i = 0;
	if (i == 0)
	{
		f[0] = 1;
		i = 1;
	}
	while (i <= n)
	{
		f[i] = i * f[i - 1];
		i++;
	}
	return f[n];
}

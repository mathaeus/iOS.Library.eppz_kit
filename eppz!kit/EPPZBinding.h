//
//  EPPZBinding.h
//  eppz!kit
//
//  Created by Borbás Geri on 20/01/14.
//  Copyright (c) 2014 eppz! development, LLC.
//
//  donate! by following http://www.twitter.com/_eppz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSDictionary+EPPZKit.h"


@class EPPZBinding;
@interface NSObject (EPPZBinding)
@property (nonatomic, strong) NSNumber *swizzled;
@property (nonatomic, weak) EPPZBinding *binding;
-(void)originalDealloc;
-(void)injectedDealloc;
@end


#define EPPZ_BINDING_LOGGING NO
#define EBLog if (EPPZ_BINDING_LOGGING) NSLog


typedef id (^EPPZBindingRightValueFormatterBlock)(id leftValue); // Should return right value.
typedef id (^EPPZBindingLeftValueFormatterBlock)(id rightValue); // Should return left value.


@interface EPPZBinding : NSObject

@property (nonatomic, weak) NSObject *left; // Strong references ensures proper dealloc order (synchronizator, observers, then objects).
@property (nonatomic, weak) NSObject *right;

+(id)bindObject:(NSObject*) left
     withObject:(NSObject*) right
    propertyMap:(NSDictionary*) propertyMap;

+(id)bindObject:(NSObject*) left
     withObject:(NSObject*) right
    propertyMap:(NSDictionary*) propertyMap
 leftFormatters:(NSDictionary*) leftFormatters
rightFormatters:(NSDictionary*) rightFormatters;

-(void)updateLeft; // Force update left object.
-(void)updateRight; // Force update right object.
-(void)cut; // Cut bindings (tear down observers).

@end

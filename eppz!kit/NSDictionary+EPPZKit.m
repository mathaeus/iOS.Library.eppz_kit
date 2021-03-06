//
//  NSDictionary+EPPZKit.m
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

#import "NSDictionary+EPPZKit.h"


@implementation NSDictionary (EPPZKit)


-(NSDictionary*)dictionaryBySwappingKeysAndValues
{
    NSMutableDictionary *mutable = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id eachKey, id eachValue, BOOL *stop)
    {
        // Check if value is suitable to be a key.
        if ([eachValue conformsToProtocol:@protocol(NSCopying)])
        {
            // Set.
            id <NSCopying> eachObject = (id<NSCopying>)eachValue;
            [mutable setObject:eachKey forKey:eachObject];
        }
    }];
    
    // Return immutable.
    return [NSDictionary dictionaryWithDictionary:mutable];
}

-(NSDictionary*)dictionaryByRemovingValueForKey:(id<NSCopying>) key
{
    // Checks.
    if (key == nil) return self;
    if ([[self allKeys] containsObject:key] == NO) return self;
    
    NSMutableDictionary *mutable = [NSMutableDictionary dictionaryWithDictionary:self];
    [mutable removeObjectForKey:key];
    return [NSDictionary dictionaryWithDictionary:mutable];
}

-(id)valueForKeyOrNil:(NSString*) key
{
    // Checks.
    if (self.count == 0) return nil;
    if ([self.allKeys containsObject:key] == NO) return nil;
    
    return [self objectForKey:key];
}

-(id)valueForKeyPathOrNil:(NSString*) keyPath
{
    // Checks.
    if (self.count == 0) return nil;

    // Try to get.
    id value = nil;
    @try { value = [self valueForKeyPath:keyPath]; }
    @catch (NSException *exception) { }
    @finally { }
    
    return value;
}


@end

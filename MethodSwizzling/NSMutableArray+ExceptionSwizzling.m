//
//  NSMutableArray+ExceptionSwizzling.m
//  Runtime
//
//  Created by apple on 17/7/19.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "NSMutableArray+ExceptionSwizzling.h"
#import <objc/runtime.h>

@implementation NSMutableArray (ExceptionSwizzling)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //此处直接使用[self class]获取class，是不会执行交换代码的。
        //NSArray 真身 __NSArrayI
        //NSMutableArray __NSArrayM
        //NSDictionary __NSDictionaryI
        //NSMutableDictionary __NSDictionaryM
        Class class = objc_getClass("__NSArrayM");
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(exception_objectAtIndex:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (id)exception_objectAtIndex:(NSUInteger)index{
//    NSLog(@"NSMutableArray");
    return [self exception_objectAtIndex:index];
}

@end

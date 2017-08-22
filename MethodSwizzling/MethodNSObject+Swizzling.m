//
//  MethodNSObject+Swizzling.m
//  Runtime
//
//  Created by apple on 17/7/19.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "MethodNSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation MethodNSObject (Swizzling)
//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        SEL originalSelector = @selector(userName:);
//        SEL swizzledSelector = @selector(XY_userName:);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        BOOL didAddMethod = class_addMethod(class,
//                                            originalSelector,
//                                            method_getImplementation(swizzledMethod),
//                                            method_getTypeEncoding(swizzledMethod));
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}


//- (void)XY_userName:(NSString *)name{
//    //是否还需要调用MethodNSObject 中userName 方法
////    [self XY_userName:name];
//    NSLog(@"MethodNSObject+Swizzling %@",name);
//}

@end

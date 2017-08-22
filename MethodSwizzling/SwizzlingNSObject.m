//
//  SwizzlingNSObject.m
//  Runtime
//
//  Created by apple on 17/7/19.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "SwizzlingNSObject.h"
#import "MethodNSObject.h"
#import <objc/runtime.h>

@implementation SwizzlingNSObject

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"MethodNSObject");
        SEL originalSelector = @selector(userName:);
        SEL swizzledSelector = @selector(XY_userName:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        //为cls类对象添加新方法
        //注意如果使用集成的方式交换方法，既要调用交换方法又要调用原来的方法。
        //这里要向类中添加一个交换方法，否则程序会崩溃。
        BOOL didAddMethod = class_addMethod(class,
                                            swizzledSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            //替换cls类对象中name对应方法的实现
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            //交换m1，m2方法对应具体实现的函数指针
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)XY_userName:(NSString *)name{
    //直接调用会崩溃 找不到该方法
        [self XY_userName:name];
    
    NSLog(@"SwizzlingNSObject %@",name);
}

@end

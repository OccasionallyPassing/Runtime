//
//  AssociatedObject.m
//  Runtime
//
//  Created by apple on 17/7/14.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "AssociatedObject.h"
#import <objc/runtime.h>
/*
 关联对象3种使用场景
 
 1.为现有的类添加私有变量
 2.为现有的类添加公有属性
 3.为KVO创建一个关联的观察者。
 */
@interface AssociatedObject()

@property (nonatomic, strong) id associatedObject;

@end

@implementation AssociatedObject

- (void)setAssociatedObject:(id)associatedObject{
    objc_setAssociatedObject(self, @selector(associatedObject), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject{
   return objc_getAssociatedObject(self, @selector(associatedObject));
}


@end

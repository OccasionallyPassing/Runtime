//
//  Father.m
//  RunTimeMessageSend
//
//  Created by apple on 17/7/13.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "Father.h"
#import "Monther.h"
#import <objc/runtime.h>

@interface Father()

@property (nonatomic, strong) Monther *monther;

@end

@implementation Father

void playGameResolve(id obj,SEL _cmd){
    NSLog(@"he is playing %@ sel = %d",obj,_cmd);
    //he is playing <Father: 0x600000016b80> sel = 251988772
}

- (instancetype)init{
    if (self = [super init]) {
        self.monther = [[Monther alloc]init];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(palyGame:)) {
//        class_addMethod([self class], sel, (IMP)playGameResolve, "v@:");
//        return YES;
//    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(palyGame:)) {
        class_addMethod([self class], sel, (IMP)playGameResolve, "v@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(palyGame:)) {
//        return self.monther;
//    }
    return [super forwardingTargetForSelector:aSelector];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if(aSelector == @selector(palyGame:)) {
        return NSClassFromString(@"Class name");
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self.monther methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = anInvocation.selector;
    if ([self.monther respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:self.monther];
    }else{
        [self doesNotRecognizeSelector:sel];
    }
}


@end

//
//  ViewController.m
//  Runtime
//
//  Created by apple on 17/7/13.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "Father.h"
#import "Students.h"
#import "MethodNSObject.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //messagesend
    [[[Father alloc]init] palyGame:@"CS"];
    // array exception
//    NSArray *array = [NSArray arrayWithObjects:@"number0", nil];
//    [array objectAtIndex:2];
    //NScoding
    Students *stu = [[Students alloc]init];
    stu.name = @"大炮";
    stu.age = 18;
    stu.sex = YES;
    NSLog(@"%@,%ld,%@",stu.name,stu.age,stu.sex?@"男":@"女");
    
    
    NSMutableArray *mutableArr = [@[@"wo"]mutableCopy];
    NSLog(@"%@",[mutableArr objectAtIndex:0]);
    
    MethodNSObject *method = [[MethodNSObject alloc]init];
    [method userName:@"wangyu"];
    
    
    NSLog(@"nsobject = %@ superClass = %@",[NSObject class],[[NSObject superclass] class]);
    
    IMP subClassIMP = method_getImplementation(class_getInstanceMethod([MethodNSObject class], @selector(respondsToSelector:)));
    IMP superClassIMP = method_getImplementation(class_getInstanceMethod([[MethodNSObject superclass]class], @selector(respondsToSelector:)));
    IMP superSuperClassIMP = method_getImplementation(class_getInstanceMethod([[NSObject superclass]class], @selector(respondsToSelector:)));

    NSLog(@"%p,%p,%p",subClassIMP,superClassIMP,superSuperClassIMP);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

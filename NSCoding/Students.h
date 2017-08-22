//
//  Students.h
//  Runtime
//
//  Created by apple on 17/7/14.
//  Copyright © 2017年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students : NSObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL sex;

@end

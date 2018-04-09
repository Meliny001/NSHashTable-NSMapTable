//
//  ViewController.m
//  NSHashTable&NSMapTable
//
//  Created by Magic on 2018/4/9.
//  Copyright © 2018年 magic. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSHashTable *_hashTable;// like NSSet
    NSMapTable *_mapTable;// like NSMutableDictionary
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self testMemoryHashTable];
    [self testMapTable];
    
}

- (void)testMemoryHashTable
{
    [self addObjectToHashTable];
    NSLog(@"After>>>%@",_hashTable);
    NSLog(@"After-copy>>>%@",_hashTable.copy);
}

- (void)addObjectToHashTable
{
    if (!_hashTable) {
        // 1.test NSPointerFunctionsStrongMemory/NSPointerFunctionsWeakMemory
        _hashTable = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality capacity:0];
        // 可以存储任意指针 NSPointerFunctionsObjectPointerPersonality hash校验是否两个指针是否相等或存在
    }
    People * p = [People new];
    p.name = @"xx";
    People * p1 = [People new];
    p1.name = @"xx1";
    [_hashTable addObject:p];
    [_hashTable addObject:p1];
    //[_hashTable addObject:p]; // 2.1 Open to test
    //[_hashTable addObject:self]; // 2.2 Open to test
    
    NSLog(@"Before>>%@",_hashTable);
}
- (void)testMapTable
{
    [self addMapTable];
    NSLog(@"After:%@",_mapTable);
}
- (void)addMapTable
{
    if (!_mapTable) {
        _mapTable = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    }
    NSObject * obj = [NSObject new];
    [_mapTable setObject:obj forKey:@"objKey"];
//    [_mapTable setObject:@"obj" forKey:@"objKey"];
    [_mapTable setObject:obj forKey:@"objKey1"];
    
    NSLog(@"%@",_mapTable);
}

@end

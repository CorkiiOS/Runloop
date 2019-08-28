//
//  LRunloopQueue.h
//  RunloopDemo
//
//  Created by 万启鹏 on 2019/8/28.
//  Copyright © 2019 iCorki. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRunloopQueue : NSObject
- (instancetype)initWithRunloop:(CFRunLoopRef)runloop handler:(void (^)(id _Nullable, BOOL))handlerBlock;

@end

NS_ASSUME_NONNULL_END

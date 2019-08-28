//
//  LRunloopQueue.m
//  RunloopDemo
//
//  Created by 万启鹏 on 2019/8/28.
//  Copyright © 2019 iCorki. All rights reserved.
//

#import "LRunloopQueue.h"

#define ASRunLoopQueueVerboseLoggingEnabled 1

@interface LRunloopQueue() {
    CFRunLoopRef _runloop;
    CFRunLoopObserverRef _runloopObserver;
    CFRunLoopSourceRef _runloopSource;

}
@property (nonatomic, copy) void (^queueConsumer)(id dequeuedItem, BOOL isQueueDrained);

@end

static void runLoopSourceCallback(void *info) {
    // No-op
#if ASRunLoopQueueVerboseLoggingEnabled
    NSLog(@"<%@> - Called runLoopSourceCallback", info);
#endif
}

@implementation LRunloopQueue

- (instancetype)initWithRunloop:(CFRunLoopRef)runloop handler:(void (^)(id _Nullable, BOOL))handlerBlock {
    self = [super init];
    if (self) {
        _runloop = runloop;
        _queueConsumer = handlerBlock;
        __unsafe_unretained __typeof__(self) weakSelf = self;
        _runloopObserver = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            [weakSelf processQueue];
        });
        CFRunLoopAddObserver(_runloop, _runloopObserver, kCFRunLoopCommonModes);
        
        // add _runloopSource
        CFRunLoopSourceContext context = {};
#if ASRunLoopQueueVerboseLoggingEnabled
        context.info = (__bridge void *)self;
#endif
        context.perform = runLoopSourceCallback;
        _runloopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        CFRunLoopAddSource(_runloop, _runloopSource, kCFRunLoopCommonModes);
        
    }
    return self;
}

- (void)processQueue {
    NSLog(@"processQueue  ");
    
}


@end

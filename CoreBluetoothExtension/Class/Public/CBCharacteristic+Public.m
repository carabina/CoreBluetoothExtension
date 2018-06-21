//
//  CBCharacteristic+Public.m
//  Pods
//
//  Created by 谈超 on 2018/6/19.
//

#import "CBCharacteristic+Public.h"
#import "CBCharacteristic+Private.h"
#import "NSTimer+Public.h"
@import ReactiveObjC;
@implementation CBCharacteristic (Public)
- (instancetype)notify:(void (^)(BOOL))sucess{
    if (self.isNotifying) {
        if (sucess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(YES);
            });
        }
        return self;
    }
    @weakify(self)
    [self setNotifyClosure:^(BOOL b) {
        @strongify(self)
        if (sucess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(b);
            });
        }
        if (self) {
            [self setNotifyClosure:nil];
        }
    }];
    [self.service.peripheral setNotifyValue:YES forCharacteristic:self];
    return self;
}
- (instancetype)sendMessage:(NSData *)message duration:(NSTimeInterval)duration retryTimes:(NSInteger)retryTimes result:(void (^)(BOOL))sucess{
    if (self.service.peripheral.state != CBPeripheralStateConnected) {
        if (sucess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(NO);
            });
        }
        return self;
    }
    if (self.properties & CBCharacteristicPropertyWriteWithoutResponse) {
        [self.service.peripheral writeValue:message forCharacteristic:self type:CBCharacteristicWriteWithoutResponse];
        if (sucess) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(YES);
            });
        }
        return self;
    }
    if (self.properties & CBCharacteristicPropertyWrite)
    {
        NSInteger __block retryTs = retryTimes;
        dispatch_async(self.writeQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                @weakify(self)
                NSTimer *timer = [NSTimer after:duration block:^{
                    @strongify(self)
                    if (self) {
                        retryTs = 0;
                        void(^sucess)(BOOL) = self.sendMessageClosure;
                        if (sucess) {
                            sucess(false);
                        }
                    }
                }];
                @weakify(timer)
                [self setSendMessageClosure:^(BOOL result) {
                    @strongify(self)
                    if (--retryTs >= 0 && !result) {
                        [self.service.peripheral writeValue:message forCharacteristic:self type:CBCharacteristicWriteWithResponse];
                    }else{
                        @strongify(timer)
                        if (timer) {
                            [timer invalidate];
                            timer = nil;
                        }
                        if (sucess) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                sucess(result);
                            });
                        }
                        @strongify(self)
                        if (self) {
                            [self setSendMessageClosure:nil];
                            dispatch_semaphore_signal(self.writeSema);
                        }
                    }
                }];
                
            });
            [self.service.peripheral writeValue:message forCharacteristic:self type:CBCharacteristicWriteWithResponse];
            dispatch_semaphore_wait(self.writeSema, DISPATCH_TIME_FOREVER);
        });
        return self;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        sucess(false);
    });
    return self;
}
- (instancetype)notifyValueDidUpdate:(void (^)(CBCharacteristic *, NSError *))valueDidUpdateBlock{
    [self setNotifyValueDidUpdate:^(CBCharacteristic *cha, NSError *error) {
        if (valueDidUpdateBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                valueDidUpdateBlock(cha,error);
            });
        }
    }];
    return self;
}
@end

//
//  CBCharacteristic+Private.m
//  MobikeCoreBluetooth
//
//  Created by 谈超 on 2018/6/20.
//

#import "CBCharacteristic+Private.h"
@import ObjectiveC;
@implementation CBCharacteristic (Private)
- (void)setNotifyValueDidUpdate:(void (^)(CBCharacteristic *, NSError *))notifyValueDidUpdate{
    objc_setAssociatedObject(self, @selector(notifyValueDidUpdate), notifyValueDidUpdate, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(CBCharacteristic *, NSError *))notifyValueDidUpdate{
    return objc_getAssociatedObject(self, _cmd);
}
- (void (^)(BOOL))notifyClosure{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNotifyClosure:(void (^)(BOOL))notifyClosure{
    objc_setAssociatedObject(self, @selector(notifyClosure), notifyClosure, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(BOOL))sendMessageClosure{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setSendMessageClosure:(void (^)(BOOL))sendMessageClosure{
    objc_setAssociatedObject(self, @selector(sendMessageClosure), sendMessageClosure, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (dispatch_queue_t)writeQueue{
    dispatch_queue_t q = objc_getAssociatedObject(self, _cmd);
    if (!q) {
        q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        objc_setAssociatedObject(self, _cmd, q, OBJC_ASSOCIATION_ASSIGN);
    }
    return q;
}
- (dispatch_semaphore_t)writeSema{
    dispatch_semaphore_t sema = objc_getAssociatedObject(self, _cmd);
    if (!sema) {
        sema = dispatch_semaphore_create(1);
        objc_setAssociatedObject(self, _cmd, sema, OBJC_ASSOCIATION_ASSIGN);
    }
    return sema;
}
@end

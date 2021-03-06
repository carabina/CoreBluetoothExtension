//
//  CBCharacteristic+Private.h
//  MobikeCoreBluetooth
//
//  Created by 谈超 on 2018/6/20.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBCharacteristic (Private)
@property (nonatomic, copy) void (^notifyClosure)(BOOL);
@property (nonatomic, copy) void (^sendMessageClosure)(BOOL);
@property (nonatomic, assign, readonly) dispatch_queue_t writeQueue;
@property (nonatomic, assign, readonly) dispatch_semaphore_t writeSema;
@property (nonatomic, copy) void (^notifyValueDidUpdate)(CBCharacteristic *, NSError *);
@end

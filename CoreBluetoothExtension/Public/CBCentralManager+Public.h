//
//  CBCentralManager+Public.h
//  Pods
//
//  Created by 谈超 on 2018/6/8.
//


@import CoreBluetooth;
@interface CBCentralManager (Public)
// new一个蓝牙中心
+ (nonnull instancetype)newCentral NS_SWIFT_NAME(newCentral());

/**
 扫描附近蓝牙外设
 
 @param duration 扫描时间
 @param responseBlock 扫描回调
 @param complete 结束回调
 @return 蓝牙中心
 */
- (nonnull CBCentralManager *)scanForPeripheralsWithDuration:(NSTimeInterval) duration
                                       responseBlock:(void(^)(CBPeripheral *peripheral,NSDictionary<NSString *, id> * advertisementData,NSNumber *RSSI,NSError *error))responseBlock complete:(void(^)(void))complete;

/*!
 *  @method connectPeripheral:options:
 *
 *  @param peripheral   The <code>CBPeripheral</code> to be connected.
 *  @param options      An optional dictionary specifying connection behavior options.
 *  @param complete     A block called when connect action done
 *
 *  @discussion         Initiates a connection to <i>peripheral</i>. Connection attempts never time out and, depending on the outcome, will result
 *                      in a call to either {@link centralManager:didConnectPeripheral:} or {@link centralManager:didFailToConnectPeripheral:error:}.
 *                      Pending attempts are cancelled automatically upon deallocation of <i>peripheral</i>, and explicitly via {@link cancelPeripheralConnection}.
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral options:(nullable NSDictionary<NSString *,id> *)options duration:(NSTimeInterval)duration complete:(void(^)(CBPeripheral *peripheral,NSError *error))complete;
/*!
 *  @method cancelPeripheralConnection: resulte:
 *
 *  @param peripheral   A <code>CBPeripheral</code>.
 *  @param result       A <code>resultBlock</code>
 *
 *  @discussion         Cancels an active or pending connection to <i>peripheral</i>. Note that this is non-blocking, and any <code>CBPeripheral</code>
 *                      commands that are still pending to <i>peripheral</i> may or may not complete.
 *
 *
 */
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral resulte:(void(^)(CBPeripheral *peripheral,NSError *error))result;
@end

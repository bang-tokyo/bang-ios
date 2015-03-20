//
//  BLEPeripheralManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/10.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEPeripheralManager: NSObject {

    class var sharedInstance: BLEPeripheralManager {
        struct Static {
            static let instance = BLEPeripheralManager()
        }
        return Static.instance
    }

    private var peripheralManager: CBPeripheralManager!
    private var characteristic: CBMutableCharacteristic!
    private var responseDictonary = Dictionary<String, AnyObject>()

    override init() {
        super.init()

        peripheralManager = CBPeripheralManager(delegate: self, queue: QueueManager.sharedInstance.peripheralQueue())
        characteristic = CBMutableCharacteristic(
            type: kBLECharacteristicUUID,
            properties: CBCharacteristicProperties.Read,
            value: nil,
            permissions: CBAttributePermissions.Readable
        )

        FacebookManager.sharedInstance.requestUserData({
            [unowned self] (userData: NSDictionary) in
            self.responseDictonary["name"] = userData.objectForKey("name") as? String
            self.responseDictonary["id"] = userData.objectForKey("id") as? String
        })
    }

    func teardown() {
        self.peripheralManager = nil
    }

    func stopAdvertising() {
        peripheralManager.stopAdvertising()
    }
}

// MARK: - CBPeripheralManagerDelegate
extension BLEPeripheralManager: CBPeripheralManagerDelegate {

    // ServiceがperipheralManagerにaddされた時呼ばれる。
    func peripheralManager(peripheral: CBPeripheralManager!,
        didAddService service: CBService!,
        error: NSError!)
    {
        if error == nil {
            startAdvertising()
        } else {
            Tracker.sharedInstance.debug("サービスの追加に失敗しました")
        }
    }

    // CentralからReadリクエストを受け取った時に呼ばれる
    func peripheralManager(peripheral: CBPeripheralManager!,
        didReceiveReadRequest request: CBATTRequest!)
    {
        Tracker.sharedInstance.debug("didReceiveReadRequest...")
        request.value = NSJSONSerialization.dataWithJSONObject(responseDictonary, options: NSJSONWritingOptions.PrettyPrinted, error: nil)
        peripheralManager.respondToRequest(request, withResult: CBATTError.Success)
    }

    // TODO: - アプリがメモリ不足などで再起動した時に呼ばれる。peripheralを復帰処理を実装。
    func peripheralManager(peripheral: CBPeripheralManager!,
        willRestoreState dict: [NSObject : AnyObject]!)
    {
        Tracker.sharedInstance.debug("willRestoreState")
    }

    // Advertiseが開始された時呼ばれる
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        if error == nil {
            Tracker.sharedInstance.debug("PeripheralがAdvertisingを開始しました")
        } else {
            Tracker.sharedInstance.debug("PeripheralがAdvertisingの開始に失敗しました\(error)")
        }
    }

    // BLEの状態が変わった時に呼ばれる
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        Tracker.sharedInstance.debug("PeripheralのStateが変更されました(現在のState:\(peripheral.state.name))")

        if peripheral.state != CBPeripheralManagerState.PoweredOn {
            Tracker.sharedInstance.debug("StateがPoweredOnでないため処理を終了します")
            return;
        }

        // ServiceとCharacteristicsの登録
        var service = CBMutableService(type:kBLEServiceUUID, primary:true)
        service.characteristics = [self.characteristic]
        self.peripheralManager.addService(service)
    }

    /** TODO: -
        通知に成功した場合は返り値はYESとなるが、送信キューがいっぱいだったなどの場合にはNOが返る。
        この場合、再度利用可能になった場合にはperipheralManagerIsReadyToUpdateSubscribers:が呼び出される。
        つまり、レスポンスがNOだったら再送用の配列に入れておき、peripheralManagerIsReadyToUpdateSubscribers
        の中で再度 updateValue を呼び出すようにするとよい。
    **/
    func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager!) {
    }
}

// MARK: - Private functions
extension BLEPeripheralManager {
    private func startAdvertising() {
        self.peripheralManager?.startAdvertising([
            CBAdvertisementDataLocalNameKey: "",
            CBAdvertisementDataServiceUUIDsKey:[kBLEServiceUUID]
        ])
    }
}

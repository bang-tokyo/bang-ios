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
            static let instance: BLEPeripheralManager = BLEPeripheralManager()
        }
        return Static.instance
    }

    private var peripheralManager: CBPeripheralManager!
    private var characteristic: CBMutableCharacteristic!

    override init() {
        super.init()

        // TODO: - MainThreadじゃなくて専用のthreadを用意
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        characteristic = CBMutableCharacteristic(
            type: BLECharacteristicUUID,
            properties: CBCharacteristicProperties.Read,
            value: nil,
            permissions: CBAttributePermissions.Readable
        )
    }

    func teardown() {
        self.peripheralManager = nil
    }

    func stopAdvertising() {
        peripheralManager?.stopAdvertising()
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
            println("サービスの追加に失敗しました")
        }
    }

    // CentralからReadリクエストを受け取った時に呼ばれる
    func peripheralManager(peripheral: CBPeripheralManager!,
        didReceiveReadRequest request: CBATTRequest!)
    {
        println("didReceiveReadRequest")
        var responseDictonary: Dictionary = [
            "userId" : 11111,
            "data" : "hoge"
        ]
        request.value = NSKeyedArchiver.archivedDataWithRootObject(responseDictonary)
        peripheralManager?.respondToRequest(request, withResult: CBATTError.Success)
    }

    // TODO: - アプリがメモリ不足などで再起動した時に呼ばれる。peripheralを復帰処理を実装。
    func peripheralManager(peripheral: CBPeripheralManager!,
        willRestoreState dict: [NSObject : AnyObject]!)
    {
        println("willRestoreState")
    }

    // Advertiseが開始された時呼ばれる
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        if error == nil {
            println("PeripheralがAdvertisingを開始しました")
        } else {
            println("PeripheralがAdvertisingの開始に失敗しました\(error)")
        }
    }

    // BLEの状態が変わった時に呼ばれる
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        println("PeripheralのStateが変更されました(現在のState:\(peripheral.state.name))")

        if peripheral.state != CBPeripheralManagerState.PoweredOn {
            println("StateがPoweredOnでないため処理を終了します")
            return;
        }

        // ServiceとCharacteristicsの登録
        var service = CBMutableService(type:BLEServiceUUID, primary:true)
        service.characteristics = [self.characteristic]
        self.peripheralManager?.addService(service)
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
            CBAdvertisementDataServiceUUIDsKey:[BLEServiceUUID]
            ])
    }
}

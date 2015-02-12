//
//  BLECentralManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLECentralManager: NSObject {

    class var sharedInstance: BLECentralManager {
        struct Static {
            static let instance: BLECentralManager = BLECentralManager()
        }
        return Static.instance
    }

    private var centralManager: CBCentralManager!
    private var peripheralContainer: NSMutableSet!
    private var canScanning: Bool = false

    override init() {
        super.init()
        // TODO: - MainThreadじゃなくて専用のthreadを用意
        centralManager = CBCentralManager(delegate: self, queue: nil)
        peripheralContainer = NSMutableSet()
    }

    func startScanning() {
        if canScanning {
            centralManager.scanForPeripheralsWithServices([BLEServiceUUID],
                options:[CBCentralManagerScanOptionAllowDuplicatesKey: false]
            )
        }
    }
}

extension BLECentralManager: CBCentralManagerDelegate {

    // Peripheralが見つかった時呼ばれる
    func centralManager(
        central: CBCentralManager!,
        didDiscoverPeripheral peripheral: CBPeripheral!,
        advertisementData: [NSObject : AnyObject]!,
        RSSI: NSNumber!)
    {
        central.stopScan()
        central.connectPeripheral(peripheral, options: nil)
    }

    // Peripheralと接続ができた時に呼ばれる
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        // TODO: - Serviceを探す
        peripheral.delegate = self
        peripheral.discoverServices([BLEServiceUUID])
    }

    // CentralManagerの状態変化した時に呼ばれる(require)
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        println("state: \(central.state)")
        if central.state == CBCentralManagerState.PoweredOn {
            // TODO: - Scanning可能になった旨をViewControllerに通知
            canScanning = true
        }
    }

}

extension BLECentralManager: CBPeripheralDelegate {

    // PeripheralのServiceが見つかったら呼ばれる
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {

        if error != nil {
            println("error: \(error)")
            return
        }

        if peripheral.services.count == 0 {
            println("didDiscoverServices no services")
            return
        }

        for service: CBService in peripheral.services as [CBService]!  {
            // TODO: - ここでServiceのUUIDを判定して必要なものだけ処理するように
            peripheral.discoverCharacteristics(nil, forService: service)
        }
    }

    // PeripheralServiceからCharacteristicsが見つかったら呼ばれる
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {

        if error != nil {
            println("error: \(error)")
            return
        }

        if service.characteristics.count == 0 {
            println("didDiscoverCharacteristicsForService no characteristics")
            return
        }

        for characteristic: CBCharacteristic in service.characteristics as [CBCharacteristic]! {
            // TODO: - ここでcharacteristicのUUIDを判定して必要なものだけ処理するように
            if (characteristic.properties.rawValue & CBCharacteristicProperties.Read.rawValue > 0) {
                peripheral.readValueForCharacteristic(characteristic)
            }
        }
    }

    // データ読み出しが完了すると呼ばれる
    func peripheral(peripheral: CBPeripheral!, didWriteValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if (error != nil) {
            println("Failed... error: \(error)")
            return
        }
        println("Succeeded! service uuid: \(characteristic.service.UUID),characteristic uuid: \(characteristic.UUID), value: \(characteristic.value)")
    }
}

extension BLECentralManager {
    private func startSearching() {
        centralManager.scanForPeripheralsWithServices([BLEServiceUUID], options: nil)
    }


    private func stopSearching() {
        centralManager.stopScan()
    }
}

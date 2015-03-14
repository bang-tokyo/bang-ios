//
//  BLECentralManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol BLECentralManagerDelegate {
    func readyForScan()
    func notReadyForScan()
}

class BLECentralManager: NSObject {

    class var sharedInstance: BLECentralManager {
        struct Static {
            static let instance: BLECentralManager = BLECentralManager()
        }
        return Static.instance
    }

    var delegate: BLECentralManagerDelegate?

    private var centralManager: CBCentralManager!
    private var peripheralContainer: [CBPeripheral] = []
    private var canScanning: Bool = false

    override init() {
        super.init()
        // TODO: - MainThreadじゃなくて専用のthreadを用意
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func startScanning() {
        if canScanning {
            centralManager.scanForPeripheralsWithServices([BLEServiceUUID],
                options:[CBCentralManagerScanOptionAllowDuplicatesKey: false]
            )
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension BLECentralManager: CBCentralManagerDelegate {

    // CentralManagerの状態変化した時に呼ばれる(require)
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        switch central.state {
        case .PoweredOn:
            canScanning = true
            delegate?.readyForScan()
        default:
            Tracker.sharedInstance.debug("state: \(central.state)")
            canScanning = false
            delegate?.notReadyForScan()
        }
    }

    // Peripheralが見つかった時呼ばれる
    func centralManager(
        central: CBCentralManager!,
        didDiscoverPeripheral peripheral: CBPeripheral!,
        advertisementData: [NSObject : AnyObject]!,
        RSSI: NSNumber!)
    {
        if (find(peripheralContainer, peripheral) != nil) {
            Tracker.sharedInstance.debug("we´re allready connected to \(peripheral)")
        } else {
            peripheralContainer.append(peripheral)
            central.connectPeripheral(peripheral, options: nil)
        }
    }

    // Peripheralへの接続が失敗すると呼ばれる
    func centralManager(central: CBCentralManager!, didFailToConnectPeripheral peripheral: CBPeripheral!, error: NSError!){
        Tracker.sharedInstance.debug("didFailToConnectPeripheral \(peripheral) error:\(error)")
        removeFromPeripheralContainer(peripheral)
    }

    // Peripheralとの既存の接続が切断した時
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!){
        Tracker.sharedInstance.debug("didDisconnectPeripheral \(peripheral) error:\(error)")
        removeFromPeripheralContainer(peripheral)
    }

    // Peripheralと接続ができた時に呼ばれる
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        Tracker.sharedInstance.debug("didConnectPeripheral " + peripheral.name)
        peripheral.delegate = self
        peripheral.discoverServices([BLEServiceUUID])
    }
}

// MARK: - CBPeripheralDelegate
extension BLECentralManager: CBPeripheralDelegate {

    // PeripheralのServiceが見つかったら呼ばれる
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if error != nil {
            Tracker.sharedInstance.debug("error: \(error)")
            return
        }
        if peripheral.services.count == 0 {
            Tracker.sharedInstance.debug("didDiscoverServices no services")
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
            Tracker.sharedInstance.debug("error: \(error)")
            return
        }
        if service.characteristics.count == 0 {
            Tracker.sharedInstance.debug("didDiscoverCharacteristicsForService no characteristics")
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
            Tracker.sharedInstance.debug("Failed... error: \(error)")
            return
        }
        Tracker.sharedInstance.debug("Succeeded! service uuid: \(characteristic.service.UUID),　characteristic uuid: \(characteristic.UUID), value: \(characteristic.value)")
    }
}

// MARK: - Private functions
extension BLECentralManager {
    private func startSearching() {
        centralManager.scanForPeripheralsWithServices([BLEServiceUUID], options: nil)
    }

    private func stopSearching() {
        centralManager.stopScan()
    }

    private func removeFromPeripheralContainer(peripheral: CBPeripheral) {
        peripheralContainer = peripheralContainer.filter({ $0 == peripheral })
    }
}

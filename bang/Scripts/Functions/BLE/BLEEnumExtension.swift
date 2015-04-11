//
//  BLEEnumExtension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/11.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreBluetooth

extension CBCentralManagerState
{
    var name : NSString {
        get{
            var enumName = "CBCentralManagerState"
            var valueName = ""

            switch self {
            case .PoweredOff:
                valueName = enumName + "PoweredOff"
            case .PoweredOn:
                valueName = enumName + "PoweredOn"
            case .Resetting:
                valueName = enumName + "Resetting"
            case .Unauthorized:
                valueName = enumName + "Unauthorized"
            case .Unknown:
                valueName = enumName + "Unknown"
            case .Unsupported:
                valueName = enumName + "Unsupported"
            }

            return valueName
        }
    }
}

extension CBPeripheralState
{
    var name : NSString {
        get{
            var enumName = "CBPeripheralState"
            var valueName = ""

            switch self {
            case .Connected:
                valueName = enumName + "Connected"
            case .Connecting:
                valueName = enumName + "Connecting"
            case .Disconnected:
                valueName = enumName + "Disconnected"
            }

            return valueName
        }
    }
}

extension CBPeripheralManagerState
{
    var name : NSString {
        get{
            var enumName = "CBPeripheralManagerState"
            var valueName = ""

            switch self {
            case .PoweredOff:
                valueName = enumName + "PoweredOff"
            case .PoweredOn:
                valueName = enumName + "PoweredOn"
            case .Resetting:
                valueName = enumName + "Resetting"
            case .Unauthorized:
                valueName = enumName + "Unauthorized"
            case .Unknown:
                valueName = enumName + "Unknown"
            case .Unsupported:
                valueName = enumName + "Unsupported"
            }

            return valueName
        }
    }
}

//
//  BLEConfig.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreBluetooth

let kBLEServiceUUID = CBUUID(string: "8AA35DCE-F3AB-4B1D-8C23-602D1DCBDC12")
let kBLECharacteristicUUID = CBUUID(string: "D6994B86-0CC7-4188-BBFA-D61EBF234B7B")
let kBLECentralScaningTime: Int = 5
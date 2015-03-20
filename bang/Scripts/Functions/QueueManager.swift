//
//  QueueManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/03/20.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class QueueManager: NSObject {

    private struct Static {
        static var backgroundQueueForPeripheral = dispatch_queue_create("com.bang.background.gueue.peripheral", DISPATCH_QUEUE_SERIAL)
    }

    class var sharedInstance: QueueManager {
        struct Static {
            static let instance = QueueManager()
        }
        return Static.instance
    }

    func peripheralQueue() -> dispatch_queue_t {
        return Static.backgroundQueueForPeripheral
    }
}

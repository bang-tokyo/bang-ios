//
//  QueueManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/03/20.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

final class QueueManager: NSObject {

    static let sharedInstance = QueueManager()

    private struct Static {
        static var mainQueue = dispatch_get_main_queue()
        static var backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        static var backgroundQueueForDataStore = dispatch_queue_create("com.bang.background.queue.data_store", DISPATCH_QUEUE_SERIAL)
        static var backgroundQueueForPeripheral = dispatch_queue_create("com.bang.background.gueue.peripheral", DISPATCH_QUEUE_SERIAL)
    }

    func mainQueue() -> dispatch_queue_t {
        return Static.mainQueue
    }

    func backgroundQueueForDataStore() -> dispatch_queue_t {
        return Static.backgroundQueueForDataStore
    }

    func backgroundQueue() -> dispatch_queue_t {
        return Static.backgroundQueue
    }

    func peripheralQueue() -> dispatch_queue_t {
        return Static.backgroundQueueForPeripheral
    }
}

//
//  GCD.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

struct GCD {
    static func run(queue: dispatch_queue_t, _ block: () -> ()) {
        dispatch_async(queue, block)
    }

    static func runOnMainThread(block: () -> ()) {
        run(QueueManager.sharedInstance.mainQueue(), block)
    }

    static func runInBackground(block: () -> ()) {
        run(QueueManager.sharedInstance.backgroundQueue(), block)
    }
}

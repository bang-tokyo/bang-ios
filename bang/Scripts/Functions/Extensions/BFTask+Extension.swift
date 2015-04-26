//
//  BFTask+Extension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/26.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension BFTask {
    func showErrorIfNeeded() -> BFTask {
        return continueWithBlock({
            (task) -> AnyObject! in
            if task.cancelled { return task }
            if let error = task.error {
                Tracker.sharedInstance.error("\(error.description)")
                Alert.showError("\(error.description)")
            }
            return task
        })
    }
}
//
//  BangStatus.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/07.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum BangStatus: Int {
    case Default = 0 // not answered yet
    case Accept = 1
    case Deny = 2

    static func build(rawValue: Int?) -> BangStatus {
        return rawValue.flatMap { BangStatus(rawValue: $0) } ?? .Default
    }
}

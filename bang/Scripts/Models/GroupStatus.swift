//
//  GroupStatus.swift
//  bang
//
//  Created by takatatomoyuki on 2015/08/08.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum GroupStatus: Int {

    case Unknown = 0
    case Active = 1
    case Banned = 2

    static func build(rawValue: Int?) -> GroupStatus {
        return rawValue.flatMap { GroupStatus(rawValue: $0) } ?? .Unknown
    }
}

//
//  GroupUserStatus.swift
//  bang
//
//  Created by takatatomoyuki on 2015/10/09.
//  Copyright © 2015年 Yoshikazu Oda. All rights reserved.
//

enum GroupUserStatus: Int {

    case Unknown = 0
    case Active = 1
    case Banned = 2

    static func build(rawValue: Int?) -> GroupUserStatus {
        return rawValue.flatMap { GroupUserStatus(rawValue: $0) } ?? .Unknown
    }
}

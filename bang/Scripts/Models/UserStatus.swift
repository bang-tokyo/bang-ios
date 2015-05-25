//
//  UserStatus.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum UserStatus: Int {
    // TODO : - あとで直す
    case Unknown = 0
    case Active = 1
    case Banned = 2

    static func build(rawValue: Int?) -> UserStatus {
        return rawValue.flatMap { UserStatus(rawValue: $0) } ?? .Unknown
    }
}

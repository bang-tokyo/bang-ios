//
//  BloodType.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum BloodType: Int {
    case Unknown = 0
    case AType = 1
    case BType = 2
    case OType = 3
    case ABType = 4

    static func build(rawValue: Int?) -> BloodType {
        return rawValue.flatMap { BloodType(rawValue: $0) } ?? .Unknown
    }

    func name() -> String {
        switch self {
        case .AType:
            return localizedString("AType")
        case .BType:
            return localizedString("BType")
        case .OType:
            return localizedString("OType")
        case .ABType:
            return localizedString("ABType")
        default:
            return ""
        }
    }
}

//
//  Gender.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum Gender: Int {
    case Male = 1
    case Female = 2
    case Transgender = 3

    static func build(rawValue: Int?) -> Gender {
        return rawValue.flatMap { Gender(rawValue: $0) } ?? .Transgender
    }
}

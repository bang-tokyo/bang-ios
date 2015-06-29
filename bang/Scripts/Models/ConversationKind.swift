//
//  ConversationKind.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

enum ConversationKind: Int {
    case Default = 0 // not answered yet
    case Group = 1

    static func build(rawValue: Int?) -> ConversationKind {
        return rawValue.flatMap { ConversationKind(rawValue: $0) } ?? .Default
    }
}

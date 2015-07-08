//
//  APIResponse+User.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIResponse {
    class Group: Base {
        var ownerUserId: NSNumber!
        var name: String!
        var memo: String!
        var regionId: NSNumber!
        var status: NSNumber!
    }
}

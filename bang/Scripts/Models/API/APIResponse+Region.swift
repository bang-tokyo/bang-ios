//
//  APIResponse+Region.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Mantle

extension APIResponse{
    class Region: MTLModel, MTLJSONSerializing {
        var id: NSNumber!
        var name: String!
        var statusValue: NSNumber!

        class func JSONKeyPathsByPropertyKey() -> [NSObject: AnyObject]! {
            return [
                "statusValue": "status"
            ]
        }
    }
}

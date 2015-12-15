//
//  APIResponse+Facebook.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Mantle

extension APIResponse {
    struct Facebook {
        class User: MTLModel, MTLJSONSerializing {
            var id: String!
            var name: String!
            var gender: String!
            var firstName: String!
            var lastName: String!
            var birthday: String!

            class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
                return [
                    "firstName": "first_name",
                    "lastName": "last_name"
                ]
            }
        }
        class FriendUser: MTLModel, MTLJSONSerializing {
            var id: String!
            var name: String!
            var firstName: String!
            var lastName: String!
            class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
                return [
                    "firstName": "first_name",
                    "lastName": "last_name"
                ]
            }
        }
    }
}

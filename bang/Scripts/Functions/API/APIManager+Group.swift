//
//  APIManager+Group.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/04/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {

    func searchGroup() -> BFTask {
        return request(.GET, path: "/v1/groups/").APIErrorHandler()
    }
}

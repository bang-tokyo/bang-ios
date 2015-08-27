//
//  APIManager+Region.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func regionList() -> BFTask {
        return request(.GET, path: "/v1/regions").APIErrorHandler()
    }
}
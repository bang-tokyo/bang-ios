//
//  APIManager+Bang.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/30.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func requestBang(id: Int) -> BFTask {
        return request(.GET, path: "/v1/bang/request/\(id)").APIErrorHandler()
    }

    func replyBang(id: Int) -> BFTask {
        return request(.GET, path: "/v1/bang/reply/\(id)").APIErrorHandler()
    }

    func requestedList() -> BFTask {
        return request(.GET, path: "/v1/bang/requests").APIErrorHandler()
    }
}

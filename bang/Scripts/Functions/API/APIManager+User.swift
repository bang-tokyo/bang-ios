//
//  APIManager+User.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

extension APIManager {
    func registerUser(facebookId: String, name: String, birthday: String, gender: String) -> BFTask {
        return request(.POST, path: "/v1/users", parameters: [
            "facebook_id": facebookId,
            "name": name,
            "birthday": birthday,
            "gender": gender
        ])
    }

    func showUser(id: Int) -> BFTask {
        return request(.GET, path: "/v1/users/\(id)").APIErrorHandler()
    }

    func searchUser() -> BFTask {
        return request(.GET, path: "/v1/users/").APIErrorHandler()
    }
}

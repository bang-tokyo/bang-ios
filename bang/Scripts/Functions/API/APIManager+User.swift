//
//  APIManager+User.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

extension APIManager {
    func registerUser(facebookId: String, name: String, birthday: String, gender: String) -> APITask {
        return request(.POST, path: "/v1/users", parameters: [
            "facebookId": facebookId,
            "name": name,
            "birthday": birthday,
            "gender": gender
        ])
    }

    func showUser(id: Int) -> APITask {
        return request(.GET, path: "/v1/users/\(id)").then{ [unowned self] (JSON, errorInfo: APITask.ErrorInfo?) -> APITask in
            return self.generalErrorHandler(JSON, errorInfo: errorInfo)
        }
    }
}

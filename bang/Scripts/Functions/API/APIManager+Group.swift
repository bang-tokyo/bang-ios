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

    //グループbang一覧を要求する
    func searchGroup() -> BFTask {
        return request(.GET, path: "/v1/groups/").APIErrorHandler()
    }

    //自分の所属するグループを要求する
    func requestMyGroups() -> BFTask {
        return request(.GET, path: "/v1/groups/").APIErrorHandler()
    }
}

//
//  Tracker.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/03/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//
import Foundation

/** TODO: -
    Distribuionだったら表示しないとかある程度たまったらサーバーに送るなど
    機能追加したいのでクラスにしておく。
**/
class Tracker {

    class var sharedInstance: Tracker {
        struct Static {
            static let instance = Tracker()
        }
        return Static.instance
    }

    func debug(message: String) {
        println("\(message)")
    }

    func warn(message: String) {
        println("\(message)")
    }

    func error(message: String) {
        println("\(message)")
    }
}

//
//  MyAccount.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import SSKeychain

class MyAccount {

    class var sharedInstance: MyAccount {
        struct Static {
            static let instance = MyAccount()
        }
        return Static.instance
    }

    private struct UserDefaults {
        static let prefix = "myAccount."
        private struct Key {
            static let userId = prefix+"userId"
            static let hasToken = prefix+"hasToken"
        }
    }

    private struct KeyChain {
        static let serviceName = "bang"
        private struct Key {
            static let token = "token"
        }
    }

    var userId: NSNumber = 0
    var hasToken = false
    var token = "" { didSet{ saveToKeyChain() } }

    init() {
        loadFromKeyChain()
        loadFromUserDefaults()
    }

    var description: String {
        return "userId:\(userId), token:\(token), hasToken:\(hasToken)"
    }

    func isAuthorize() -> Bool {
        Tracker.sharedInstance.debug(description)
        return hasToken && !token.isEmpty && userId.integerValue > 0
    }

    func login(userId: NSNumber, token: String) {
        self.userId = userId
        self.token = token
        hasToken = true
        saveToUserDefaults()
    }

    func logout() {
        // TODO : - ログアウトAPIたたく(UserActivittiesレコードの削除など)
        clear()
        FacebookManager.sharedInstance.closeFacebookSession()
    }
}


// MARK: - Private functions
extension MyAccount {

    private func saveToKeyChain() {
        SSKeychain.setPassword(self.token, forService: KeyChain.serviceName, account: KeyChain.Key.token)
    }

    private func loadFromKeyChain() {
        if let token = SSKeychain.passwordForService(KeyChain.serviceName, account: KeyChain.Key.token) {
            self.token = token
        }
    }

    private func saveToUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(userId, forKey: UserDefaults.Key.userId)
        userDefaults.setBool(hasToken, forKey: UserDefaults.Key.hasToken)
        userDefaults.synchronize()
    }

    private func loadFromUserDefaults() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let _userId = userDefaults.objectForKey(UserDefaults.Key.userId) as? NSNumber {
            userId = _userId
        }
        hasToken = userDefaults.boolForKey(UserDefaults.Key.hasToken)
    }

    private func clear() {
        SSKeychain.deletePasswordForService(KeyChain.serviceName, account: KeyChain.Key.token)
        userId = 0
        hasToken = false
        saveToUserDefaults()
    }
}

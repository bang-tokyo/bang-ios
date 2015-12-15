//
//  FacebookManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import FacebookSDK

let kFBReadPermissions: [String] = ["public_profile", "user_birthday", "user_friends"]

class FacebookManager: NSObject {

    class var sharedInstance: FacebookManager {
        struct Static {
            static let instance = FacebookManager()
        }
        return Static.instance
    }

    func authorize() -> BFTask {
        return login().FacebookSessionErrorHandler().continueWithBlock{
            [weak self] _ -> AnyObject! in
            return self?.requestUserData()
        }
    }

    func requestUserData() -> BFTask {
        let completionSource = BFTaskCompletionSource()

        FBRequest.requestForMe().startWithCompletionHandler {
            (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                completionSource.setError(error)
            } else {
                completionSource.setResult(result)
            }
        }

        return completionSource.task
    }

    func requestUserFriends() -> BFTask {
        let completionSource = BFTaskCompletionSource()

        FBRequest.requestForMyFriends().startWithCompletionHandler {
            (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in

            if error != nil {
                completionSource.setError(error)
            } else {
                completionSource.setResult(result)
            }
        }

        return completionSource.task
    }

    func closeFacebookSession() {
        FBSession.activeSession().closeAndClearTokenInformation()
    }
}

// MARK: - Praivate functions
extension FacebookManager {

    private func login() -> BFTask {
        let completionSource = BFTaskCompletionSource()

        closeFacebookSession()
        FBSession.setActiveSession(nil)

        var handler: FBSessionStateHandler? = {
            (session : FBSession!, state : FBSessionState, error : NSError?) in
            FBSession.setActiveSession(session)
            if error != nil {
                completionSource.setError(error)
            } else {
                completionSource.setResult(nil)
            }
        }

        FBSession.openActiveSessionWithReadPermissions(kFBReadPermissions, allowLoginUI: true, completionHandler: {
            (session, state, error) -> Void in
            handler?(session, state, error)
            handler = nil
        })

        return completionSource.task
    }

//    private func showAlertAboutError(text: String) {
//        UIAlertView(
//            title: localizedString("facebookAlertTitle"),
//            message: text,
//            delegate: nil,
//            cancelButtonTitle: localizedString("confirm")
//        ).show()
//    }
}

//
//  FacebookManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class FacebookManager: NSObject {

    class var sharedInstance: FacebookManager {
        struct Static {
            static let instance: FacebookManager = FacebookManager()
        }
        return Static.instance
    }

    var isLogined: Bool = false

    func openFacebookSession() {
        if FBSession.activeSession().state == FBSessionState.Open
            || FBSession.activeSession().state == FBSessionState.OpenTokenExtended {
            FBSession.activeSession().closeAndClearTokenInformation()
        } else {
            FBSession.openActiveSessionWithReadPermissions(FBReadPermissions, allowLoginUI: true, completionHandler: {
                (session, state, error) -> Void in
                self.sessionStateChanged(session, state: state, error: error)
            })
        }
    }

    func sessionStateChanged(session : FBSession, state : FBSessionState, error : NSError?) {
        switch state {
        case .Open:
            // If the session was opened successfully
            isLogined = true
        default:
            // If the session closed
            isLogined = false
            println("openSession Error: \(error)")
        }
    }

}

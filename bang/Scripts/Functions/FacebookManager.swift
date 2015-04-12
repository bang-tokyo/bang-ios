//
//  FacebookManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/14.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import FacebookSDK

protocol FacebookManagerDelegate {
    func handlerFacebookSessionStateChanged(isLogined: Bool)
}

class FacebookManager: NSObject {

    class var sharedInstance: FacebookManager {
        struct Static {
            static let instance = FacebookManager()
        }
        return Static.instance
    }

    var delegate: FacebookManagerDelegate?
    private var isLogined: Bool = false

    // MARK: - Functions of authentication.
    // 認証済みでSessionを再開するだけの場合(AppDelegate専用)
    func openFacebookSessionIfStateCreatedTokenLoaded() -> Bool {
        if FBSession.activeSession().state == FBSessionState.CreatedTokenLoaded {
            // allowLoginUI set false. This prevents login dialog from showing
            FBSession.openActiveSessionWithReadPermissions(kFBReadPermissions, allowLoginUI: false, completionHandler: {
                (session, state, error) -> Void in
                self.sessionStateChanged(session, state: state, error: error)
            })
        }
        return isLogined
    }

    func openFacebookSession() {
        if
            FBSession.activeSession().state != FBSessionState.Open &&
            FBSession.activeSession().state != FBSessionState.OpenTokenExtended
        {
            FBSession.openActiveSessionWithReadPermissions(kFBReadPermissions, allowLoginUI: true, completionHandler: {
                (session, state, error) -> Void in
                self.sessionStateChanged(session, state: state, error: error)
            })
        }
    }

    func closeFacebookSession() {
        FBSession.activeSession().closeAndClearTokenInformation()
    }

    func setStateChangeHandler() {
        FBSession.activeSession().setStateChangeHandler({
            (session: FBSession!, state: FBSessionState, error: NSError!) -> Void in
            self.sessionStateChanged(session, state: state, error: error)
        })
    }

    // MARK: - Functions of FBRequest
    func requestUserData(success:((userData: NSDictionary)->Void)?) {
        if let facebookUserData = GlobalData.sharedInstance.facebookUserData {
            success?(userData: facebookUserData)
        } else {
            if FBSession.activeSession().isOpen {
                FBRequest.requestForMe().startWithCompletionHandler({
                    (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    if error == nil {
                        let userData = result as! NSDictionary
                        GlobalData.sharedInstance.facebookUserData = userData
                        success?(userData: userData)
                    }
                })
            }
        }
    }
}

// MARK: - Praivate functions
extension FacebookManager {

    private func sessionStateChanged(session : FBSession, state : FBSessionState, error : NSError?) {
        switch state {
        case .Open:
            isLogined = true
        case .Closed, .ClosedLoginFailed:
            isLogined = false
        default:
            if (error != nil) {
                if FBErrorUtility.shouldNotifyUserForError(error) {
                    showAlertAboutError(FBErrorUtility.userMessageForError(error))
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.UserCancelled {
                    // If the user cancelled login, do nothing
                    Tracker.sharedInstance.debug("user cancelled login.")
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.AuthenticationReopenSession {
                    // Handle session closures that happen outside of the app
                    showAlertAboutError("Your current session is no longer valid. Please log in again.")
                }
                else {
                    showAlertAboutError("Something wrong")
                }
            }
            closeFacebookSession()
            isLogined = false
        }
        delegate?.handlerFacebookSessionStateChanged(isLogined)
    }

    private func showAlertAboutError(text: String) {
        UIAlertView(
            title: NSLocalizedString("facebookAlertTitle", comment: ""),
            message: text,
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("confirm", comment: "")
        ).show()
    }
}

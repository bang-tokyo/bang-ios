//
//  BFTask+Facebook.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import FacebookSDK

extension BFTask {
    func FacebookSessionErrorHandler() -> BFTask {
        return continueWithBlock{
            (task) -> AnyObject! in

            if let error = task.error {
                if FBErrorUtility.shouldNotifyUserForError(error) {
                    Tracker.sharedInstance.error("Facebook Session Error : \(FBErrorUtility.userMessageForError(error))")
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.UserCancelled {
                    // If the user cancelled login, do nothing
                    Tracker.sharedInstance.debug("Facebook Session Error : user cancelled login.")
                }
                else if FBErrorUtility.errorCategoryForError(error) == FBErrorCategory.AuthenticationReopenSession {
                    // Handle session closures that happen outside of the app
                    Tracker.sharedInstance.debug("Facebook Session Error : Your current session is no longer valid.")
                }
                else {
                    Tracker.sharedInstance.error("Facebook Session Error : Something wrong : \(error)")
                }
                FacebookManager.sharedInstance.closeFacebookSession()
                return BFTask.cancelledTask()
            }
            return task
        }
    }
}
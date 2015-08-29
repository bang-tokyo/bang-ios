//
//  Error.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class Error {

    struct Domain {
        static let Value = "com.bang.error"
    }

    struct Key {
        static let Error = "Error/Error"
    }



    enum Code: Int {
        case Unknown = 0
        case HasNoFacebookAccessToken = 1
        case CameraNotAvailable
        case PhotoLibraryNotAvailable
        case TaskCancelled
    }

    class func create(code: Code = .Unknown) -> NSError {
        return create(code, error: nil)
    }

    class func create(code: Code, error: NSError!) -> NSError {
        var userInfo = [String: AnyObject]()

        if let v = error {
            userInfo[Key.Error] = v
            userInfo[NSLocalizedDescriptionKey] = Error.isNetworkError(v)
                ? localizedString("networkErrorMessage")
                : v.localizedDescription
        } else {
            userInfo[NSLocalizedDescriptionKey] = Error.buildErrorMessage(code)
        }
        return NSError(domain: Domain.Value, code: code.rawValue, userInfo: userInfo)
    }

    class func canHandle(error: NSError?) -> Bool {
        if let e = error {
            if e.domain == Domain.Value { return true }
        }
        return false
    }

    class func isEqual(error: NSError?, code: Code) -> Bool {
        if !canHandle(error) { return false }
        if let e = error {
            if e.code == code.rawValue { return true }
        }
        return false
    }
}

extension Error {
    private class func isNetworkError(error: NSError?) -> Bool {
        if let e = error {
            if e.domain != NSURLErrorDomain { return false }
            switch e.code {
            case NSURLErrorUnknown, NSURLErrorCancelled, NSURLErrorTimedOut, NSURLErrorCannotFindHost,
                NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet,
                NSURLErrorSecureConnectionFailed, NSURLErrorCannotLoadFromNetwork:
                return true
            default:
                return false
            }
        }
        return false
    }

    private class func buildErrorMessage(code: Code) -> String? {
        switch code {
        case .CameraNotAvailable: return localizedString("cameraNotAvailable")
        case .PhotoLibraryNotAvailable: return localizedString("photoLibraryNotAvailable")
        default: return nil
        }
    }
}

//
//  APIManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Alamofire
import Bolts

final class APIManager: NSObject {

    class var sharedInstance: APIManager {
        struct Static {
            static let instance = APIManager()
        }
        return Static.instance
    }

    enum APIMethod { case GET, POST, PUT, DELETE }

    private var manager: Manager!
    private var baseURL: String!

    override private init() {
        super.init()
        manager = Alamofire.Manager(configuration: buildSessionConfig())
        //baseURL = "http://api.localhost.local:3000"
        baseURL = "http://api.bang.com:3000"
    }

    func request(method: APIMethod, path: String) -> BFTask {
        return request(method, path: path, parameters: nil)
    }

    func request(method: APIMethod, path: String, parameters: [String: AnyObject]?) -> BFTask {
        var fullPath = baseURL + path
        Tracker.sharedInstance.debug("API Request: \(fullPath) parameters: \(parameters)")
        switch method {
        case .GET:
            return GET(fullPath, parameters: parameters)
        case .POST:
            return POST(fullPath, parameters: parameters)
        case .PUT:
            return PUT(fullPath, parameters: parameters)
        case .DELETE:
            return DELETE(fullPath, parameters: parameters)
        }
    }
}


// MARK: - Private functions
extension APIManager {

    private func GET(path: String, parameters: [String: AnyObject]? = nil) -> BFTask {
        var completionSource = BFTaskCompletionSource()

        var request = self.manager.request(.GET, path, parameters: parameters, encoding: .JSON)
        request.responseJSON { (request, response, JSON, error) in
            if let error = error {
                completionSource.setError(error)
                return
            }
            if let JSON = JSON as? [String: AnyObject] {
                completionSource.setResult(JSON)
                return
            }
        }

        return completionSource.task
    }

    private func POST(path: String, parameters: [String: AnyObject]? = nil) -> BFTask {
        var completionSource = BFTaskCompletionSource()
        var request = self.manager.request(.POST, path, parameters: parameters, encoding: .JSON)
        request.responseJSON { (request, response, JSON, error) in
            if let error = error {
                completionSource.setError(error)
                return
            }
            if let JSON = JSON as? [String: AnyObject] {
                completionSource.setResult(JSON)
                return
            }
        }

        return completionSource.task
    }

    private func PUT(path: String, parameters: [String: AnyObject]? = nil) -> BFTask {
        var completionSource = BFTaskCompletionSource()

        var request = self.manager.request(.PUT, path, parameters: parameters, encoding: .JSON)
        request.responseJSON { (request, response, JSON, error) in
            if let error = error {
                completionSource.setError(error)
                return
            }
            if let JSON = JSON as? [String: AnyObject] {
                completionSource.setResult(JSON)
                return
            }
        }

        return completionSource.task
    }

    private func DELETE(path: String, parameters: [String: AnyObject]? = nil) -> BFTask {
        var completionSource = BFTaskCompletionSource()

        var request = self.manager.request(.DELETE, path, parameters: parameters, encoding: .JSON)
        request.responseJSON { (request, response, JSON, error) in
            if let error = error {
                completionSource.setError(error)
                return
            }
            if let JSON = JSON as? [String: AnyObject] {
                completionSource.setResult(JSON)
                return
            }
        }

        return completionSource.task
    }

    private func buildSessionConfig() -> NSURLSessionConfiguration {
        var config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 20.0
        config.timeoutIntervalForResource = config.timeoutIntervalForRequest * 2.0
        config.HTTPAdditionalHeaders = buildHeader()
        config.HTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        return config
    }

    private func buildHeader() -> [String: AnyObject] {
        let headers = [
            "Accept-Encoding": "gzip,deflate,sdch",
            "X-Bang-Token": MyAccount.sharedInstance.token,
            "X-Bang-App-Id": GeneralInfo.sharedInstance.identifier,
            "X-Bang-App-Version": GeneralInfo.sharedInstance.version,
            "X-Bang-App-Version-Code": "\(GeneralInfo.sharedInstance.versionCode)",
            "X-Bang-Os": "ios",
            "X-Bang-Os-Version": GeneralInfo.sharedInstance.version,
            "X-Bang-Os-Model": GeneralInfo.sharedInstance.modelName,
            "X-Bang-Os-Uuid": ""
        ] as [String: AnyObject]
        return headers
    }
}

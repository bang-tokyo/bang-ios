//
//  APIManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/12.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager: NSObject {

    class var sharedInstance: APIManager {
        struct Static {
            static let instance = APIManager()
        }
        return Static.instance
    }

    enum APIMethod { case GET, POST, PUT, DELETE }
    typealias Progress = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
    typealias APITask = Task<Progress, [String: AnyObject], NSError>

    private var manager: Manager!
    private var baseURL: String!

    override private init() {
        super.init()
        manager = Alamofire.Manager(configuration: buildSessionConfig())
        baseURL = "http://api.localhost.local:3000"
    }

    func request(method: APIMethod, path: String) -> APITask {
        return request(method, path: path, parameters: nil)
    }

    func request(method: APIMethod, path: String, parameters: [String: AnyObject]?) -> APITask {
        var fullPath = baseURL + path
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

    func GET(path: String, parameters: [String: AnyObject]? = nil) -> APITask {
        return APITask{ progress, fulfill, reject, configure in
            var request = self.manager.request(.GET, path, parameters: parameters, encoding: .JSON)
            request.responseJSON { (request, response, JSON, error) in
                if let error = error {
                    reject(error)
                    return
                }
                if let JSON = JSON as? [String: AnyObject] {
                    fulfill(JSON)
                    return
                }
            }
        }
    }

    func POST(path: String, parameters: [String: AnyObject]? = nil) -> APITask {
        return APITask{ progress, fulfill, reject, configure in
            var request = self.manager.request(.POST, path, parameters: parameters, encoding: .JSON)
            request.responseJSON { (request, response, JSON, error) in
                if let error = error {
                    reject(error)
                    return
                }
                if let JSON = JSON as? [String: AnyObject] {
                    fulfill(JSON)
                    return
                }
            }
        }
    }

    func PUT(path: String, parameters: [String: AnyObject]? = nil) -> APITask {
        return APITask{ progress, fulfill, reject, configure in
            var request = self.manager.request(.PUT, path, parameters: parameters, encoding: .JSON)
            request.responseJSON { (request, response, JSON, error) in
                if let error = error {
                    reject(error)
                    return
                }
                if let JSON = JSON as? [String: AnyObject] {
                    fulfill(JSON)
                    return
                }
            }
        }
    }

    func DELETE(path: String, parameters: [String: AnyObject]? = nil) -> APITask {
        return APITask{ progress, fulfill, reject, configure in
            var request = self.manager.request(.DELETE, path, parameters: parameters, encoding: .JSON)
            request.responseJSON { (request, response, JSON, error) in
                if let error = error {
                    reject(error)
                    return
                }
                if let JSON = JSON as? [String: AnyObject] {
                    fulfill(JSON)
                    return
                }
            }
        }
    }

    // MARK: - Common functions for APITask
    func generalErrorHandler(JSON: [String: AnyObject]?, errorInfo: APITask.ErrorInfo?) -> APITask {
        return APITask{ progress, fulfill, reject, configure in
            if let errorInfo = errorInfo {
                // TODO : - Errorハンドリング
                println("ERROR : \(errorInfo.error)")
                reject(errorInfo.error!)
                return
            }
            if let JSON = JSON {
                println("JSON : \(JSON)")
                fulfill(JSON)
                return
            }
        }
    }
}


// MARK: - Private functions
extension APIManager {
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
            "X-Bang-Token": "",
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

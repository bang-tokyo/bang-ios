//
//  APIResponse.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/04/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Mantle

public struct APIResponse {

    static func parse<T: MTLModel where T: MTLJSONSerializing>(klass: T.Type, _ dictionary: AnyObject?) -> T? {
        if let _dictionary = dictionary as? NSDictionary {
            return MTLJSONAdapter.modelOfClass(klass, fromJSONDictionary: _dictionary as [NSObject : AnyObject], error: nil) as? T
        }
        return nil
    }

    static func parseJSONArray<T: MTLModel where T: MTLJSONSerializing>(klass: T.Type, _ array: AnyObject?) -> [T]? {
        if let _array = array as? NSArray {
            return MTLJSONAdapter.modelsOfClass(klass, fromJSONArray: _array as [AnyObject], error: nil) as? [T]
        }
        return nil
    }

    static func modelClassJSONTransformer<T: MTLModel where T: MTLJSONSerializing>(klass: T.Type) -> NSValueTransformer {
        return NSValueTransformer.mtl_JSONDictionaryTransformerWithModelClass(klass)
    }

    class Base: MTLModel, MTLJSONSerializing {
        var id: NSNumber!
        var createdAt: NSNumber!
        var updatedAt: NSNumber!

        class func JSONKeyPathsByPropertyKey() -> [NSObject: AnyObject]! {
            return [:]
        }
    }
}

//
//  NSManagedObject+Extension.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import MagicalRecord

extension NSManagedObject {

    class func firstById<T: NSManagedObject>(id: NSNumber, context: NSManagedObjectContext) -> T? {
        return MR_findFirstByAttribute("id", withValue: id, inContext: context) as? T
    }

    class func firstById<T: NSManagedObject>(id: NSNumber) -> T? {
        return firstById(id, context: NSManagedObjectContext.MR_defaultContext())
    }

    class func firstOrInitializeById<T: NSManagedObject>(id: NSNumber, context: NSManagedObjectContext) -> T {
        return firstOrInitialize("id", value: id, context: context)
    }

    class func firstOrInitialize<T: NSManagedObject>(attribute: String, value: AnyObject?, context: NSManagedObjectContext) -> T {
        if let record = MR_findFirstByAttribute(attribute, withValue: value, inContext: context) as? T {
            return record
        }
        return T.MR_createEntityInContext(context) as T
    }
}

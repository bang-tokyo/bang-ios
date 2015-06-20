// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserBangDto.swift instead.

import CoreData

enum UserBangDtoAttributes: String {
    case createdAt = "createdAt"
    case fromUserId = "fromUserId"
    case id = "id"
    case itemId = "itemId"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum UserBangDtoRelationships: String {
    case fromUser = "fromUser"
}

@objc
class _UserBangDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "UserBang"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _UserBangDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var fromUserId: NSNumber?

    // func validateFromUserId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var itemId: NSNumber?

    // func validateItemId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var statusValue: NSNumber?

    // func validateStatusValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var fromUser: UserDto?

    // func validateFromUser(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}


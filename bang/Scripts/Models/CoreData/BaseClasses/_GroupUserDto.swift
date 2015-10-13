// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroupUserDto.swift instead.

import CoreData

enum GroupUserDtoAttributes: String {
    case createdAt = "createdAt"
    case facebookId = "facebookId"
    case groupId = "groupId"
    case id = "id"
    case ownerFlg = "ownerFlg"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
    case userId = "userId"
}

enum GroupUserDtoRelationships: String {
    case group = "group"
}

@objc
class _GroupUserDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "GroupUser"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _GroupUserDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var facebookId: String?

    // func validateFacebookId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var groupId: NSNumber?

    // func validateGroupId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var ownerFlg: NSNumber?

    // func validateOwnerFlg(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var statusValue: NSNumber?

    // func validateStatusValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var userId: NSNumber?

    // func validateUserId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var group: GroupDto?

    // func validateGroup(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}


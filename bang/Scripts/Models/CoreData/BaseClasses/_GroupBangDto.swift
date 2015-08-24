// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroupBangDto.swift instead.

import CoreData

enum GroupBangDtoAttributes: String {
    case createdAt = "createdAt"
    case fromGroupId = "fromGroupId"
    case id = "id"
    case itemId = "itemId"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum GroupBangDtoRelationships: String {
    case fromGroup = "fromGroup"
}

@objc
class _GroupBangDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "GroupBang"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _GroupBangDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var fromGroupId: NSNumber?

    // func validateFromGroupId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

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
    var fromGroup: GroupDto?

    // func validateFromGroup(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}


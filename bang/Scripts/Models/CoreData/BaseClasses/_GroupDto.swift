// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to GroupDto.swift instead.

import CoreData

enum GroupDtoAttributes: String {
    case createdAt = "createdAt"
    case id = "id"
    case memo = "memo"
    case name = "name"
    case regionId = "regionId"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum GroupDtoRelationships: String {
    case groupBang = "groupBang"
    case groupUsers = "groupUsers"
}

@objc
class _GroupDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Group"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _GroupDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var memo: String?

    // func validateMemo(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var regionId: NSNumber?

    // func validateRegionId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var statusValue: NSNumber?

    // func validateStatusValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var groupBang: NSOrderedSet

    @NSManaged
    var groupUsers: NSOrderedSet

}

extension _GroupDto {

    func addGroupBang(objects: NSOrderedSet) {
        let mutable = self.groupBang.mutableCopy() as! NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.groupBang = mutable.copy() as! NSOrderedSet
    }

    func removeGroupBang(objects: NSOrderedSet) {
        let mutable = self.groupBang.mutableCopy() as! NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.groupBang = mutable.copy() as! NSOrderedSet
    }

    func addGroupBangObject(value: GroupBangDto!) {
        let mutable = self.groupBang.mutableCopy() as! NSMutableOrderedSet
        mutable.addObject(value)
        self.groupBang = mutable.copy() as! NSOrderedSet
    }

    func removeGroupBangObject(value: GroupBangDto!) {
        let mutable = self.groupBang.mutableCopy() as! NSMutableOrderedSet
        mutable.removeObject(value)
        self.groupBang = mutable.copy() as! NSOrderedSet
    }

}

extension _GroupDto {

    func addGroupUsers(objects: NSOrderedSet) {
        let mutable = self.groupUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.groupUsers = mutable.copy() as! NSOrderedSet
    }

    func removeGroupUsers(objects: NSOrderedSet) {
        let mutable = self.groupUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.groupUsers = mutable.copy() as! NSOrderedSet
    }

    func addGroupUsersObject(value: GroupUserDto!) {
        let mutable = self.groupUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.addObject(value)
        self.groupUsers = mutable.copy() as! NSOrderedSet
    }

    func removeGroupUsersObject(value: GroupUserDto!) {
        let mutable = self.groupUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.removeObject(value)
        self.groupUsers = mutable.copy() as! NSOrderedSet
    }

}

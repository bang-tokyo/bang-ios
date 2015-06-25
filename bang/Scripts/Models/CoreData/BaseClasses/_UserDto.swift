// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserDto.swift instead.

import CoreData

enum UserDtoAttributes: String {
    case birthday = "birthday"
    case createdAt = "createdAt"
    case facebookId = "facebookId"
    case genderValue = "genderValue"
    case id = "id"
    case name = "name"
    case savedAt = "savedAt"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum UserDtoRelationships: String {
    case conversationUser = "conversationUser"
    case userBang = "userBang"
}

@objc
class _UserDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "User"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _UserDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var birthday: String?

    // func validateBirthday(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var facebookId: String?

    // func validateFacebookId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var genderValue: NSNumber?

    // func validateGenderValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var name: String?

    // func validateName(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var savedAt: NSDate?

    // func validateSavedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var statusValue: NSNumber?

    // func validateStatusValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var conversationUser: NSSet

    @NSManaged
    var userBang: NSSet

}

extension _UserDto {

    func addConversationUser(objects: NSSet) {
        let mutable = self.conversationUser.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.conversationUser = mutable.copy() as! NSSet
    }

    func removeConversationUser(objects: NSSet) {
        let mutable = self.conversationUser.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.conversationUser = mutable.copy() as! NSSet
    }

    func addConversationUserObject(value: ConversationUserDto!) {
        let mutable = self.conversationUser.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.conversationUser = mutable.copy() as! NSSet
    }

    func removeConversationUserObject(value: ConversationUserDto!) {
        let mutable = self.conversationUser.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.conversationUser = mutable.copy() as! NSSet
    }

}

extension _UserDto {

    func addUserBang(objects: NSSet) {
        let mutable = self.userBang.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.userBang = mutable.copy() as! NSSet
    }

    func removeUserBang(objects: NSSet) {
        let mutable = self.userBang.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.userBang = mutable.copy() as! NSSet
    }

    func addUserBangObject(value: UserBangDto!) {
        let mutable = self.userBang.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.userBang = mutable.copy() as! NSSet
    }

    func removeUserBangObject(value: UserBangDto!) {
        let mutable = self.userBang.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.userBang = mutable.copy() as! NSSet
    }

}

// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ConversationDto.swift instead.

import CoreData

enum ConversationDtoAttributes: String {
    case createdAt = "createdAt"
    case id = "id"
    case kindValue = "kindValue"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum ConversationDtoRelationships: String {
    case conversationUsers = "conversationUsers"
}

@objc
class _ConversationDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "Conversation"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _ConversationDto.entity(managedObjectContext)
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
    var kindValue: NSNumber?

    // func validateKindValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var statusValue: NSNumber?

    // func validateStatusValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var conversationUsers: NSOrderedSet

}

extension _ConversationDto {

    func addConversationUsers(objects: NSOrderedSet) {
        let mutable = self.conversationUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.unionOrderedSet(objects)
        self.conversationUsers = mutable.copy() as! NSOrderedSet
    }

    func removeConversationUsers(objects: NSOrderedSet) {
        let mutable = self.conversationUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.minusOrderedSet(objects)
        self.conversationUsers = mutable.copy() as! NSOrderedSet
    }

    func addConversationUsersObject(value: ConversationUserDto!) {
        let mutable = self.conversationUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.addObject(value)
        self.conversationUsers = mutable.copy() as! NSOrderedSet
    }

    func removeConversationUsersObject(value: ConversationUserDto!) {
        let mutable = self.conversationUsers.mutableCopy() as! NSMutableOrderedSet
        mutable.removeObject(value)
        self.conversationUsers = mutable.copy() as! NSOrderedSet
    }

}

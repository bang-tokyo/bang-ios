// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ConversationUserDto.swift instead.

import CoreData

enum ConversationUserDtoAttributes: String {
    case conversationId = "conversationId"
    case createdAt = "createdAt"
    case id = "id"
    case updatedAt = "updatedAt"
    case userId = "userId"
}

enum ConversationUserDtoRelationships: String {
    case conversation = "conversation"
    case user = "user"
}

@objc
class _ConversationUserDto: NSManagedObject {

    // MARK: - Class methods

    class func entityName () -> String {
        return "ConversationUser"
    }

    class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _ConversationUserDto.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged
    var conversationId: NSNumber?

    // func validateConversationId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var createdAt: NSDate?

    // func validateCreatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var id: NSNumber?

    // func validateId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var updatedAt: NSDate?

    // func validateUpdatedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var userId: NSNumber?

    // func validateUserId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    // MARK: - Relationships

    @NSManaged
    var conversation: ConversationDto?

    // func validateConversation(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var user: UserDto?

    // func validateUser(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

}


// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to UserDto.swift instead.

import CoreData

enum UserDtoAttributes: String {
    case birthday = "birthday"
    case bloodTypeValue = "bloodTypeValue"
    case createdAt = "createdAt"
    case facebookId = "facebookId"
    case genderValue = "genderValue"
    case id = "id"
    case name = "name"
    case profileImage0 = "profileImage0"
    case profileImage1 = "profileImage1"
    case profileImage2 = "profileImage2"
    case profileImage3 = "profileImage3"
    case profileImage4 = "profileImage4"
    case profileImage5 = "profileImage5"
    case profileImagePath0 = "profileImagePath0"
    case profileImagePath1 = "profileImagePath1"
    case profileImagePath2 = "profileImagePath2"
    case profileImagePath3 = "profileImagePath3"
    case profileImagePath4 = "profileImagePath4"
    case profileImagePath5 = "profileImagePath5"
    case region = "region"
    case regionId = "regionId"
    case savedAt = "savedAt"
    case selfIntroduction = "selfIntroduction"
    case selfIntroductionLong = "selfIntroductionLong"
    case statusValue = "statusValue"
    case updatedAt = "updatedAt"
}

enum UserDtoRelationships: String {
    case conversationUser = "conversationUser"
    case messageUser = "messageUser"
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
    var bloodTypeValue: NSNumber?

    // func validateBloodTypeValue(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

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
    var profileImage0: NSNumber?

    // func validateProfileImage0(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImage1: NSNumber?

    // func validateProfileImage1(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImage2: NSNumber?

    // func validateProfileImage2(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImage3: NSNumber?

    // func validateProfileImage3(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImage4: NSNumber?

    // func validateProfileImage4(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImage5: NSNumber?

    // func validateProfileImage5(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath0: String?

    // func validateProfileImagePath0(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath1: String?

    // func validateProfileImagePath1(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath2: String?

    // func validateProfileImagePath2(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath3: String?

    // func validateProfileImagePath3(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath4: String?

    // func validateProfileImagePath4(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var profileImagePath5: String?

    // func validateProfileImagePath5(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var region: String?

    // func validateRegion(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var regionId: NSNumber?

    // func validateRegionId(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var savedAt: NSDate?

    // func validateSavedAt(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var selfIntroduction: String?

    // func validateSelfIntroduction(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

    @NSManaged
    var selfIntroductionLong: String?

    // func validateSelfIntroductionLong(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

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
    var messageUser: MessageDto?

    // func validateMessageUser(value: AutoreleasingUnsafePointer<AnyObject>, error: NSErrorPointer) {}

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

@objc(ConversationDto)
class ConversationDto: _ConversationDto {

    override var description: String {
        return "id:\(id), kind:\(kind.rawValue), statusValue:\(statusValue), updatedAt:\(updatedAt), createdAt:\(createdAt)"
    }

    var kind: ConversationKind = .Default {
        didSet {
            kindValue = kind.rawValue
        }
    }

    func partnerUsers() -> [UserDto] {
        let userId = MyAccount.sharedInstance.userId
        let conversationUsers = self.conversationUsers.array as! [ConversationUserDto]
        return conversationUsers.filter({
            (conversationUserDto: ConversationUserDto) -> Bool in
            conversationUserDto.userId != userId
        }).map({$0.user!})
    }

    func fill(conversation: APIResponse.Conversation) {
        id = conversation.id
        createdAt = conversation.createdAt
        updatedAt = conversation.updatedAt
        statusValue = conversation.statusValue
        kind = conversation.kind
    }
}

// MARK: - Class functions
extension ConversationDto {
    class func fetchAll(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController? {
        let predicate = NSPredicate(format: "statusValue = 0")
        return MR_fetchAllSortedBy(ConversationDtoAttributes.updatedAt.rawValue, ascending: false, withPredicate: predicate, groupBy: nil, delegate: delegate)
    }

    class func deleteAllInActive(context: NSManagedObjectContext) {
        let predicate = NSPredicate(format: "statusValue != 0")
        MR_deleteAllMatchingPredicate(predicate, inContext: context)
    }
}

@objc(MessageDto)
class MessageDto: _MessageDto {

    override var description: String {
        return "id:\(id), message:\(message), conversationId:\(conversationId), userId:\(userId), updatedAt:\(updatedAt), createdAt:\(createdAt)"
    }

    func isMine() -> Bool {
        return MyAccount.sharedInstance.userId == userId
    }

    func fill(message: APIResponse.Message) {
        id = message.id
        createdAt = message.createdAt
        updatedAt = message.updatedAt
        conversationId = message.conversationId
        userId = message.userId
        self.message = message.message
    }
}


// MARK: - Class functions
extension MessageDto {
    class func fetchAll(conversationId: Int, delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController? {
        let predicate = NSPredicate(format: "conversationId = %d && statusValue = 0", conversationId)
        return MR_fetchAllSortedBy(MessageDtoAttributes.updatedAt.rawValue, ascending: false, withPredicate: predicate, groupBy: nil, delegate: delegate)
    }
}

@objc(ConversationUserDto)
class ConversationUserDto: _ConversationUserDto {

    override var description: String {
        return "id:\(id), conversationId:\(conversationId), userId:\(userId), updatedAt:\(updatedAt), createdAt:\(createdAt)"
    }

    func fill(conversationUser: APIResponse.ConversationUser) {
        id = conversationUser.id
        createdAt = conversationUser.createdAt
        updatedAt = conversationUser.updatedAt
        conversationId = conversationUser.conversationId
        userId = conversationUser.userId
    }
}

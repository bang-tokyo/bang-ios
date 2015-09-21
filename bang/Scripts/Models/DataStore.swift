//
//  DataStore.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/02.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts
import MagicalRecord

final class DataStore: NSObject {
    static let sharedInstance = DataStore()

    private var queue: dispatch_queue_t

    override private init() {
        queue = QueueManager.sharedInstance.backgroundQueueForDataStore()
        super.init()
    }

    func saveUser(user: APIResponse.User) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveUser(user, context: context)
            return
        }
    }

    func saveUserBang(userBang: APIResponse.UserBang) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveUserBang(userBang, context: context)
            return
        }
    }

    func saveUserBangList(userBangList: [APIResponse.UserBang]) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveUserBangList(userBangList, context: context)
            return
        }
    }

    func saveConversationList(conversationList: [APIResponse.Conversation]) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveConversationList(conversationList, context: context)
            return
        }
    }

    func saveMessage(message: APIResponse.Message) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveMessage(message, context: context)
            return
        }
    }

    func saveGroup(group: APIResponse.Group) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveGroup(group, context: context)
            return
        }
    }

    func saveGroupList(groupList: [APIResponse.Group]) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveGroupList(groupList, context: context)
            return
        }
    }

    func saveMessageList(messageList: [APIResponse.Message]) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveMessageList(messageList, context: context)
            return
        }
    }

    func saveRegionList(regionList: [APIResponse.Region]) -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.saveRegionList(regionList, context: context)
            return
        }
    }

    func deleteAll() -> BFTask {
        return save {
            (context, willUpdate) -> Void in
            self.truncateAll(context)
        }
    }
}

// MARK: - Praivate functions
extension DataStore {
    private func save(block: (NSManagedObjectContext, inout Bool) -> Void) -> BFTask {
        let completionSource = BFTaskCompletionSource()

        GCD.run(queue) {
            var willUpdate = false

            MagicalRecord.saveWithBlockAndWait {
                (context) -> Void in
                block(context, &willUpdate)
            }
            completionSource.setResult(willUpdate)
        }

        return completionSource.task
    }

    private func saveUser(user: APIResponse.User, context: NSManagedObjectContext) -> UserDto {
        let userDto: UserDto = UserDto.firstOrInitializeById(user.id, context: context)
        userDto.fill(user)
        return userDto
    }

    private func saveUserBang(userBang: APIResponse.UserBang, context: NSManagedObjectContext) -> UserBangDto {
        let fromUser: UserDto = saveUser(userBang.fromUser, context: context)

        let userBangDto: UserBangDto = UserBangDto.firstOrInitializeById(userBang.id, context: context)
        userBangDto.fill(userBang)
        userBangDto.fromUser = fromUser
        return userBangDto
    }

    private func saveUserBangList(userBangList: [APIResponse.UserBang], context: NSManagedObjectContext) -> [UserBangDto] {
        return userBangList.map { self.saveUserBang($0, context: context) }
    }

    private func saveConversationUser(conversationUser: APIResponse.ConversationUser, context: NSManagedObjectContext) -> ConversationUserDto {
        let user: UserDto = saveUser(conversationUser.user, context: context)

        let conversationUserDto: ConversationUserDto = ConversationUserDto.firstOrInitializeById(conversationUser.id, context: context)
        conversationUserDto.fill(conversationUser)
        conversationUserDto.user = user
        return conversationUserDto
    }

    private func saveConversationUserList(conversationUserList: [APIResponse.ConversationUser], context: NSManagedObjectContext) -> [ConversationUserDto] {
        return conversationUserList.map { self.saveConversationUser($0, context: context) }
    }

    private func saveConversation(conversation: APIResponse.Conversation, context: NSManagedObjectContext) -> ConversationDto {
        let conversationUsers: [ConversationUserDto] = saveConversationUserList(conversation.conversationUsers, context: context)

        let conversationDto: ConversationDto = ConversationDto.firstOrInitializeById(conversation.id, context: context)
        conversationDto.fill(conversation)
        conversationDto.conversationUsers = NSOrderedSet(array: conversationUsers)
        return conversationDto
    }

    private func saveConversationList(conversationList: [APIResponse.Conversation], context: NSManagedObjectContext) -> [ConversationDto] {
        return conversationList.map { self.saveConversation($0, context: context) }
    }

    private func saveMessage(message: APIResponse.Message, context: NSManagedObjectContext) -> MessageDto {
        // NOTE : - ConversationでUserデータも一緒にとってくるのでここではすでにUserの情報はキャッシュしているものとする。
        let user = UserDto.firstById(message.userId, context: context) as! UserDto

        let messageDto: MessageDto = MessageDto.firstOrInitializeById(message.id, context: context)
        messageDto.fill(message)
        messageDto.user = user
        let layoutHeight = ConversationMessageTableViewCell.messageHeightCertainly(messageDto)
        messageDto.layoutHeight = layoutHeight
        messageDto.layoutVersion = kMessageLayoutVersion
        return messageDto
    }

    private func saveMessageList(messageList: [APIResponse.Message], context: NSManagedObjectContext) -> [MessageDto] {
        return messageList.map { self.saveMessage($0, context: context) }
    }

    private func saveGroup(group: APIResponse.Group, context: NSManagedObjectContext) -> GroupDto {
        let groupDto: GroupDto = GroupDto.firstOrInitializeById(group.id, context: context)
        groupDto.fill(group)
        return groupDto
    }

    private func saveGroupList(groupList: [APIResponse.Group], context: NSManagedObjectContext) -> [GroupDto] {
        return groupList.map { self.saveGroup($0, context: context) }
    }

    private func saveRegion(region: APIResponse.Region, context: NSManagedObjectContext) -> RegionDto {
        let regionDto: RegionDto = RegionDto.firstOrInitializeById(region.id, context: context)
        regionDto.fill(region)
        return regionDto
    }

    private func saveRegionList(regionList: [APIResponse.Region], context: NSManagedObjectContext) -> [RegionDto] {
        return regionList.map { self.saveRegion($0, context: context) }
    }

    // NOTE: - キャッシュが全部消えるので気をつけてね。
    private func truncateAll(context: NSManagedObjectContext) {
        MessageDto.MR_truncateAllInContext(context)
        ConversationUserDto.MR_truncateAllInContext(context)
        ConversationDto.MR_truncateAllInContext(context)

        UserBangDto.MR_truncateAllInContext(context)
        UserDto.MR_truncateAllInContext(context)
        GroupDto.MR_truncateAllInContext(context)
    }
}

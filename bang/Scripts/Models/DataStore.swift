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
            let user = self.saveUser(user, context: context)
            return
        }
    }
}

// MARK: - Praivate functions
extension DataStore {
    private func save(block: (NSManagedObjectContext, inout Bool) -> Void) -> BFTask {
        var completionSource = BFTaskCompletionSource()

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
}

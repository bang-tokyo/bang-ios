//
//  ConversationDetailDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class ConversationDetailDataHandler: NSObject {

    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!

    private var conversationId: Int!

    func setup(conversationId: Int, tableView: UITableView) {
        self.conversationId = conversationId
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self

        fetchedResultsControllerDelegate = DefaultFetchedResultsControllerDelegate(tableView)
        fetchedResultsController = MessageDto.fetchAll(conversationId, delegate: fetchedResultsControllerDelegate)
    }

    func loadData() {
        tableView.reloadData()
    }

    func fetchData() {
        APIManager.sharedInstance.showConversation(conversationId).continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let strongSelf = self, messageList = APIResponse.parseJSONArray(APIResponse.Message.self, task.result) {
                return DataStore.sharedInstance.saveMessageList(messageList)
            }
            return task
        })
    }
}

extension ConversationDetailDataHandler {
    private func getMessageDto(indexPath: NSIndexPath) -> MessageDto {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! MessageDto
    }
}

// MARK: - UITableViewDelegate
extension ConversationDetailDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let messageDto = getMessageDto(indexPath)
        let layoutHeight = ConversationMessageTableViewCell.messageHeight(messageDto)
        return layoutHeight
    }
}

// MARK: - UITableViewDataSource
extension ConversationDetailDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let messageDto = getMessageDto(indexPath)
        let identifier = messageDto.isMine() ? "messageMineCell" : "messageOtherCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! ConversationMessageTableViewCell
        cell.configure(messageDto)
        return cell
    }
}

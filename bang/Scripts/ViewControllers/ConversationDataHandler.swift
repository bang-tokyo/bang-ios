//
//  ConversationDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/21.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class ConversationDataHandler: NSObject {

    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self

        fetchedResultsControllerDelegate = DefaultFetchedResultsControllerDelegate(tableView)
        fetchedResultsController = ConversationDto.fetchAll(fetchedResultsControllerDelegate)
    }

    func loadData() {
        tableView.reloadData()
    }

    func fetchData() {
        APIManager.sharedInstance.conversationList().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let strongSelf = self, conversationList = APIResponse.parseJSONArray(APIResponse.Conversation.self, task.result) {
                return DataStore.sharedInstance.saveConversationList(conversationList)
            }
            return task
        })
    }
}

// MARK: - Private functions
extension ConversationDataHandler {
    private func getConversationDto(indexPath: NSIndexPath) -> ConversationDto {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! ConversationDto
    }
}

// MARK: - UITableViewDelegate
extension ConversationDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var conversationDto = getConversationDto(indexPath)
        if let conversationId = conversationDto.id {
            NotificationManager.notifyConversationDetailWillShow(conversationId.integerValue)
        }
    }
}

// MARK: - UITableViewDataSource
extension ConversationDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("conversationCell") as! ConversationTableViewCell
        if let conversationDto = fetchedResultsController.objectAtIndexPath(indexPath) as? ConversationDto {
            cell.configure(conversationDto)
        }
        return cell
    }
}

//
//  RequestedBangDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/07.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class RequestedBangDataHandler: NSObject {

    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!


    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self

        fetchedResultsControllerDelegate = DefaultFetchedResultsControllerDelegate(tableView)
        fetchedResultsController = UserBangDto.fetchAll(fetchedResultsControllerDelegate)
    }
}

// MARK: - Private functions
extension RequestedBangDataHandler {
    func loadData() {
        tableView.reloadData()
    }

    func fetchData() {
        APIManager.sharedInstance.requestedList().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let strongSelf = self, userBangList = APIResponse.parseJSONArray(APIResponse.UserBang.self, task.result) {
                return DataStore.sharedInstance.saveUserBangList(userBangList)
            }
            return task
        })
    }
}

// MARK: - UITableViewDelegate
extension RequestedBangDataHandler: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension RequestedBangDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("requestedBangCell") as! RequestedBangTableViewCell
        if let userBangDto = fetchedResultsController.objectAtIndexPath(indexPath) as? UserBangDto {
            cell.configure(userBangDto)
        }
        return cell
    }
}

//
//  GroupDataHandler.swift
//  bang
//
//  Created by takatatomoyuki on 2015/08/29.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class GroupDataHandler: NSObject {

    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!


    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self

        fetchedResultsControllerDelegate = DefaultFetchedResultsControllerDelegate(tableView)
        fetchedResultsController = GroupDto.fetchAll(fetchedResultsControllerDelegate)
    }

    func loadData() {
        tableView.reloadData()
    }

    func fetchData() {
        APIManager.sharedInstance.requestMyGroups().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let strongSelf = self, groupList = APIResponse.parseJSONArray(APIResponse.Group.self, task.result) {
                return DataStore.sharedInstance.saveGroupList(groupList)
            }
            return task
        })
    }
}

// MARK: - UITableViewDelegate
extension GroupDataHandler: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension GroupDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("groupListCell") as! GroupTableViewCell
        if let groupDto = fetchedResultsController.objectAtIndexPath(indexPath) as? GroupDto {
            cell.configure(groupDto)
        }
        return cell
    }
}

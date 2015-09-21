//
//  RegionSelectorDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class RegionSelectorDataHandler: NSObject {

    var delegate: RegionSelectorViewControllerDelegate!

    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self

        fetchedResultsControllerDelegate = DefaultFetchedResultsControllerDelegate(tableView)
        fetchedResultsController = RegionDto.fetchAll(fetchedResultsControllerDelegate)
    }

    func loadData() {
        tableView.reloadData()
    }

    func fetchData() {
        APIManager.sharedInstance.regionList().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let _ = self, regionList = APIResponse.parseJSONArray(APIResponse.Region.self, task.result) {
                return DataStore.sharedInstance.saveRegionList(regionList)
            }
            return task
        })
    }
}

// MARK: - Private functions
extension RegionSelectorDataHandler {
    private func getRegionDto(indexPath: NSIndexPath) -> RegionDto {
        return fetchedResultsController.objectAtIndexPath(indexPath) as! RegionDto
    }
}

// MARK: - UITableViewDelegate
extension RegionSelectorDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let regionDto = getRegionDto(indexPath)
        delegate.didSelectRegion(regionDto)
    }
}

// MARK: - UITableViewDataSource
extension RegionSelectorDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("regionCell") as! RegionSelectorTableViewCell
        if let regionDto = fetchedResultsController.objectAtIndexPath(indexPath) as? RegionDto {
            cell.configure(regionDto)
        }
        return cell
    }
}

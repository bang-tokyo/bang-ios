//
//  BloodTypeSelectorDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class BloodTypeSelectorDataHandler: NSObject {

    var delegate: BloodTypeSelectorViewControllerDelegate!

    private weak var tableView: UITableView!

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
extension BloodTypeSelectorDataHandler {
    private func getBloodType(indexPath: NSIndexPath) -> BloodType {
        return BloodType.build(indexPath.row + 1)
    }
}

// MARK: - UITableViewDelegate
extension BloodTypeSelectorDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let bloodType = getBloodType(indexPath)
        delegate.didSelectBloodType(bloodType)
    }

}

// MARK: - UITableViewDataSource
extension BloodTypeSelectorDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bloodTypeCell") as! BloodTypeSelectorTableViewCell
        cell.configure(getBloodType(indexPath))
        return cell
    }
}

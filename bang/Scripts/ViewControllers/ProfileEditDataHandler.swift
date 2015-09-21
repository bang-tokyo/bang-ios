//
//  ProfileEditDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/09.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class ProfileEditDataHandler: NSObject {

    private struct Const {
        static let Cells = [
            ( type: "ProfileEditImagesCell", id: "ProfileImages", key_format: "profile_image_%d"),
            ( type: "ProfileEditTextCell", id: "SelfIntroduction", key_format: "self_introduction"),
            ( type: "ProfileEditTextCell", id: "SelfIntroductionLong", key_format: "self_introduction_long"),
            ( type: "ProfileEditChoicesCell", id: "BloodType", key_format: "blood_type"),
            ( type: "ProfileEditChoicesCell", id: "Region", key_format: "region_id")
        ]
        static let CellHeightTypeOf = (
            ProfileEditImagesCell: UIScreen.mainScreen().bounds.width,
            ProfileEditTextCell: CGFloat(95.0),
            ProfileEditChoicesCell: CGFloat(84.0)
        )
    }

    var delegate: ProfileEditViewControllerDelegate!
    private weak var userDto: UserDto!
    private weak var tableView: UITableView!
    private var fetchedResultsController: NSFetchedResultsController!
    private var fetchedResultsControllerDelegate: DefaultFetchedResultsControllerDelegate!

    func setup(tableView: UITableView, userDto: UserDto) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.userDto = userDto
    }

    func updateBloodTypeState(bloodType: BloodType) {
        if let index = cellsIndexOf("BloodType") {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ProfileEditChoicesTableViewCell {
                cell.updateState(bloodType.rawValue, name: bloodType.name())
            }
        }
    }

    func updateRegionState(regionDto: RegionDto) {
        if let index = cellsIndexOf("Region") {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ProfileEditChoicesTableViewCell {
                cell.updateState(regionDto.id!.integerValue, name: regionDto.name!)
            }
        }
    }

    func getAllParameter() -> [String: AnyObject] {
        var parameters = [String: AnyObject]()
        for (var i = 0; i < Const.Cells.count; i++) {
            parameters = mergeParameters(parameters, parameterOf(Const.Cells[i].id))
        }
        return parameters
    }

    func loadData() {
        tableView.reloadData()
    }
}

extension ProfileEditDataHandler {
    private func cellsIndexOf(id: String) -> Int? {
        var index: Int? = nil
        for (var i = 0; i < Const.Cells.count; i++) {
            if Const.Cells[i].id == id {
                index = i
            }
        }
        return index
    }

    private func parameterOf(id: String) -> [String: AnyObject]? {
        if let index = cellsIndexOf(id) {
            let constCell = Const.Cells[index]
            switch constCell.type {
            case "ProfileEditImagesCell":
                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ProfileEditImagesTableViewCell {
                    return cell.parameters(constCell.key_format)
                }
            case "ProfileEditTextCell":
                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ProfileEditTextTableViewCell {
                    return [constCell.key_format: cell.value()]
                }
            case "ProfileEditChoicesCell":
                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? ProfileEditChoicesTableViewCell {
                    return [constCell.key_format: cell.id]
                }
            default:
                return nil
            }
        }
        return nil
    }

    private func mergeParameters(dist1: [String: AnyObject], _ dist2: [String: AnyObject]?) -> [String: AnyObject] {
        var result = [String: AnyObject]()
        for (key, value) in dist1 {
            result[key] = value
        }
        if let _dist2 = dist2 {
            for (key, value) in _dist2 {
                result[key] = value
            }
        }
        return result
    }
}

// MARK: - UITableViewDelegate
extension ProfileEditDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        switch Const.Cells[index].id {
        case "BloodType":
            delegate.openBloodTypeSelectorViewController()
        case "Region":
            delegate.openRegionSelectorViewController()
        default:
            return
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ProfileEditDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.Cells.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let index = indexPath.row
        switch Const.Cells[index].type {
        case "ProfileEditImagesCell":
            return Const.CellHeightTypeOf.ProfileEditImagesCell
        case "ProfileEditTextCell":
            return Const.CellHeightTypeOf.ProfileEditTextCell
        default:
            return Const.CellHeightTypeOf.ProfileEditChoicesCell
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch Const.Cells[index].id {
        case "ProfileImages":
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditImagesCell") as! ProfileEditImagesTableViewCell
            cell.configure(userDto)
            return cell
        case "SelfIntroduction":
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditTextCell") as! ProfileEditTextTableViewCell
            cell.configure(localizedString("selfIntroduction"), value: userDto.selfIntroduction!)
            return cell
        case "SelfIntroductionLong":
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditTextCell") as! ProfileEditTextTableViewCell
            cell.configure(localizedString("selfIntroductionLong"), value: userDto.selfIntroductionLong!)
            return cell
        case "BloodType":
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditChoicesCell") as! ProfileEditChoicesTableViewCell
            cell.configure(localizedString("bloodType"), id: userDto.bloodType.rawValue, name: userDto.bloodType.name())
            return cell
        case "Region":
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditChoicesCell") as! ProfileEditChoicesTableViewCell
            cell.configure(localizedString("region"), id: userDto.regionId!.integerValue, name: userDto.region!)
            return cell
        default:
            // 来ないはずだけどUITableViewCellかえさなきゃいけないので仮に返しておく
            return UITableViewCell()
        }
    }
}

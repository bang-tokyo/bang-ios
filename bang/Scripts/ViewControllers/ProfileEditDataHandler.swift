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
            ( type: "ProfileEditImagesCell", id: "ProfileImages" ),
            ( type: "ProfileEditTextCell", id: "SelfIntroduction" ),
            ( type: "ProfileEditTextCell", id: "SelfIntroductionLong" ),
            ( type: "ProfileEditChoicesCell", id: "BloodType" ),
            ( type: "ProfileEditChoicesCell", id: "Region" )
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
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditImagesCell") as! ProfileEditImagesTableViewCell
            cell.configure(userDto)
            return cell
        case "SelfIntroduction":
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditTextCell") as! ProfileEditTextTableViewCell
            cell.configure(localizedString("selfIntroduction"), value: "簡単な自己紹介")
            return cell
        case "SelfIntroductionLong":
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditTextCell") as! ProfileEditTextTableViewCell
            cell.configure(localizedString("selfIntroductionLong"), value: "詳細な自己紹介")
            return cell
        case "BloodType":
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditChoicesCell") as! ProfileEditChoicesTableViewCell
            cell.configure(localizedString("bloodType"), id: 1, name: "O型")
            return cell
        case "Region":
            var cell = tableView.dequeueReusableCellWithIdentifier("ProfileEditChoicesCell") as! ProfileEditChoicesTableViewCell
            cell.configure(localizedString("region"), id: 1, name: "東京都")
            return cell
        default:
            // 来ないはずだけどUITableViewCellかえさなきゃいけないので仮に返しておく
            return UITableViewCell()
        }
    }
}
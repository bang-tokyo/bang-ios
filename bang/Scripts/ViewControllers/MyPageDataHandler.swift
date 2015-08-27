//
//  MyPageDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/07/25.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class MyPageDataHandler: NSObject {

    private struct Const {
        static let Cells = [
            ( type: "MyPageProfileCell", id: "Profile" ),
            ( type: "MyPageMenueCell", id: "Setting" ),
            ( type: "MyPageMenueCell", id: "Help" ),
            ( type: "MyPageMenueCell", id: "Logout" )
        ]
        static let CellHeightTypeOf = (
            MyPageProfileCell: CGFloat(225.0),
            MyPageMenueCell: CGFloat(44.0)
        )
    }

    var delegate: MyPageViewControllerDelegate!
    private weak var userDto: UserDto!
    private weak var tableView: UITableView!

    func setup(tableView: UITableView, userDto: UserDto) {
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.userDto = userDto
    }

    func loadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension MyPageDataHandler: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        switch Const.Cells[index].id {
        case "Profile":
            delegate.openProfileViewController()
        case "Logout":
            delegate.logout()
        default:
            return
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyPageDataHandler: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.Cells.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let index = indexPath.row
        switch Const.Cells[index].type {
        case "MyPageProfileCell":
            return Const.CellHeightTypeOf.MyPageProfileCell
        default:
            return Const.CellHeightTypeOf.MyPageMenueCell
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch Const.Cells[index].id {
        case "Profile":
            var cell = tableView.dequeueReusableCellWithIdentifier("MyPageProfileCell") as! MyPageProfileTableViewCell
            cell.configure(userDto)
            return cell
        case "Setting":
            var cell = tableView.dequeueReusableCellWithIdentifier("MyPageMenuCell") as! MyPageMenuTableViewCell
            cell.configure(localizedString("setting"))
            return cell
        case "Help":
            var cell = tableView.dequeueReusableCellWithIdentifier("MyPageMenuCell") as! MyPageMenuTableViewCell
            cell.configure(localizedString("help"))
            return cell
        case "Logout":
            var cell = tableView.dequeueReusableCellWithIdentifier("MyPageMenuCell") as! MyPageMenuTableViewCell
            cell.configure(localizedString("logout"))
            return cell
        default:
            // 来ないはずだけどUITableViewCellかえさなきゃいけないので仮に返しておく
            return UITableViewCell()
        }
    }
}

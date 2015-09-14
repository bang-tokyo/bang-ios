//
//  ProfileEditImagesDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import LXReorderableCollectionViewFlowLayout

class ProfileEditImagesDataHandler: NSObject {

    private var imageNum: Int = 6

    private weak var userDto: UserDto!
    private weak var collectionView: UICollectionView!
    var photoSelector: PhotoSelector!

    func setup(collectionView: UICollectionView, userDto: UserDto) {
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.userDto = userDto

        photoSelector = PhotoSelector()
    }

    func loadData() {
        collectionView.reloadData()
    }

    func parameters(key_format: String) -> [String: AnyObject] {
        var parameters = [String: AnyObject]()
        for index in 0...imageNum-1 {
            let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as! ProfileEditImageCollectionViewCell
            parameters[String(format: key_format, index)] = cell.userProfileImageId
        }
        return parameters
    }
}

extension ProfileEditImagesDataHandler: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row

        photoSelector.show().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let strongSelf = self, error = task.error {
                if Error.isEqual(error, code: .TaskCancelled) { return task }
            }
            return task
        }).continueWithSuccessBlock({
            [weak self] (task) -> AnyObject! in
            ProgressHUD.show()
            if let image = task.result as? UIImage {
                return APIManager.sharedInstance.uploadMyImage(index, image: image)
            }
            return task
        }).hideProgressHUD().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if task.result == nil { return task }
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ProfileEditImageCollectionViewCell {
                if let url = task.result["imagePath"] as? String, id = task.result["id"] as? NSNumber {
                    cell.configure(id.integerValue, imagePath: url)
                }
            }
            return task
        })
    }
}

extension ProfileEditImagesDataHandler: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNum
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileEditImageCell", forIndexPath: indexPath) as! ProfileEditImageCollectionViewCell
        cell.configure(userDto.profileImageIdBy(indexPath.row)!.integerValue, imagePath: userDto.profileImagePathBy(indexPath.row)!)
        return cell
    }
}
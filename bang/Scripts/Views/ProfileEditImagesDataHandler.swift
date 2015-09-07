//
//  ProfileEditImagesDataHandler.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/19.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

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
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ProfileEditImageCollectionViewCell {
                if let url = task.result["imagePath"] as? String {
                    println(url)
                    cell.profileImageView.configure(url: NSURL(string: url), placeholderImage: nil, notRounded: false)
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
        cell.configure("")
        return cell
    }
}

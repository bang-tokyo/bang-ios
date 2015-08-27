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

    func setup(collectionView: UICollectionView, userDto: UserDto) {
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.userDto = userDto
    }

    func loadData() {
        collectionView.reloadData()
    }
}

extension ProfileEditImagesDataHandler: UICollectionViewDelegate {

}

extension ProfileEditImagesDataHandler: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNum
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProfileEditImageCell", forIndexPath: indexPath) as! ProfileEditImageCollectionViewCell
        return cell
    }
}

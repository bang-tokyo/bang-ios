//
//  UserMiddleSearchViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/27.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class UserMiddleSearchViewController: UIViewController {

    class func build() -> UserMiddleSearchViewController {
        var storyboard = UIStoryboard(name: "UserMiddleSearch", bundle: nil)
        return storyboard.instantiateInitialViewController() as! UserMiddleSearchViewController
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bangButton: UIButton!

    private var searchedUsers: [APIResponse.User] = []
    private var selectedTargetIndexPath: NSIndexPath?
    private var hasSelectedTarget = false

    private let widthSizeOfCell: CGFloat = 200 // Cellのサイズが200x200
    private let cellMargin:CGFloat = -100 // cell間のマージン
    private var bothEndsSpeceSizeOfCell: CGFloat = 0 // CollectionViewの両端に空けたスペースのサイズ

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        bothEndsSpeceSizeOfCell = view.frame.width/2 - widthSizeOfCell/2

        disableBangButton()
        searchTargetUsers()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSelectedTarget {
            hasSelectedTarget = true
            selectedTargetIndexPath = NSIndexPath(forRow: 0, inSection: 0)
            if selectedTargetIndexPath != nil && searchedUsers.count > 0 {
                enableBangButton()
                collectionView.scrollToItemAtIndexPath(selectedTargetIndexPath!, atScrollPosition: .CenteredHorizontally, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideBangBtn(sender: UIButton) {
        if let indexPath = selectedTargetIndexPath {
            var user = searchedUsers[indexPath.row]
            APIManager.sharedInstance.requestUserBang(user.id.integerValue).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                self?.searchedUsers.removeAtIndex(indexPath.row)
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()

                Alert.showNormal("Bang", message: "Bang For \(user.name) Complete!")
                return task
                })
        }
    }

    @IBAction func onTouchDownBangBtn(sender: UIButton) {
        println("touched")
    }
	
    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        self.closeViewController()
    }

    @IBAction func onSegmentValueChanged(sender: UISegmentedControl) {
        println("user")
        println(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
            case 0:
                let userMiddleSearchViewController = UserMiddleSearchViewController.build()
                self.presentViewController(userMiddleSearchViewController, animated: false, completion: nil)
            case 1:
                let groupMiddleSearchViewController = GroupMiddleSearchViewController.build()
                self.presentViewController(groupMiddleSearchViewController, animated: false, completion: nil)
            default:
                let userMiddleSearchViewController = UserMiddleSearchViewController.build()
                self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}

// MARK: - Private functions
extension UserMiddleSearchViewController {
    private func enableBangButton() {
        bangButton.hidden = false
        bangButton.enabled = true
    }

    private func disableBangButton() {
        bangButton.hidden = true
        bangButton.enabled = false
    }

    private func searchTargetUsers() {
        ProgressHUD.show()
        // 検索で帰ってきたUserデータはすぐ破棄するのでCoreDataにキャッシュしない。
        APIManager.sharedInstance.searchUser().hideProgressHUD().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let users = APIResponse.parseJSONArray(APIResponse.User.self, task.result) {
                self?.searchedUsers = users
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }
            return task
        })
    }
}

// MARK: - UICollectionViewDelegate
extension UserMiddleSearchViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        disableBangButton()
        selectedTargetIndexPath = nil
    }
	
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateCellScale()
    }

    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // スワイプした到着点の画面の中心にきたCellを選択すべきCellとする
        var targetPoint = CGPoint(x: collectionView.frame.width/2 + targetContentOffset.memory.x + cellMargin / 2 , y: collectionView.frame.height/2)
        var targetIndexPath = collectionView.indexPathForItemAtPoint(targetPoint)

        // 選択すべきCellの中心座標をスワイプの到着地点として再定義することでTargetCellの中心でスワイプを止める
        var targetX = (widthSizeOfCell + cellMargin) * CGFloat(targetIndexPath!.row)
        targetContentOffset.memory.x = targetX > 0 ? targetX : 0.0

        selectedTargetIndexPath = targetIndexPath
        enableBangButton()
    }
	
    private func updateCellScale() {

        //画面中心点
        let centerX = view.frame.width/2
		
        //スケール範囲
        let scalableRange = 100 + widthSizeOfCell / 2
		
        for cell in collectionView.visibleCells() as! [UICollectionViewCell] {
            //現在のcellのx座標(cellの中心)
            let posX = cell.frame.origin.x + widthSizeOfCell / 2 - collectionView.contentOffset.x
			
            //中心点との距離
            let diffX = abs(centerX - posX)
			
            if (scalableRange - diffX) > 0 {
                //倍率を算出
                var scale = (scalableRange - diffX) / scalableRange
                if let c = cell as? SearchTargetUserCollectionViewCell {
                    scale = (scale < 0.5) ? 0.5 : scale
                    c.containerView.alpha = scale * 1.25
					
                    //深度の設定
                    if scale >= 0.6 {
                        c.superview?.bringSubviewToFront(c)
                    }else{
                        c.superview?.sendSubviewToBack(c)
                    }
					
                    c.containerView.transform = CGAffineTransformMakeScale(scale, scale)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserMiddleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, bothEndsSpeceSizeOfCell, 0, bothEndsSpeceSizeOfCell);
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
}

// MARK: - UICollectionViewDataSource
extension UserMiddleSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchedUsers.count > 0 {
            enableBangButton()
        } else {
            disableBangButton()
        }
        return searchedUsers.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchTargetCell", forIndexPath: indexPath) as! SearchTargetUserCollectionViewCell
        var user = searchedUsers[indexPath.row]
        cell.setup(user)
		
        //TODO: 後日移動
        if indexPath.row > 0 {
            cell.containerView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        }else{
            cell.superview?.bringSubviewToFront(cell)
        }
        return cell
    }
}

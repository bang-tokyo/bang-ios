//
//  GroupMiddleSearchViewController.swift
//  bang
//
//  Created by Tomoyuki Takata on 2015/05/27.
//  Copyright (c) 2015年 Tomoyuki Takata. All rights reserved.
//

import UIKit

class GroupMiddleSearchViewController: UIViewController {

    class func build() -> GroupMiddleSearchViewController {
        var storyboard = UIStoryboard(name: "GroupMiddleSearch", bundle: nil)
        return storyboard.instantiateInitialViewController() as! GroupMiddleSearchViewController
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bangButton: UIButton!

    private var searchedGroups: [APIResponse.Group] = []
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
            if selectedTargetIndexPath != nil && searchedGroups.count > 0 {
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
            var user = searchedGroups[indexPath.row]
            APIManager.sharedInstance.requestBang(user.id.integerValue).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                self?.searchedGroups.removeAtIndex(indexPath.row)
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
        let userMiddleSearchViewController = UserMiddleSearchViewController.build()
        self.presentViewController(userMiddleSearchViewController, animated: false, completion: nil)
    }
}

// MARK: - Private functions
extension GroupMiddleSearchViewController {
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
        APIManager.sharedInstance.searchGroup().hideProgressHUD().continueWithBlock({
            [weak self] (task) -> AnyObject! in
            if let groups = APIResponse.parseJSONArray(APIResponse.Group.self, task.result) {
                self?.searchedGroups = groups
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()
            }
            return task
        })
    }
}

// MARK: - UICollectionViewDelegate
extension GroupMiddleSearchViewController: UICollectionViewDelegate {
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
                if let c = cell as? SearchTargetGroupCollectionViewCell {
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
extension GroupMiddleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, bothEndsSpeceSizeOfCell, 0, bothEndsSpeceSizeOfCell);
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
}

// MARK: - UICollectionViewDataSource
extension GroupMiddleSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchedGroups.count > 0 {
            enableBangButton()
        } else {
            disableBangButton()
        }
        return searchedGroups.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchTargetCell", forIndexPath: indexPath) as! SearchTargetGroupCollectionViewCell
        var user = searchedGroups[indexPath.row]
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

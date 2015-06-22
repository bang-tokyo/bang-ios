//
//  MiddleSearchViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/05/27.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class MiddleSearchViewController: UIViewController {

    class func build() -> MiddleSearchViewController {
        var storyboard = UIStoryboard(name: "MiddleSearch", bundle: nil)
        return storyboard.instantiateInitialViewController() as! MiddleSearchViewController
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

    @IBAction func onClickBangButton(sender: UIButton) {
        if let indexPath = selectedTargetIndexPath {
            var user = searchedUsers[indexPath.row]
            APIManager.sharedInstance.requestBang(Int(user.id)).continueWithBlock({
                [weak self] (task) -> AnyObject! in
                self?.searchedUsers.removeAtIndex(indexPath.row)
                self?.collectionView.reloadData()
                self?.collectionView.collectionViewLayout.invalidateLayout()

                // TODO : - Alert閉じたあと操作できなくなるので調査...
                //Alert.showNormal("Bang", message: "Bang For \(user.name) Complete!")
                var alrtView = UIAlertView(
                    title: "Bang",
                    message: "Bang For \(user.name) Complete!",
                    delegate: nil,
                    cancelButtonTitle: "OK"
                ).show()
                return task
            })
        }
    }

    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        self.closeViewController()
    }
}

// MARK: - Private functions
extension MiddleSearchViewController {
    private func enableBangButton() {
        //bangButton.hidden = false
        //bangButton.enabled = true
    }

    private func disableBangButton() {
        bangButton.hidden = true
        bangButton.enabled = false
    }

    private func searchTargetUsers() {
        // 検索で帰ってきたUserデータはすぐ破棄するのでCoreDataにキャッシュしない。
        APIManager.sharedInstance.searchUser().continueWithBlock({
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
extension MiddleSearchViewController: UICollectionViewDelegate {
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

		println(widthSizeOfCell - cellMargin)
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
				if let c = cell as? SearchTargetCollectionViewCell {
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
extension MiddleSearchViewController: UICollectionViewDelegateFlowLayout {
	
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, bothEndsSpeceSizeOfCell, 0, bothEndsSpeceSizeOfCell);
    }
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return cellMargin
	}

//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//		return 100.0
//	}
}

// MARK: - UICollectionViewDataSource
extension MiddleSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchedUsers.count > 0 {
            enableBangButton()
        } else {
            disableBangButton()
        }
        //return searchedUsers.count
		return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchTargetCell", forIndexPath: indexPath) as! SearchTargetCollectionViewCell
        //var user = searchedUsers[indexPath.row]
        //cell.setup(user)
		
		cell.containerView.transform = CGAffineTransformMakeScale(0.5, 0.5)
        return cell
    }
}

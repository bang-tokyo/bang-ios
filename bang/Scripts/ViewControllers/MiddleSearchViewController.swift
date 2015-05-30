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

    private var selectedTargetIndexPath: NSIndexPath?
    private var hasSelectedTarget = false

    private let widthSizeOfCell: CGFloat = 200 // Cellのサイズが200x200
    private var bothEndsSpeceSizeOfCell: CGFloat = 0 // CollectionViewの両端に空けたスペースのサイズ

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        bothEndsSpeceSizeOfCell = view.frame.width/2 - widthSizeOfCell/2
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !hasSelectedTarget {
            hasSelectedTarget = true
            selectedTargetIndexPath = NSIndexPath(forRow: 1, inSection: 0)
            if let indexPath = selectedTargetIndexPath {
                collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickCloseButton(sender: UIBarButtonItem) {
        self.closeViewController()
    }
}

// MARK: - Private functions
extension MiddleSearchViewController {
}

// MARK: - UICollectionViewDelegate
extension MiddleSearchViewController: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        selectedTargetIndexPath = nil
    }

    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // スワイプした到着点の画面の中心にきたCellを選択すべきCellとする
        var targetPoint = CGPoint(x: collectionView.frame.width/2 + targetContentOffset.memory.x, y: collectionView.frame.height/2)
        var targetIndexPath = collectionView.indexPathForItemAtPoint(targetPoint)

        // 以下の方法で該当のCellを撮ろうとすると速くスクロールした時に生成されていないCellが
        // 該当してしまう(targetCellがnil)ため上手く座標をとれないため一旦Cellのサイズ決め打ち
        //var targetCell = collectionView.cellForItemAtIndexPath(targetIndexPath!)

        // 選択すべきCellの中心座標をスワイプの到着地点として再定義することでTargetCellの中心でスワイプを止める
        var targetX = widthSizeOfCell * CGFloat(targetIndexPath!.row) - widthSizeOfCell / 2 + bothEndsSpeceSizeOfCell
        targetContentOffset.memory.x = targetX > 0 ? targetX : 0.0

        selectedTargetIndexPath = targetIndexPath
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MiddleSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, bothEndsSpeceSizeOfCell, 0, bothEndsSpeceSizeOfCell);
    }
}

// MARK: - UICollectionViewDataSource
extension MiddleSearchViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("searchTargetCell", forIndexPath: indexPath) as! SearchTargetCollectionViewCell
        cell.setup("\(indexPath.row)")
        return cell
    }
}

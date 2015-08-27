//
//  ProfileEditImagesTableViewCell.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/09.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import LXReorderableCollectionViewFlowLayout

class ProfileEditImagesTableViewCell: UITableViewCell {

    private struct Const {
        static let SectionInsetEachValue: CGFloat = 8.0
        static let SpacingValue: CGFloat = 8.0
        static let MaxColumn: Int = 3
    }

    @IBOutlet weak var collectionView: UICollectionView!

    private var dataHandler: ProfileEditImagesDataHandler!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(userDto: UserDto) {
        dataHandler = ProfileEditImagesDataHandler()
        dataHandler.setup(collectionView, userDto: userDto)

        if let layout = self.collectionView?.collectionViewLayout as? ProfileEditImagesFlowLayout {
            let inset = Const.SectionInsetEachValue
            layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            layout.minimumLineSpacing = Const.SpacingValue
            layout.minimumInteritemSpacing = Const.SpacingValue

            layout.maxColumn = Const.MaxColumn
            layout.cellPattern.append(sideLength: 2,heightLength: 2,column: 0,row: 0)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 2,row: 0)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 2,row: 1)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 0,row: 2)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 1,row: 2)
            layout.cellPattern.append(sideLength: 1,heightLength: 1,column: 2,row: 2)
        }

        dataHandler.loadData()
    }
}

class ProfileEditImagesFlowLayout: LXReorderableCollectionViewFlowLayout {
    private static let kMaxRow = 3
    var maxColumn = kMaxRow

    private var cellPattern:[(sideLength: CGFloat, heightLength:CGFloat, column:CGFloat, row:CGFloat)] = []
    private var sectionCells = [[CGRect]]()
    private var contentSize = CGSizeZero

    override func prepareLayout() {
        super.prepareLayout()
        sectionCells = [[CGRect]]()

        if let collectionView = self.collectionView {
            contentSize = CGSize(width: collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right, height: 0)
            let smallCellSideLength: CGFloat = (contentSize.width - super.sectionInset.left - super.sectionInset.right - (super.minimumInteritemSpacing * (CGFloat(maxColumn) - 1.0))) / CGFloat(maxColumn)

            for section in (0..<collectionView.numberOfSections()) {
                var cells = [CGRect]()
                var numberOfCellsInSection = collectionView.numberOfItemsInSection(section);
                var height = contentSize.height

                for i in (0..<numberOfCellsInSection) {
                    let position = i % (numberOfCellsInSection)
                    let cellPosition = position % cellPattern.count
                    let cell = cellPattern[cellPosition]
                    let x = (cell.column * (smallCellSideLength + super.minimumInteritemSpacing)) + super.sectionInset.left
                    let y = (cell.row * (smallCellSideLength + super.minimumLineSpacing)) + contentSize.height + super.sectionInset.top
                    let cellwidth = (cell.sideLength * smallCellSideLength) + ((cell.sideLength-1) * super.minimumInteritemSpacing)
                    let cellheight = (cell.heightLength * smallCellSideLength) + ((cell.heightLength-1) * super.minimumLineSpacing)

                    let cellRect = CGRectMake(x, y, cellwidth, cellheight)
                    cells.append(cellRect)

                    if (height < cellRect.origin.y + cellRect.height) {
                        height = cellRect.origin.y + cellRect.height
                    }
                }
                contentSize = CGSize(width: contentSize.width, height: height)
                sectionCells.append(cells)
            }
        }
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        if let collectionView = self.collectionView {
            for (var i = 0 ;i<collectionView.numberOfSections(); i++) {
                var sectionIndexPath = NSIndexPath(forItem: 0, inSection: i)

                var numberOfCellsInSection = collectionView.numberOfItemsInSection(i);
                for (var j = 0; j<numberOfCellsInSection; j++) {
                    let indexPath = NSIndexPath(forRow:j, inSection:i)
                    if let attributes = layoutAttributesForItemAtIndexPath(indexPath) {
                        if (CGRectIntersectsRect(rect, attributes.frame)) {
                            layoutAttributes.append(attributes)
                        }
                    }
                }
            }
        }
        return layoutAttributes
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = super.layoutAttributesForItemAtIndexPath(indexPath)
        attributes.frame = sectionCells[indexPath.section][indexPath.row]
        return attributes
    }

    override func collectionViewContentSize() -> CGSize {
        return contentSize
    }
}

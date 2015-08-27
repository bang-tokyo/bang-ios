//
//  BloodTypeSelectorViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/23.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

protocol BloodTypeSelectorViewControllerDelegate {
    func didSelectBloodType(bloodType: BloodType)
}

class BloodTypeSelectorViewController: UIViewController {

    class func build() -> (UINavigationController, BloodTypeSelectorViewController) {
        var storyboard = UIStoryboard(name: "BloodTypeSelector", bundle: nil)
        var navigationViewController = storyboard.instantiateInitialViewController() as! UINavigationController
        var bloodTypeSelectorViewController = navigationViewController.topViewController as! BloodTypeSelectorViewController
        return (navigationViewController, bloodTypeSelectorViewController)
    }

    @IBOutlet weak var tableView: UITableView!

    var delegate: ProfileEditViewControllerDelegate!
    var dataHandler: BloodTypeSelectorDataHandler!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataHandler = BloodTypeSelectorDataHandler()
        dataHandler.delegate = self
        dataHandler.setup(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BloodTypeSelectorViewController: BloodTypeSelectorViewControllerDelegate {
    func didSelectBloodType(bloodType: BloodType) {
        delegate.closeBloodTypeSelectorViewController(bloodType)
    }
}

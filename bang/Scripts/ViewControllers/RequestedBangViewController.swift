//
//  RequestedBangViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/01.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class RequestedBangViewController: UIViewController {

    class func build() -> RequestedBangViewController {
        var storyboard = UIStoryboard(name: "RequestedBang", bundle: nil)
        var tabBarViewController = storyboard.instantiateInitialViewController() as! UITabBarController
        var viewControllers = tabBarViewController.viewControllers as! [UIViewController]
        return viewControllers[0] as! RequestedBangViewController
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension RequestedBangViewController {
    func fetchData() {
//        APIManager.sharedInstance.requestedList().continueWithBlock({
//            [weak self] (task) -> AnyObject! in
//            if let users = APIResponse.parseJSONArray(APIResponse.User.self, task.result) {
//                self?.tableView.reloadData()
//            }
//            return task
//        })
    }
}

// MARK: - UITableViewDelegate
extension RequestedBangViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension RequestedBangViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("requestedBangCell") as! RequestedBangTableViewCell
        return cell
    }
}

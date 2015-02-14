//
//  SearchViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    class func build() -> SearchViewController {
        var storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        return storyboard.instantiateInitialViewController() as SearchViewController
    }

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func swipeUp(sender: AnyObject) {
        var rand: Int = Int(arc4random_uniform(10))
        label.text = "\(rand)"
    }

}

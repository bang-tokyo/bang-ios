//
//  SearchViewController.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/02/04.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: BaseViewController {

    class func build() -> SearchViewController {
        var storyboard = UIStoryboard(name: "Search", bundle: nil)
        return storyboard.instantiateInitialViewController() as! SearchViewController
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var locationInfoLabel: UILabel!
    @IBOutlet weak var locationInfoLabel2: UILabel!
    @IBOutlet weak var swipteUpGesture: UISwipeGestureRecognizer!

    var centralManager: BLECentralManager!
    private var locationManager = LocationManager()
    private var locationManager2 = LocationManager()
    private var isAdvertising: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        centralManager = BLECentralManager.sharedInstance
        centralManager.delegate = self

        locationManager.delegate = self
        locationManager.setUpStandardUpdates()
        locationManager.startLocationUpdates()

        locationManager2.delegate = self
        locationManager2.setUpSignificantChangeUpdates()
        locationManager2.startLocationUpdates()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopLocationUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction
    @IBAction func onClickProfileButton(sender: UIBarButtonItem) {
        var profileViewController = ProfileViewController.build()
        profileViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(profileViewController)
    }

    @IBAction func onClickContactButton(sender: UIBarButtonItem) {
        var contactViewController = ContactViewController.build()
        contactViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.moveTo(contactViewController)
    }

    @IBAction func swipeUp(sender: AnyObject) {
        label.text = "Scaning..."
        centralManager.startScanning()
    }
}

// MARK: - BLECentralManagerDelegate
extension SearchViewController: BLECentralManagerDelegate {
    func readyForScan() {
        label.text = "Ready For Search"
        swipteUpGesture.enabled = true
    }

    func notReadyForScan() {
        label.text = "Not Ready For Search"
        swipteUpGesture.enabled = false
    }

    func finishScaning(recieveDictonaries: [NSDictionary]) {
        for recieveDictonary in recieveDictonaries {
            var recieveDictonary = recieveDictonaries[0]
            var id = recieveDictonary["id"] as? String
            var name = recieveDictonary["name"] as? String
            var longitude = recieveDictonary["longitude"] as? String
            var latitude = recieveDictonary["latitude"] as? String
            Tracker.sharedInstance.debug("\(id) \(name) \(longitude) \(latitude)")
            label.text = "\(name)\n\(longitude)\n\(latitude)"
        }
        if recieveDictonaries.isEmpty {
            label.text = "Ready For Search"
        }
    }
}

// TODO: - テストが終わったら削除
extension SearchViewController: LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation, isSignificantChangeLocationService: Bool) {
        if isSignificantChangeLocationService {
            locationInfoLabel2.text = "\(location.coordinate.latitude)\n\(location.coordinate.longitude)\n\(location.horizontalAccuracy)"
        } else {
            locationInfoLabel.text = "\(location.coordinate.latitude)\n\(location.coordinate.longitude)\n\(location.horizontalAccuracy)"
        }
    }
}

// MARK: - Private functions
extension SearchViewController {

}

//
//  LocationManager.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/03/22.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdateLocation(location: CLLocation, isSignificantChangeLocationService: Bool)
}

class LocationManager: NSObject {

    var delegate: LocationManagerDelegate?
    private var location: CLLocation?
    private var locationManager: CLLocationManager!
    private var isSignificantChangeLocationService = false
    private var hasSetUp = false
    private var isUpdatingLocation = false
    private var successClosure: ((location: CLLocation) -> Void)?

    override init() {
        super.init()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    class func canUseLocationService() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    // NOTE: - 標準位置情報サービス(Peripheral用)
    func setUpStandardUpdates() {
        setUpBase()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = kLocationDistance
    }

    // NOTE: - 大幅変更位置情報サービス用(Location監視用)
    func setUpSignificantChangeUpdates() {
        setUpBase()
        isSignificantChangeLocationService = true
    }

    func startLocationUpdates(success:((location: CLLocation) -> Void)? = nil) {
        if let _success = success {
            successClosure = _success
        }
        if LocationManager.canUseLocationService() && hasSetUp && !isUpdatingLocation {
            if isSignificantChangeLocationService {
                locationManager.startMonitoringSignificantLocationChanges()
            } else {
                locationManager.startUpdatingLocation()
            }
            isUpdatingLocation = true
            Tracker.sharedInstance.debug("startLocationUpdates:\(isSignificantChangeLocationService) -->")
        }
    }

    func stopLocationUpdates() {
        if isUpdatingLocation {
            if isSignificantChangeLocationService {
                locationManager.stopMonitoringSignificantLocationChanges()
            } else {
                locationManager.stopUpdatingLocation()
            }
            isUpdatingLocation = false
            Tracker.sharedInstance.debug("<-- stopLocationUpdates:\(isSignificantChangeLocationService)")
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var newLocation = locations.last as! CLLocation
        var howRecent = newLocation.timestamp.timeIntervalSinceNow
        if isAdoptableLocation(newLocation) {
            location = newLocation
            delegate?.didUpdateLocation(newLocation, isSignificantChangeLocationService: isSignificantChangeLocationService)
            successClosure?(location: newLocation)
        }
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        Tracker.sharedInstance.debug("locationManager:didChangeAuthorizationStatus:\(status.rawValue)")
        switch status {
        case .AuthorizedAlways:
            break
        case .NotDetermined:
            stopLocationUpdates()
            locationManager.requestAlwaysAuthorization()
        default:
            stopLocationUpdates()
            // TODO: - CoreLocationのstatusがAuthorizedAlwaysでなくなった時は設定変更を促すViewをかぶせる
        }
    }
}

// MARK: - Praivate functions
extension LocationManager {
    private func setUpBase() {
        hasSetUp = true
    }

    private func isAdoptableLocation(location: CLLocation) -> Bool {
        var howRecent = location.timestamp.timeIntervalSinceNow
        Tracker.sharedInstance.debug("isAdoptableLocation \(abs(howRecent)) \(location.horizontalAccuracy )")
        return abs(howRecent) <= kLocationAdoptableTimeInterval
            && location.horizontalAccuracy <= kLocationAdoptableAccuracy
    }
}

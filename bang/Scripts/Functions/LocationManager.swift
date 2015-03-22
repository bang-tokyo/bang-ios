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
    func didUpdateLocation(location: CLLocation)
}

class LocationManager: NSObject {

    var delegate: LocationManagerDelegate?
    private var location: CLLocation?
    private var locationManager: CLLocationManager!
    private var isSignificantChangeLocationService = false
    private var hasSetUp = false
    private var isUpdatingLocation = false

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
        locationManager.distanceFilter = 100
    }

    // NOTE: - 大幅変更位置情報サービス用(Location監視用)
    func setUpSignificantChangeUpdates() {
        setUpBase()
        isSignificantChangeLocationService = true
    }

    func startLocationUpdates() {
        if LocationManager.canUseLocationService() && hasSetUp && !isUpdatingLocation {
            if isSignificantChangeLocationService {
                locationManager.startMonitoringSignificantLocationChanges()
            } else {
                locationManager.startUpdatingLocation()
            }
            isUpdatingLocation = true
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
        }
    }

    func stringLongitude() -> String {
        var longitude = ""
        if let _location = location {
           longitude = "\(_location.coordinate.longitude)"
        }
        return longitude
    }

    func stringLatitude() -> String {
        var latitude = ""
        if let _location = location {
            latitude = "\(_location.coordinate.latitude)"
        }
        return latitude
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var newLocation = locations.last as CLLocation
        var howReent = newLocation.timestamp.timeIntervalSinceNow
        if abs(howReent) < 15.0 || location == nil {
            delegate?.didUpdateLocation(newLocation)
            location = newLocation
        }
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.AuthorizedAlways:
            startLocationUpdates()
        default:
            stopLocationUpdates()
        }
    }
}

// MARK: - Praivate functions
extension LocationManager {
    private func setUpBase() {
        hasSetUp = true
    }
}

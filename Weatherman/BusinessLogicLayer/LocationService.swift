//
//  LocationService.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import CoreLocation
import Foundation

protocol LocationServiceDelegate: AnyObject {

    func didUpdateLocation()
    func didFoundBeacons(_ beacons: [CLBeacon])
}

class LocationService: NSObject {

    private var manager: CLLocationManager?

    weak var delegate: LocationServiceDelegate?

    static let sharedInstance = LocationService()

    var onAuthorizationStatusChanged: ((_ status: CLAuthorizationStatus) -> Void)?

    private override init() { }

    // MARK: - Common
    func configureLocationManager(_ completion: @escaping (_ status: CLAuthorizationStatus) -> Void = { _ in }) {

        self.manager = CLLocationManager()
        if let manager = manager {

            manager.delegate = self
            onAuthorizationStatusChanged = completion
            manager.requestAlwaysAuthorization()
        }
    }

    func locationServicesAvailable() -> Bool {
        let authorizationStatus = CLLocationManager.authorizationStatus()

        return CLLocationManager.locationServicesEnabled() &&
            (authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways)
    }

    // MARK: - Location
    func startUpdatingLocation() {

        guard locationServicesAvailable() else { return }

        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            manager?.allowsBackgroundLocationUpdates = true
            manager?.pausesLocationUpdatesAutomatically = true
        }
        manager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //manager?.distanceFilter = 100.0

        manager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager?.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.didUpdateLocation()
    }

    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        Logger.log("Failed monitoring region: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.log("Location manager failed: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status != .notDetermined {
            if status == .denied {
                Logger.log("location permission denied")
            } else {
                Logger.log("location permission success")
                if status == .authorizedAlways {
                    manager.allowsBackgroundLocationUpdates = true
                    manager.pausesLocationUpdatesAutomatically = true
                }
            }
            onAuthorizationStatusChanged?(status)
            onAuthorizationStatusChanged = nil
        }
    }
}

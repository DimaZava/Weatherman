//
//  LocationService.swift
//  Weatherman
//
//  Created by Dmitry Zawadsky on 19/03/2019.
//  Copyright © 2019 Dmitry Zawadsky. All rights reserved.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {

    func didUpdateLocation(_ location: CLLocation)
}

class LocationService: NSObject {

    // MARK: - Static members
    static let sharedInstance = LocationService()

    // MARK: - Properties
    private var manager: CLLocationManager?
    var latestLocation: CLLocation?
    weak var delegate: LocationServiceDelegate?
    var onAuthorizationStatusChanged: ((_ status: CLAuthorizationStatus) -> Void)?

    // MARK: - Lifecycle
    private override init() { }

    // MARK: - Common
    func configureLocationManager(_ completion: @escaping (_ status: CLAuthorizationStatus) -> Void = { _ in }) {

        self.manager = CLLocationManager()
        if let manager = manager {
            manager.delegate = self
            onAuthorizationStatusChanged = completion
            manager.requestWhenInUseAuthorization() //requestAlwaysAuthorization()
        }
    }

    func locationServicesAvailable() -> Bool {

        let authorizationStatus = CLLocationManager.authorizationStatus()
        return CLLocationManager.locationServicesEnabled() && authorizationStatus == .authorizedWhenInUse
    }

    // MARK: - Location
    func startUpdatingLocation() {

        guard locationServicesAvailable() else { return }

        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //manager?.allowsBackgroundLocationUpdates = true
            manager?.pausesLocationUpdatesAutomatically = true
        }
        manager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager?.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        manager?.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latestLocation = locations.first
        if let location = latestLocation {
            delegate?.didUpdateLocation(location)
        }
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
                //if status == .authorizedAlways {
                    //manager.allowsBackgroundLocationUpdates = true
                manager.pausesLocationUpdatesAutomatically = true
                //}
            }
            onAuthorizationStatusChanged?(status)
            onAuthorizationStatusChanged = nil
        }
    }
}

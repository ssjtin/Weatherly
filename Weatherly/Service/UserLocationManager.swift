//
//  LocationService.swift
//  Weatherly
//
//  Created by Hoang Luong on 20/3/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit
import CoreLocation

protocol UserLocationManagerProtocol: class {
    func updateLocation(city: String, countryIsoCode: String)
}

class UserLocationManager: NSObject, CLLocationManagerDelegate {

    enum AuthorizationError: Error {
        case LocationServicesDisabled
        case IncorrectAuthorizationStatus
    }
    
    weak var delegate: UserLocationManagerProtocol?

    let locationManager = CLLocationManager()
    var currentLocation: CLPlacemark?
    var authorizationError: AuthorizationError?
    
    override init() {
        super.init()
        
        
    }
    
    func getLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            authorizationError = AuthorizationError.LocationServicesDisabled
            return
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .authorizedWhenInUse else {
            
            switch authStatus {
            case .denied, .restricted:
                authorizationError = AuthorizationError.IncorrectAuthorizationStatus
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default: ()
            }
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    func updateCurrentLocation(completion: @escaping (CLPlacemark?) -> Void) {
        
        guard let lastLocation = locationManager.location else { print("No location returned"); return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastLocation) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completion(firstLocation)
            } else {
                print("error decoding location")
                completion(nil)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateCurrentLocation { (placemark) in
            
            guard let placemark = placemark else { return }
            
            if (placemark.locality != self.currentLocation?.locality) || (placemark.isoCountryCode != self.currentLocation?.isoCountryCode) {
                
                guard let city = placemark.locality, let countryIsoCode = placemark.isoCountryCode else { return }
                self.currentLocation = placemark
                self.delegate?.updateLocation(city: city, countryIsoCode: countryIsoCode)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }}

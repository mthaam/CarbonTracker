//
//  MapLocations.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 24/1/22.
//

import Foundation

/// This struct is used to create
/// placemarks used in location related
/// functions.
struct Placemark {
    var name: String
    var lat: Double
    var lon: Double
}

/// This struct is used to create
/// placemarks used in location related
/// functions.
struct Location {
    let streetNumber: String
    let streetType: String
    let streetName: String
    let cityName: String
    let postCode: String
    let country: String
    let placemark: Placemark
    
}

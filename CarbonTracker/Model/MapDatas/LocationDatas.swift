//
//  LocationDatas.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 26/1/22.
//

import Foundation

/// This class, conforming to singleton pattern,
/// is used to momentarily store user's adresses
/// while searching locations through CLLocation
/// framework.
class LocationDatas {
    
    static let sharedLocations = LocationDatas()
    
    private init() { }
    
    var startingPlacemark: Location?
    var destinationPlacemark: Location?
    
}

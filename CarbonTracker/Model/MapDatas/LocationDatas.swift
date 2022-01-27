//
//  LocationDatas.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 26/1/22.
//

import Foundation

class LocationDatas {
    
    static let sharedLocations = LocationDatas()
    
    private init() { }
    
    var startingPlacemark: Location?
    var destinationPlacemark: Location?
    
}

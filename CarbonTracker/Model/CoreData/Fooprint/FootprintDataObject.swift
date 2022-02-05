//
//  FootprintDataObject.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 2/2/22.
//

import Foundation

struct FootprintDataObject {
    let actualFootprint: Double
    let carMake: String
    let carModel: String
    let date: Date
    let startingAdressLat: Double
    let startingAdressLon: Double
    let destAdressLat: Double
    let destAdressLon: Double
    let startingAdress: String
    let destinationAdress: String
    let distance: Double
    let numberOfPax: Int16
    let numberOfSeats: Int16
    let occupancyScore: Int16
    let unoccupiedSeats: Int16
    let wastedCo2: Double
}

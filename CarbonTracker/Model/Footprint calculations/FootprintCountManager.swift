//
//  FootprintCountManager.swift
//  CarbonTracker
//
//  Created by SEBASTIEN BRUNET on 07/02/2022.
//

import Foundation

// MARK: - Class Declaration
final class FootprintCountManager {
    
    // MARK: - Private getters
    
    var co2Count: Double { get { _co2Count } }
    var wastedCo2Count: Double { get { _wastedCo2Count } }
    var occupancyAverage: Int { get { _occupancyAverage } }
    
    // MARK: - Private properties
    
    private var _co2Count = 0.0 {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateCo2Count"),
                                            object: nil, userInfo: ["updateDisplay": _co2Count])
        }
    }
    
    private var _wastedCo2Count = 0.0 {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateWastedCo2Count"),
                                            object: nil, userInfo: ["updateDisplay": _wastedCo2Count])
        }
    }
    
    private var _occupancyAverage = 0 {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateOccupancyAverage"),
                                            object: nil, userInfo: ["updateDisplay": _occupancyAverage])
        }
    }
    
}

extension FootprintCountManager {
    
    // MARK: - Functions
    
    /// This function calculates total
    /// amount of emitted co2.
    /// - Parameter array: an array of
    /// FootprintCdObject whose actual footprint
    /// value is used to perform calculation.
    func calculateFootprintsCo2Count(from array: [FootprintCdObject]) {
        var count = 0.0
        for footprint in array {
            count += footprint.actualFootprint
        }
        let formatedCount = formatNumber(withNumber: count)
        _co2Count = formatedCount
    }
    
    /// This function calculates total
    /// amount of wasted co2.
    /// - Parameter array: an array of
    /// FootprintCdObject whose wasted co2
    /// value is used to perform calculation.
    func calculateFootprintsWastedCo2Count(from array: [FootprintCdObject]) {
        var count = 0.0
        for footprint in array {
            count += footprint.wastedCo2
        }
        let formatedCount = formatNumber(withNumber: count)
        _wastedCo2Count = formatedCount
    }
    
    /// This function calculates average car
    /// occupancy.
    /// - Parameter array: an array of
    /// FootprintCdObject whose occupancyScore
    /// value is used to perform calculation.
    func calculateAverageCarOccupancy(from array: [FootprintCdObject]) {
        var total = 0
        array.forEach { footprint in
            total += Int(footprint.occupancyScore)
        }
        let average = total / array.count
        _occupancyAverage = average
    }
    
    /// This function formats given number
    /// to a 2 fraction digits double.
    private func formatNumber(withNumber number: Double) -> Double {
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.usesGroupingSeparator = false
        formater.maximumFractionDigits = 1
        formater.decimalSeparator = "."
        let doubleAsString =  formater.string(from: NSNumber(value: number))!
        let stringAsDouble = Double(doubleAsString)
        var double = 1.0
        if let unwrappedDouble = stringAsDouble {
            double = unwrappedDouble
        }
        return double
    }
    
    
}

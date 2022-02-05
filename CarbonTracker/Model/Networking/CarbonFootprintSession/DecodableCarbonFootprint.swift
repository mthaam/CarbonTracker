//
//  DecodedCarbonFootprint.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 29/1/22.
//

import Foundation

struct CarbonFootprintObject: Decodable {
    let data: CarbonFootprintData
}

struct CarbonFootprintData: Decodable {
    let id: String
    let type: String
    let attributes: FootprintAttributes
}

struct FootprintAttributes: Decodable {
    let distance_value: Double
    let vehicle_make: String
    let vehicle_model: String
    let vehicle_year: Int
    let vehicle_model_id: String
    let distance_unit: String
    let estimated_at: String
    let carbon_g: Int
    let carbon_lb: Double
    let carbon_kg: Double
    let carbon_mt: Double
}

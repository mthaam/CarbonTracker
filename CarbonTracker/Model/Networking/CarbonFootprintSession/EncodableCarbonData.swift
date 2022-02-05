//
//  EncodableCarbonData.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 29/1/22.
//

import Foundation

struct EncodableDataRequest: Encodable {
    let type: String
    let distance_unit: String
    let distance_value: Double
    let vehicle_model_id: String
}

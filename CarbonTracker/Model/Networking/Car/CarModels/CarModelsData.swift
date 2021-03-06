//
//  CarModelsData.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 17/1/22.
//

import Foundation

/// This structure is used to decode
/// received car model data.
struct CarModelDatas: Decodable {
    let data: CarModels
}

/// This structure is used to decode
/// received car model data.
struct CarModels: Decodable {
    let id: String
    let attributes: CarAttributes
}

/// This structure is used to decode
/// received car model data.
struct CarAttributes: Decodable {
    let name: String
    let year: Int
    let vehicle_make: String
}


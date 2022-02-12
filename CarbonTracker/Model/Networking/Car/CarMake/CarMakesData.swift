//
//  CarMakesData.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import Foundation

/// This structure is used to decode
/// received car make data.
struct CarMakesData: Decodable {
    let data: CarMakes
}

/// This structure is used to decode
/// received car make data.
struct CarMakes: Decodable {
    let id: String
    let attributes: Attributes
}

/// This structure is used to decode
/// received car make data.
struct Attributes: Decodable {
    let name: String
    let number_of_models: Int
}

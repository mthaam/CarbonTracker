//
//  CarMakesData.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import Foundation

struct CarMakesData: Decodable {
    let data: CarMakes
}

struct CarMakes: Decodable {
    let id: String
    let attributes: Attributes
}

struct Attributes: Decodable {
    let name: String
    let number_of_models: Int
}

//
//  CarModelsData.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 17/1/22.
//

import Foundation

struct CarModelDatas: Decodable {
    let data: CarModels
}

struct CarModels: Decodable {
    let id: String
    let attributes: CarAttributes
}

struct CarAttributes: Decodable {
    let name: String
    let year: Int
    let vehicle_make: String
}


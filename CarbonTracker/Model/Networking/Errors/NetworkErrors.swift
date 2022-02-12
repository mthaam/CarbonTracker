//
//  NetworkErrors.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 16/1/22.
//

import Foundation
import Alamofire

/// This enumeration defines cases
/// used in network related functions.
enum NetworkErrors: Error {
    case noData
    case unableToSetUrl
    case badResponse
    case unableToDecodeResponse
    case alamofireError(AFError)
    case unableToFindLocation
}

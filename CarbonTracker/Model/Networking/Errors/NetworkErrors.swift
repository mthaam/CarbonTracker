//
//  NetworkErrors.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 16/1/22.
//

import Foundation
import Alamofire

enum NetworkErrors: Error {
    case noData
    case unableToSetUrl
    case badResponse
    case unableToDecodeResponse
    case alamofireError(AFError)
}

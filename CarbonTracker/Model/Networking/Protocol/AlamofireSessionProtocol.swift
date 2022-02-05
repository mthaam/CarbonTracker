//
//  AlamofireSessionProtocol.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import Foundation
import Alamofire

/// This protocol defines a single
/// method to call real Alamofire when
/// used in production, and a fake AF response when
/// used for testing purpose.
protocol AlamofireSession {
    func request(with url: String, data: EncodableDataRequest?, completion: @escaping (AFDataResponse<Any>) -> Void)
}

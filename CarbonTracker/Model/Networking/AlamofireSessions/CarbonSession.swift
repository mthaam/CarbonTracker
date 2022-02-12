//
//  CarbonSession.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import Foundation
import Alamofire

/// This class is used to perform network calls
/// through Alamofire. It uses request() function
/// thanks to AlamofireSession protocol.
class CarbonSession: AlamofireSession {
    
    /// This function performs requests through
    /// Alamofire.
    func request(with url: String, data: EncodableDataRequest? = nil, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: "\(ApiKeys.carbonInterfaceKey)"),
            .contentType("application/json")
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { responseData in
            completion(responseData)
        }
    }
    
}

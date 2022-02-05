//
//  CarbonSession.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import Foundation
import Alamofire

class CarbonSession: AlamofireSession {
    
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

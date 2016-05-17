//
//  ServiceClient.swift
//  BernieMessenger
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Alamofire
import Freddy

final class ServiceClient {
    
    static func requestWithEndpoint<SerializedObject: JSONDecodable>(serviceEndpoint: ServiceEndpoint, completion: (ServiceResult<SerializedObject>) -> Void) {
        
        Alamofire.request(serviceEndpoint.URLRequest)
            .validate()
            .responseObject() {
                (alamofireResponse: Response<SerializedObject, NSError>) in
                
                let result: ServiceResult<SerializedObject>
                switch alamofireResponse.result {
                case .Success(let responseObject):
                    result = .Success(responseObject)
                    
                case .Failure:
                    // Response should never be nil, but just in case set it to 500
                    let httpStatusCode = alamofireResponse.response?.statusCode ?? 500
                    let error = ServiceError(httpStatusCode: httpStatusCode)
                    result = .Failure(error)
                }
                
                completion(result)
            }
    }
    
    static func requestWithEndpoint<SerializedObject: JSONDecodable>(serviceEndpoint: ServiceEndpoint, completion: (ServiceResult<[SerializedObject]>) -> Void) {
        
        Alamofire.request(serviceEndpoint.URLRequest)
            .validate()
            .responseArray() {
                (alamofireResponse: Response<[SerializedObject], NSError>) in
                
                let result: ServiceResult<[SerializedObject]>
                switch alamofireResponse.result {
                case .Success(let responseObject):
                    result = .Success(responseObject)
                    
                case .Failure:
                    // Response should never be nil, but just in case set it to 500
                    let httpStatusCode = alamofireResponse.response?.statusCode ?? 500
                    let error = ServiceError(httpStatusCode: httpStatusCode)
                    result = .Failure(error)
                }
                
                completion(result)
        }
    }
    
}

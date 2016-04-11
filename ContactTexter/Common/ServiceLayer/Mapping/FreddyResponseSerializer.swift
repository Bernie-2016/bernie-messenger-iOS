//
//  FreddyResponseSerializer.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

import Alamofire
import Freddy

// MARK: Object mapping

extension Request {
    
    /**
     Maps an object from the raw data returned from a service call and executes the specified
     closure after creating the object.
     
     - parameter keyPath:           The key path of a subset from a response that should be mapped.
     - parameter queue:             The queue to run the service call on.
     - parameter completionHandler: A closure that will execute after attempting to map a
     response object from the service call.
     
     - returns: The Alamofire request.
     */
    func responseObject<SerializedObject: JSONDecodable>(keyPath keyPath: String? = nil, queue: dispatch_queue_t? = nil, completionHandler:(Response<SerializedObject, NSError>) -> Void) -> Self {
        let serializer: ResponseSerializer<SerializedObject, NSError> = Request.ObjectResponseSerializer(keyPath)
        return response(queue: queue, responseSerializer: serializer, completionHandler: completionHandler)
    }
    
    /**
     Creates a ResponseSerializer object that is a closure to be executed with the
     raw data returned from a service call.
     
     If the response data is non-empty and can be mapped into a JSON object,
     mapping will be attempted. If mapping fails for any reason, the error will be 
     passed back.
     
     - parameter keyPath: The key path of a subset from a response that should be mapped.
     
     - returns: ResponseSerializer used by Alamofire to create a mappable object.
     */
    static func ObjectResponseSerializer<SerializedObject: JSONDecodable>(keyPath: String?) -> ResponseSerializer<SerializedObject, NSError> {
        
        return ResponseSerializer {
            (_, _, data: NSData?, originalError: NSError?) in
            
            do {
                // For now, not mapping any JSON for errors, return service `NSError`
                if let error = originalError {
                    return .Failure(error)
                }
                
                guard let data = data else {
                    let failureReason = "JSON could not be serialized. Input data was nil or zero length."
                    throw Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                }
                
                // Create JSON from data and map to key path if provided
                var json: JSON? = try JSON(data: data)
                if let keyPath = keyPath {
                    json = json?[keyPath]
                }
                
                guard json != nil else {
                    let failureReason = "Key path not valid for response."
                    throw Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                }
                
                // Map the object and return as success
                let mappedObject: SerializedObject = try json!.decode()
                return .Success(mappedObject)
                
            } catch {
                // JSON creation failed
                return .Failure(error as NSError)
            }
        }
    }
    
}

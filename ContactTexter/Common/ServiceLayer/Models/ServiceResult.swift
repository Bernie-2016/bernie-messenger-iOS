//
//  ServiceResult.swift
//  ContactTexter
//
//  Created by Justin Baumgartner on 4/10/16.
//  Copyright © 2016 Bernie Sanders 2016. All rights reserved.
//

/// Encapsulates the result of a service call of either a generic
/// `Value` on success or a `ServiceError` object on failure.
enum ServiceResult<Value> {
    
    /// Represents a successful service call.
    /// - parameter Value: Mapped object from service call.
    case Success(Value)
    
    /// Represents an error from a service call.
    /// - parameter ServiceError: Client created `ServiceError` to describe a failure.
    case Failure(ServiceError)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    var value: Value? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    var error: ServiceError? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
    
}

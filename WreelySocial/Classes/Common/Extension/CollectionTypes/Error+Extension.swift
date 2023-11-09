//
//  Error+Extension.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import Alamofire

extension Error {
    func getDetailErrorInfo() -> String? {
        var errorMessage : String = ""
        var errorReason : String = ""
        var statusCode : Int //Use it somewhere
        if let error = self as? AFError {
            statusCode = error._code // statusCode private
            switch error {
            case .invalidURL(let url):
                errorMessage = "Invalid URL: \(url) - \(error.localizedDescription)"
            case .parameterEncodingFailed(let reason):
                errorMessage = "Parameter encoding failed: \(error.localizedDescription)"
                errorReason = "Failure Reason: \(reason)"
            case .multipartEncodingFailed(let reason):
                errorMessage = "Multipart encoding failed: \(error.localizedDescription)"
                errorReason = "Failure Reason: \(reason)"
            case .responseValidationFailed(let reason):
                errorMessage = "Response validation failed: \(error.localizedDescription)"
                errorReason = "Failure Reason: \(reason)"
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    errorMessage = "Downloaded file could not be read"
                case .missingContentType(let acceptableContentTypes):
                    errorMessage = "Content Type Missing: \(acceptableContentTypes)"
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    errorMessage = "Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)"
                case .unacceptableStatusCode(let code):
                    statusCode = code
                    errorMessage = "Response status code was unacceptable: \(statusCode)"
                }
            case .responseSerializationFailed(let reason):
                errorMessage = "Response serialization failed: \(error.localizedDescription)"
                errorReason = "Failure Reason: \(reason)"
            }
            errorMessage = "Underlying error: \(String(describing: error.underlyingError))"
        } else if let error = self as? URLError { //Most of time because of no internet
            errorMessage = "\(error.localizedDescription)"
        } else if let error = self as? WSError {
            errorMessage = "\(error.localizedDescription)"
        } else {
            errorMessage = "Unknown error: \(String(describing: self))"
        }
        
        WSLogger.log(errorMessage, logType: .kError)
        WSLogger.log(errorReason, logType: .kError)
        
        return errorMessage + " " + errorReason
    }
}

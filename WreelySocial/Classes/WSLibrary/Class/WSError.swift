//
//  WSError.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 07/05/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation

protocol LocalizedDescriptionError: Error {
    var localizedDescription: String { get }
}

public enum WSError: LocalizedDescriptionError {
    case invalidArray(model: String)
    case invalidDictionary(model: String)
    case customError(message: String)

    var localizedDescription: String {
        switch self {
            case .invalidArray(model: let model):
                return "\(model) has an invalid array"
            case .invalidDictionary(model: let model):
                return "\(model) has an invalid dictionary"
            case .customError(message: let message):
                return "\(message)"
        }
    }
}


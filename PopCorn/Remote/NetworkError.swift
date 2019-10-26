//
//  NetworkError.swift
//  PopCorn
//
//  Created by Valmir Torres on 25/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidDecodeJSON
    case invalidData
    case defaultError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Description of invalid URL",
                                     comment: "Invalid URL")
        case .invalidDecodeJSON:
            return NSLocalizedString("Description of invalid JSON",
                                     comment: "Invalid JSON")
        case .invalidData:
            return NSLocalizedString("Description of invalid Data",
                                     comment: "Invalid Data")
        case .defaultError:
            return NSLocalizedString("Description of invalid default Error",
                                     comment: "default Error")
        }
    }
}

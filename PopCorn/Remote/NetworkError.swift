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
            return NSLocalizedString("We are having trouble contacting the server, try again later...",
                                     comment: "Invalid URL")
        case .invalidDecodeJSON:
            return NSLocalizedString("We are having server issues, try again later...",
                                     comment: "Invalid JSON")
        case .invalidData:
            return NSLocalizedString("We are having server issues, try again later...",
                                     comment: "Invalid Data")
        case .defaultError:
            return NSLocalizedString("Something is wrong, try again later...",
                                     comment: "default Error")
        }
    }
}

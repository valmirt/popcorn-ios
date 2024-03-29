//
//  Constants.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import UIKit

enum Web {
    static let BASE_URL = "https://api.themoviedb.org"
    static let BASE_URL_IMAGE = "https://image.tmdb.org"
    static let IMAGE_W45 = "/t/p/w45"
    static let IMAGE_W185 = "/t/p/w185"
    static let IMAGE_W300 = "/t/p/w300"
    static let IMAGE_W342 = "/t/p/w342"
    static let IMAGE_W500 = "/t/p/w500"
    static let IMAGE_W780 = "/t/p/w780"
    static let API_KEY = ""
    static let VERSION_API = "3"
}

enum General {
    static let FIRST = 1
    static let OFFSET = 5
}

enum Dimens {
    static let minimum: CGFloat = 4
    static let small: CGFloat = 6
    static let little: CGFloat = 8
    static let medium: CGFloat = 16
    static let big: CGFloat = 24
    static let large: CGFloat = 32
}

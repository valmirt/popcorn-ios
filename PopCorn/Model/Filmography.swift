//
//  Filmography.swift
//  PopCorn
//
//  Created by Valmir Junior on 03/12/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct Filmography: Decodable {
    let cast: [CreditedFilmography]
    let crew: [CreditedFilmography]
}

struct CreditedFilmography: Decodable {
    let id: Int
    let posterPath: String?
    let mediaType: String
}

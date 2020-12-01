//
//  People.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct People: Decodable {
    let biography: String
    let birthday: String?
    let knownForDepartment: String
    let deathday: String?
    let id: Int
    let name: String
    let popularity: Double
    let placeOfBirth: String?
    let profilePath: String?
}

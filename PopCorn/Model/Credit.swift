//
//  Credit.swift
//  PopCorn
//
//  Created by Valmir Junior on 28/09/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct Credit: Decodable {
    var id: Int
    var cast: [Cast]
    var crew: [Crew]
}

struct Cast: Decodable {
    var castId: Int
    var character: String
    var creditId: String
    var id: Int
    var name: String
    var profilePath: String?
}

struct Crew: Decodable {
    var creditId: String
    var id: Int
    var job: String
    var name: String
    var profilePath: String?
}

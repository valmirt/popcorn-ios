//
//  Crew.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct Crew: Decodable {
    var id: Int
    var job: String
    var name: String
    var profilePath: String?
}

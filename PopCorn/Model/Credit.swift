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

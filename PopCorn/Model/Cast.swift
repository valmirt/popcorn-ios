//
//  Cast.swift
//  PopCorn
//
//  Created by Valmir Junior on 19/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

struct Cast: Decodable {
    var character: String
    var id: Int
    var name: String
    var profilePath: String?
}

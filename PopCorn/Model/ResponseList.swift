//
//  ResponseList.swift
//  PopCorn
//
//  Created by Valmir Torres on 29/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ResponseList <T: Decodable> : Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [T]
}

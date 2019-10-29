//
//  ProdTVShowRepository.swift
//  PopCorn
//
//  Created by Valmir Torres on 24/10/19.
//  Copyright © 2019 Valmir Torres. All rights reserved.
//

import Foundation

struct ProdTVShowRepository: TVShowRepository {
    var delegate: TVShowManagerDelegate?
    let api: NetworkManager
    
    init(_ api: NetworkManager = ProdNetworkManager.shared) {
        self.api = api
    }
}
